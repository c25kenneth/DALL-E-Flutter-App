import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'apikey.dart';
import 'APIFunctions.dart';
import 'package:http/http.dart' as http;

class ImageVariationBody extends StatefulWidget {
  String imageURI;
  ImageVariationBody({Key? key, required this.imageURI}) : super(key: key);

  @override
  State<ImageVariationBody> createState() => _ImageVariationBodyState();
}

class _ImageVariationBodyState extends State<ImageVariationBody> {
  String userPrompt = "";
  String myAPIKey = apiKey;
  String image = "";
  Future<File> getImage() async {
    final response = await http.get(Uri.parse(widget.imageURI));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetest.PNG'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red, title: Text("Image Variation Screen!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.network(widget.imageURI),
              height: 300,
              width: 300,
              margin: EdgeInsets.all(25),
            ),
            SizedBox(height: 35),
            MaterialButton(
              color: Colors.red,
              onPressed: () async {
                dynamic response = await imageVariation(await getImage());
                setState(() {
                  widget.imageURI = response["data"][0]["url"];
                });
                // setState(() {
                //   widget.photo = response["data"][0]["url"];
                // });
              },
              child: Text("Click to make image variation!"),
            ),
          ],
        ),
      ),
    );
  }
}
