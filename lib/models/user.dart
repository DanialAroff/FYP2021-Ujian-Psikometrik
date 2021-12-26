class MyUser {
  final String uid;
  final String fullName;
  final String email;
  final String userRole;

  MyUser({this.uid, this.fullName, this.email, this.userRole});

  // not using this currently
  MyUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        fullName = data['name'],
        email = data['email'],
        userRole = data['user_role'];

  MyUser.fromMap(Map data)
      : uid = 'uid',
        fullName = data['name'],
        email = data['email'],
        userRole = data['user_role'];
}
