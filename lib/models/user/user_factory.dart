import 'package:nom_order/models/user/user_data.dart';

class UserFactory {

  static UserData getUserFromString(String string) {
    final List<String> values = string.split("::");
    //if (values.length != 3) throw Exception("Length not correct");
    return UserData(
      uid: values[0],
      name: values[1],
      email: values[2],
    );
  }
}