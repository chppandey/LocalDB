class User {
  final int? id;
  final String? name;
  final String? email;
  final String? qualification;

  User({this.id, this.name, this.email, this.qualification});

  User.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        name = item["name"],
        email = item["email"],
        qualification = item['qlf'];

  Map<String, Object> toMap() {
    return {
      'id': id ?? "",
      'name': name ?? "",
      "email": email ?? "",
      "qlf": qualification ?? ""
    };
  }
}
