import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nyoba/models/LoginModel.dart';
import 'package:nyoba/services/RegisterAPI.dart';
import 'package:nyoba/utils/utility.dart';

class PointProvider with ChangeNotifier {
  LoginModel userLogin;
  bool loading = false;
  String message;

  Future<Map<String, dynamic>> signUp(
      {firstname, lastname, email, username, password, phoneNumber}) async {
    var result;
    await RegisterAPI()
        .register(firstname, lastname, email, username, password, phoneNumber)
        .then((data) {
      result = data;
      loading = false;
      notifyListeners();
      printLog(result.toString());
    });
    return result;
  }
}
