class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Company company;

  User(
      {this.id = 0,
      this.name = "",
      this.username = "",
      this.email = "",
      this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        company: Company.fromJson(json['company']));
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({this.name, this.catchPhrase, this.bs});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json['name'], catchPhrase: json['catchPhrase'], bs: json['bs']);
  }
}
