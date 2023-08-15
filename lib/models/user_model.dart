// class UserModel {
//   late List<User> _user;
//   List<User> get user => _user;

//   UserModel.fromJson(Map<String, dynamic> json) {
//     if (json['user'] != null) {
//       _user = <User>[];
//       json['user'].forEach((v) {
//         _user.add(User.fromJson(v));
//       });
//     }
//   }
// }
// //  _products = <ProductModel>[];
// //       json['products'].forEach((v) {
// //         _products.add(ProductModel.fromJson(v));
// //       });

// class User {
//   int? id;
//   String? name;
//   String? email;
//   String? image;

//   User(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.image});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? 1;
//     name = json['name'] ?? '';
//     email = json['email'] ?? "";
//     image = json['image'] ?? "";
//   }
// }

class User {
  // ignore: unused_field

  late List<UserModle> _user;
  List<UserModle> get users => _user;

  User({required user}) {
    user = user;
  }

  User.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      _user = <UserModle>[];
      json['user'].forEach((v) {
        _user.add(UserModle.fromJson(v));
      });
    }
  }
}

class UserModle {
  int? id;
  String? id2;
  String? name;
  String? email;
  String? image;
  String? password;
  String? address;
  String? token;
  String? phone;
  List<dynamic>? cart;

  UserModle(
      {this.id2,
      this.id,
      this.name,
      this.email,
      this.image,
      this.password,
      this.address,
      this.token,
      this.cart,
      this.phone});

  UserModle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    address = json['address'];
    token = json['token'];
    // cart = List<Map<String, dynamic>>.from(
    //   json['cart']?.map(
    //     (x) => Map<String, dynamic>.from(x),
    //   ),
    // );
    phone = json['phone'] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'id': id,
      '_id': id2,
      'phone': phone
    };
  }
}
