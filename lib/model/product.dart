class ProductClass {
  const ProductClass({this.product_id, this.product_name, this.category_id, this.product_description, this.product_image, this.product_price});

  final int product_id;
  final String product_name;
  final int category_id;
  final int product_price;
  final String product_description;
  final String product_image;

  factory ProductClass.fromJson(Map<String, dynamic> json) {
    return ProductClass(
      product_id: json['product_id'],
      product_name: json['product_name'],
      category_id: json['category_id'],
      product_description: json['product_description'],
      product_image: json['product_image'],
      product_price: json['product_price'],
    );
  }

  Map<String, dynamic> toMap() => {
    "product_id": product_id,
    "product_name": product_name,
    "category_id": category_id,
    "product_description": product_description,
    "product_image": product_image,
    "product_price": product_price,
  };
}
