import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/TagNumberModel.dart';

class TagNumberServices {
  static Future<TagNumberModel> tagNo(String tagNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/GetAssetMasterEncodeAssetCaptureById";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
    };

    final body = {"TagNumber": tagNumber};

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return TagNumberModel.fromJson(data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }
}
