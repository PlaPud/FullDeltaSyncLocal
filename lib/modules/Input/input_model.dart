class SKU {
  final String? title;
  final String? aliasTitle;
  final String? barcode;
  final String? sku;
  final double? price;
  final int? remainInStock;

  SKU(
      {this.title,
      this.aliasTitle,
      this.barcode,
      this.sku,
      this.price,
      this.remainInStock});

  SKU.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        aliasTitle = json['aliasTitle'],
        barcode = json['barcode'],
        sku = json['sku'],
        price = json['price'],
        remainInStock = json['remainInStock'];

  Map<String, dynamic> toJson() => {
        "title": title,
        "aliasTitle": aliasTitle,
        "barcode": barcode,
        "sku": sku,
        "price": price,
        "remainInStock": remainInStock
      };
}
