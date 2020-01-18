class Customer {

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;

  factory Customer.fromJson(Map<String, dynamic> data) => new Customer(
    id: data["id"],
    firstName: data["first_name"],
    lastName: data["last_name"],
    email: data["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email
  };

}