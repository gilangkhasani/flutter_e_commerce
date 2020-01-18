class OrderClass {
  OrderClass({this.order_id, this.order_date, this.quantity_order, this.product_id, this.product_name, this.category_id, this.product_description, this.product_image, this.product_price});

  int order_id;
  String order_date;
  int quantity_order;

   int product_id;
   int category_id;
   String product_name;
   String product_description;
   String product_image;
   int product_price;

  factory OrderClass.fromJson(Map<String, dynamic> json) {
    return OrderClass(
      order_id: json['order_id'],
      order_date: json['order_date'],
      quantity_order: json['quantity_order'],
      product_id: json['product_id'],
      product_name: json['product_name'],
      category_id: json['category_id'],
      product_description: json['product_description'],
      product_image: json['product_image'],
      product_price: json['product_price'],
    );
  }

  Map<String, dynamic> toMap() => {
    "order_id": order_id,
    "order_date": order_date,
    "quantity_order": quantity_order,
    "product_id": product_id,
    "product_name": product_name,
    "category_id": category_id,
    "product_description": product_description,
    "product_image": product_image,
    "product_price": product_price,
  };
}
