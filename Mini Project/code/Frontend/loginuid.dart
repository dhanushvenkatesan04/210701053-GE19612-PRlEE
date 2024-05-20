import 'package:flutter/cupertino.dart';

class loginuid extends ChangeNotifier {
  String email = "";

  String user_id = "";
  String role = "";
  String User_name = "";
  String User_Org = "";
  void setemail(String mail) {
    email = mail;
    notifyListeners();
  }

  void setId(String usrid) {
    user_id = usrid;
    notifyListeners();
  }

  void setRole(String role) {
    this.role = role;
    notifyListeners();
  }

  void setUser_name(String name) {
    this.User_name = name;
  }
  void setUser_org(String org) {
    this.User_Org = org;
  }
}
