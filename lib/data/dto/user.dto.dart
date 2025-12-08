class User {
  String _name;
  String _email;
  String _password;

  User(this._name, this._email, this._password);

  // ignore: unnecessary_getters_setters
  String get name => _name;

  set name(String value) {
    _name = value;
  }

  // ignore: unnecessary_getters_setters
  String get email => _email;

  set email(String value){
    _email = value;
  }

  // ignore: unnecessary_getters_setters
  String get password => _password;

  set password(String value){
    _password = value;
  }


  @override
  String toString() => 'User(name: $_name, email: $_email, password: $_password)';
}