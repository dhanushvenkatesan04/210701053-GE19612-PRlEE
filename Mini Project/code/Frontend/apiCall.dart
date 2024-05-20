import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pree/provider/loginuid.dart';

class apiCall {
  static var baseurl = "http://192.168.56.1/api/";

  static Future<int> login(String email, String pass, loginuid a) async {
    var url = Uri.parse("${baseurl}donor");

    var jsonData = {"emailId": email, "password": pass};
    try {
      final res = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(jsonData));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        var donorData = data["donor"];
        String organisationName = donorData["organisationName"];
        print(organisationName);
        a.setUser_org(organisationName);
        a.setUser_name(donorData["name"]);
        a.setId(donorData["_id"]);
        a.setemail(donorData["emailId"]);
        if (donorData["isDonor"])
          a.setRole("1");
        else
          a.setRole("0");
        print(data.runtimeType);
        print(data);
        return 1;
      } else {
        print(res.statusCode);
        print("Failed to connect");
        return 0;
      }
    } catch (e) {
      print("Error: $e");
      return 0;
    }
  }

  static Future<List<dynamic>?> getFood() async {
    var url = Uri.parse("${baseurl}/foodItemsWithStatusMinusOne");
    try {
      final res1 = await http.post(url);
      print(res1);
      if (res1.statusCode == 200) {
        List data = jsonDecode(res1.body.toString());
        print(res1.body.toString());
        print(data);
        return data;
      } else {
        print(res1.statusCode);
        print("failed to connect");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static postFood(
    String email,
    String fName,
    String fQuan,
    String org_name,
    String loc,
  ) async {
    var url = Uri.parse("${baseurl}addfood");

    final res = await http.post(url, body: {
      "emailId": email,
      "quantity": fQuan,
      "foodName": fName,
      "organisationName": org_name,
      "quantity": fQuan,
      "location": loc,
      "link": "not avail",
      "recv_emailId": "not avail"
    });

    try {
      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print(data);
        return 1;
      } else {
        print("failed to connect");
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }
}
