import 'package:add_to_cart/constants.dart';
import 'package:add_to_cart/model/stock.dart';
import 'package:add_to_cart/utils/message_util.dart';
import 'package:add_to_cart/views/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get_storage/get_storage.dart';
import 'stock_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var getStorage = GetStorage();
  List<Stock> cartItems = [];
  List<Stock> listStock = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    var getStorage = GetStorage();
    getStorage.write(STOCK_LIST, stockList);
    getStorage.write(ITEM_COUNT, cartItems.length);
    listStock = getStorage.read(STOCK_LIST);
  }

  void addToCart(BuildContext context, Stock stock) {
    Stock resultStock = listStock.firstWhere((element) =>
        element.stockId == stock.stockId && element.shopId == stock.shopId);
    if (resultStock.quantity < 1) {
      MessageBoxUtil(titleText: "No Stock left.", color: Colors.redAccent)
          .showSnackBarMessage(context);
    } else {
      resultStock.quantity -= 1;
      listStock[listStock.indexOf(resultStock)] = resultStock;
      cartItems.add(stock);
      getStorage.write(CART_ITEM, cartItems);
      getStorage.write(ITEM_COUNT, cartItems.length);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Stock List"),
            badges.Badge(
              badgeContent: Text(
                getStorage.read(ITEM_COUNT).toString(),
                style: const TextStyle(color: Colors.white),
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Color(0xFF213555),
              ),
              position: badges.BadgePosition.topEnd(top: 1, end: 1),
              child: IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyCart(),
                    ),
                  );
                  if(getStorage.read(ITEM_COUNT) == null || getStorage.read(ITEM_COUNT) == 0) {
                    cartItems = [];
                  }
                  loadData();
                  setState(() {});
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        // childAspectRatio: 0.74,
        childAspectRatio: 0.65,
        children: listStock
            .map(
              (stock) => StockUI(
                stock: stock,
                onAddBtn: addToCart,
              ),
            )
            .toList(),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
