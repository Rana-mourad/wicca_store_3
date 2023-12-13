import 'package:flutter/material.dart';

class UserData {
  String? name;
  String? phoneNumber;

  UserData({this.name, this.phoneNumber});
}

class ProfileProvider extends ChangeNotifier {
  TextEditingController? nameController;
  TextEditingController? phoneController;

  UserData _userData = UserData();

  void init() {
    nameController = TextEditingController(text: _userData.name);
    phoneController = TextEditingController(text: _userData.phoneNumber);
  }

  @override
  void dispose() {
    nameController?.dispose();
    phoneController?.dispose();
    super.dispose();
  }

  void updateData() {
    _userData.name = nameController?.text;
    _userData.phoneNumber = phoneController?.text;

    print('Updated user data: $_userData');
    notifyListeners();
  }

  void setImageToFirebase() {
    print('Image uploaded to Firebase');
    notifyListeners();
  }
}
