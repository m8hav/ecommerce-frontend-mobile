class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      };

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, role: $role}';
  }

  static List<User> mockUsers = [
    User(
      id: 1,
      name: 'John Doe',
      email: 'john@gmail.com',
      password: null,
      role: 'admin',
    ),
    User(
      id: 2,
      name: 'Jane Doe',
      email: 'jane@gmail.com',
      password: null,
      role: 'user',
    ),
  ];
}
