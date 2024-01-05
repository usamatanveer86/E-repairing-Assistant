import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase{
  SharedPreferences? sharedPreferences;

   getData({String? key})async {
sharedPreferences=await SharedPreferences.getInstance();
return  sharedPreferences!.getString(key!);
  }
  setData({String? key,String? value})async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setString(key!, value!);
  }
  removeData({String? key})async {
    sharedPreferences=await SharedPreferences.getInstance();
    return  sharedPreferences!.remove(key!);
  }
}