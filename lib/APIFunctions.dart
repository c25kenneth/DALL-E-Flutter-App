import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'apikey.dart';

Future generateImage(String prompt) async {
  var url = Uri.https("api.openai.com", "/v1/images/generations");
  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey"
      },
      body: jsonEncode({"n": 1, "size": "512x512", "prompt": prompt}));

  // print(response.body);
  return jsonDecode(response.body);
}

Future imageVariation(File file) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("https://api.openai.com/v1/images/variations"));

  request.headers["Content-Type"] = "multipart/form-data";
  request.headers["Authorization"] = "Bearer $apiKey";

  request.fields["size"] = "512x512";

  request.files.add(http.MultipartFile.fromBytes(
      "image", File(file.path).readAsBytesSync(),
      filename: file.path));

  var res = await request.send();
  return jsonDecode(await res.stream.bytesToString());
}

Future editImage(File file, String prompt) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("https://api.openai.com/v1/images/edits"));

  request.headers["Content-Type"] = "multipart/form-data";
  request.headers["Authorization"] = "Bearer $apiKey";

  request.fields["size"] = "512x512";
  request.fields["prompt"] = prompt;

  request.files.add(http.MultipartFile.fromBytes(
      "image", File(file.path).readAsBytesSync(),
      filename: file.path));

  var res = await request.send();
  print(jsonDecode(await res.stream.bytesToString()));
  return jsonDecode(await res.stream.bytesToString());
}
