import 'package:add_to_cart/constants.dart';
import 'package:add_to_cart/model/stock.dart';
import 'package:add_to_cart/views/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/message_util.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  var getStorage = GetStorage();
  List<Stock> cartStockList = [];
  List<Stock> listStock = [];
  Set<Stock> cartStockSet = {};
  Map<Stock, int> cartStockMap = <Stock, int>{};
  int totalPrice = 0;
  bool cartItemExist = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    listStock = getStorage.read(STOCK_LIST);
    cartStockList = getStorage.read(CART_ITEM) ?? [];
    cartItemExist = cartStockList.isNotEmpty;
    totalPrice = 0;
    if (cartStockList.isNotEmpty) {
      cartStockSet = {...cartStockList};
      for (Stock element in cartStockSet) {
        cartStockMap[element] = 0;
      }
      for (Stock element in cartStockList) {
        totalPrice += element.salePrice;
        if (cartStockMap.containsKey(element)) {
          cartStockMap[element] = (cartStockMap[element] ?? 0) + 1;
        }
      }
    }
  }

  void removeAllItem() {
    for (Stock stock in cartStockMap.keys) {
      Stock resultStock = listStock.firstWhere((element) =>
          element.stockId == stock.stockId && element.shopId == stock.shopId);
      resultStock.quantity += cartStockMap[stock]!;
      listStock[listStock.indexOf(resultStock)] = resultStock;
    }

    getStorage.remove(CART_ITEM);
    getStorage.write(ITEM_COUNT, 0);
    loadData();
    setState(() {});
  }

  void removeStock(Stock stock) {
    Stock resultStock = listStock.firstWhere((element) =>
        element.stockId == stock.stockId && element.shopId == stock.shopId);
    resultStock.quantity += cartStockMap[stock]!;
    listStock[listStock.indexOf(resultStock)] = resultStock;

    cartStockMap.remove(stock);
    cartStockList.removeWhere((element) => element == stock);
    getStorage.write(CART_ITEM, cartStockList);
    loadData();
    setState(() {});
  }

  void increment(Stock stock) {
    Stock resultStock = listStock.firstWhere((element) =>
        element.stockId == stock.stockId && element.shopId == stock.shopId);
    if (resultStock.quantity < 1) {
      MessageBoxUtil(titleText: "No Stock left.", color: Colors.redAccent)
          .showSnackBarMessage(context);
    } else {
      resultStock.quantity -= 1;
      listStock[listStock.indexOf(resultStock)] = resultStock;
      cartStockMap[resultStock] = (cartStockMap[resultStock] ?? 0) + 1;
      cartStockList.add(stock);
      loadData();
    }
    setState(() {});
  }

  void decrement(Stock stock) {
    Stock resultStock = listStock.firstWhere((element) =>
        element.stockId == stock.stockId && element.shopId == stock.shopId);
    if (cartStockMap[resultStock]! < 1) {
      cartStockMap.remove(resultStock);
    } else {
      resultStock.quantity += 1;
      listStock[listStock.indexOf(resultStock)] = resultStock;
      cartStockMap[resultStock] = (cartStockMap[resultStock] ?? 0) - 1;
      cartStockList.remove(stock);
      loadData();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Cart"),
            cartItemExist
                ? IconButton(
                    onPressed: () {
                      removeAllItem();
                    },
                    icon: const Icon(
                      Icons.cleaning_services_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      body: cartItemExist
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartStockMap.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          stock: cartStockMap.keys.elementAt(index),
                          stockQty: cartStockMap.values.elementAt(index),
                          onTabRemove: removeStock,
                          onTapIncrease: increment,
                          onTapDecrease: decrement,
                        );
                      }),
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total: (${cartStockMap.length} items)",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ $totalPrice",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Proceed To Checkout",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                "There is no item in the cart.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
