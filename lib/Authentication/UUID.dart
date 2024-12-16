class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();
  String? userId;

  UserSingleton._internal();

  static UserSingleton get instance => _instance;

  void setUserId(String? id) {
    userId = id;
  }

  String? getUserId() {
    return userId;
  }
}