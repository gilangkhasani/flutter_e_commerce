class CategoryClass {
  const CategoryClass({this.category_name, this.category_image, this.url, this.category_id});

  final String category_name;
  final String category_image;
  final String url;
  final int category_id;

  factory CategoryClass.fromJson(Map<String, dynamic> json) {
    return CategoryClass(
      category_name: json['category_name'] as String,
      category_id: json['category_id'] as int,
      category_image: json['category_image'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    "category_name": category_name,
    "category_id": category_id,
    "category_image": category_image,
  };
}