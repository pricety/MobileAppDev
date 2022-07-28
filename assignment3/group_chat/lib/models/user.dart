class User {
  final String id;
  final String firstname;
  final String lastname;
  final String username;
  final String bio;
  final DateTime? date;

  User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.username,
      required this.bio,
      this.date});

  factory User.fromJson(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      firstname: data[_firstNameKey],
      lastname: data[_lastNameKey],
      username: data[_nameKey],
      bio: data[_bioKey],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      _nameKey: username,
      _firstNameKey: firstname,
      _lastNameKey: lastname,
      _bioKey: bio,
    };
  }
}

const String _firstNameKey = "firstname";
const String _lastNameKey = "lastname";
const String _nameKey = "username";
const String _bioKey = "bio";
