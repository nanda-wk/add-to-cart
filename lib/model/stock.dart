class Stock {
  int?stockId;
  String stockName;
  String? stockDescription;
  int quantity;
  int buyPrice;
  int salePrice;
  int shopId;

  Stock({
    this.stockId,
    required this.stockName,
    this.stockDescription,
    required this.quantity,
    required this.buyPrice,
    required this.salePrice,
    required this.shopId,
  });

  Map<String, dynamic> toMap() {
    return {
      'stockId': stockId,
      'stockName': stockName,
      'stockDescription': stockDescription,
      'quantity': quantity,
      'buyPrice': buyPrice,
      'salePrice': salePrice,
      'shopId': shopId,
    };
  }

  fromMap(Map<String, dynamic> map) {
    return Stock(
      stockId: map['stockId'] as int,
      stockName: map['stockName'] as String,
      stockDescription: map['stockDescription'] as String,
      quantity: map['quantity'] as int,
      buyPrice: map['buyPrice'] as int,
      salePrice: map['salePrice'] as int,
      shopId: map['shopId'] as int,
    );
  }
}

List<Stock> stockList = [
  Stock(
    stockId: 1,
    stockName: 'Widget A',
    stockDescription: 'A high-quality widget',
    quantity: 100,
    buyPrice: 10,
    salePrice: 20,
    shopId: 101,
  ),
  Stock(
    stockId: 2,
    stockName: 'Gadget B',
    stockDescription: 'An innovative gadget',
    quantity: 50,
    buyPrice: 25,
    salePrice: 40,
    shopId: 102,
  ),
  Stock(
    stockId: 3,
    stockName: 'Accessory C',
    stockDescription: 'A popular accessory',
    quantity: 75,
    buyPrice: 5,
    salePrice: 15,
    shopId: 103,
  ),
  Stock(
    stockId: 4,
    stockName: 'Tool D',
    stockDescription: 'A versatile tool',
    quantity: 3,
    buyPrice: 50,
    salePrice: 70,
    shopId: 104,
  ),
  Stock(
    stockId: 5,
    stockName: 'Electronic E',
    stockDescription: 'Cutting-edge electronics',
    quantity: 60,
    buyPrice: 100,
    salePrice: 150,
    shopId: 105,
  ),
  Stock(
    stockId: 6,
    stockName: 'Material F',
    stockDescription: 'Durable building material',
    quantity: 200,
    buyPrice: 15,
    salePrice: 25,
    shopId: 106,
  ),
  Stock(
    stockId: 7,
    stockName: 'Clothing G',
    stockDescription: 'Fashionable clothing item',
    quantity: 80,
    buyPrice: 30,
    salePrice: 60,
    shopId: 107,
  ),
  Stock(
    stockId: 8,
    stockName: 'Accessory H',
    stockDescription: 'Stylish accessory',
    quantity: 120,
    buyPrice: 8,
    salePrice: 18,
    shopId: 109,
  ),
  Stock(
    stockId: 9,
    stockName: 'Tool I',
    stockDescription: 'Handy tool',
    quantity: 40,
    buyPrice: 45,
    salePrice: 65,
    shopId: 109,
  ),
  Stock(
    stockId: 9,
    stockName: 'Tool I',
    stockDescription: 'Handy tool',
    quantity: 90,
    buyPrice: 60,
    salePrice: 100,
    shopId: 110,
  ),
  Stock(
    stockId: 11,
    stockName: 'Widget K',
    stockDescription: 'Affordable widget',
    quantity: 150,
    buyPrice: 12,
    salePrice: 22,
    shopId: 111,
  ),
  Stock(
    stockId: 12,
    stockName: 'Material L',
    stockDescription: 'Construction material',
    quantity: 70,
    buyPrice: 20,
    salePrice: 35,
    shopId: 112,
  ),
  Stock(
    stockId: 13,
    stockName: 'Clothing M',
    stockDescription: 'Casual clothing item',
    quantity: 110,
    buyPrice: 35,
    salePrice: 70,
    shopId: 113,
  ),
  Stock(
    stockId: 14,
    stockName: 'Electronic N',
    stockDescription: 'Advanced electronics',
    quantity: 45,
    buyPrice: 120,
    salePrice: 180,
    shopId: 114,
  ),
  Stock(
    stockId: 15,
    stockName: 'Accessory O',
    stockDescription: 'Trendy accessory',
    quantity: 85,
    buyPrice: 10,
    salePrice: 25,
    shopId: 115,
  ),
  Stock(
    stockId: 15,
    stockName: 'Accessory O',
    stockDescription: 'Trendy accessory',
    quantity: 70,
    buyPrice: 12,
    salePrice: 35,
    shopId: 116,
  ),
];
