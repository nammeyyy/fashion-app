class User {
  late String _username;
  late String _email;
  late String _imagePath;

  User (this._username, this._email) {
    this._imagePath = "";
  }

  User.fromJson(Map<String, Object?> json) {
    _username = json['username'] as String;
    _email = json['email'] as String;
    _imagePath = json['profile image'] as String;
  }

  User.withAllData(String? username, String? email, String? image) {
    username??_username;
    email??_email; 
    image??_imagePath;
  }

  User copyWith (String? username, String? email, String? image) {
    return User.withAllData(username??_username, email??_email, image??_imagePath);
  }

  Map<String, Object?>toJson() {
    return {
      'username':_username, 'email':_email, 'profile image':_imagePath
    };
  }

  String getUsername() {
    return _username;
  }
  String getEmail() {
    return _email;
  }
  String getProfileImage() {
    return _imagePath;
  }
  
  void setUsername(String username) {
    _username = username;
  }
  void setEmail(String email) {
    _email = email;
  }
  void setProfileImage(String image) {
    _imagePath = image;
  }
}