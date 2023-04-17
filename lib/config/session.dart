import 'package:shared_preferences/shared_preferences.dart';

class Session {
  SharedPreferences? prefs;
  String? id;
  String? name;

  Session({
    this.id,
    this.name,
  });

  Future user() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs!.getString('id');
    name = prefs!.getString('name');

    return {
      'id': id,
      'name': name,
    };
  }

  Future userSave(id, name) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('name', name.toString());
    prefs!.setString('id', id.toString());
  }

  Future userFlash() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove('name');
    return true;
  }

  Future isLogin() async {
    prefs = await SharedPreferences.getInstance();
    final mobile = prefs!.getString('name');
    if (mobile != null) {
      return true;
    }
    return false;
  }
}
