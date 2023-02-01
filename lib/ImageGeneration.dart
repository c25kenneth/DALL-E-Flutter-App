import 'package:dalle_flutter/APIFunctions.dart';
import 'package:dalle_flutter/ImageVariation.dart';
import 'package:dalle_flutter/apikey.dart';
import "package:flutter/material.dart";

class ImageGenerationBody extends StatefulWidget {
  const ImageGenerationBody({Key? key}) : super(key: key);

  @override
  State<ImageGenerationBody> createState() => _ImageGenerationBodyState();
}

class _ImageGenerationBodyState extends State<ImageGenerationBody> {
  dynamic photo;
  String userPrompt = "";
  String myAPIKey = apiKey;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        photo == null
            ? Icon(
                Icons.photo,
                size: 130,
              )
            : Container(
                child: Image.network(photo),
                height: 300,
                width: 300,
                margin: EdgeInsets.all(25),
              ),
        SizedBox(height: 35),
        Container(
          width: 350,
          child: TextField(
              onChanged: (val) {
                setState(() {
                  userPrompt = val;
                });
              },
              obscureText: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      var response = await generateImage(userPrompt);
                      print(response["data"][0]["url"]);
                      setState(() {
                        photo = response["data"][0]["url"];
                      });
                    },
                  ),
                  hintText: "Enter Image Prompt Here",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)))),
        ),
        SizedBox(height: 17),
        (photo != null)
            ? Column(
                children: [
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ImageVariationBody(
                                    imageURI: photo,
                                  ))));
                    },
                    child: Text("Click for Image Variation!"),
                  ),
                ],
              )
            : SizedBox(height: 17.0),
      ],
    ));
  }
}
