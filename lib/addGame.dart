import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fidigames/listgames.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloudinary_client/models/CloudinaryResponse.dart';
import 'package:toast/toast.dart';

class addGame extends StatefulWidget {
  @override
  _addGameState createState() => _addGameState();
}

class _addGameState extends State<addGame> {
  File imageURI = null;
  String _dropDownValue= "Action";
  String imageURL;
  final firestoreInstance = FirebaseFirestore.instance;

  String NAME,DESCRIPTION,GAMEURL,MINIMUMCOUNT,MAXIMUMCOUNT,CATEGORY,IMAGE;

  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController gameurl = new TextEditingController();
  TextEditingController minimumcount = new TextEditingController();
  TextEditingController maximumcount = new TextEditingController();

  String category = "Action";

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
    print("getImage");
    print(image);
    print(imageURI.path);
    String filename;
    int pos = image.toString().lastIndexOf("/")+1;
    filename = image.toString().substring(pos);
    print(filename);
    CloudinaryClient client = new CloudinaryClient('855599572171886', 'iYoA5vZgZKtgnPskGqvTXaaMxY8', 'nagaraj');
    CloudinaryResponse response = await client.uploadImage(imageURI.path, filename: filename,folder: 'testing');
    print(response.url);
    imageURL = response.url;
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),

                                  Text("Add a Game",
                                    style: TextStyle(
                                        fontSize: 5.0.w, color: Colors.white),),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 2.0.h
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: new EdgeInsets.only(left: 5.0.w),
                                child: Text(" Name of the Game",
                                  style: TextStyle(
                                      fontSize: 3.0.w, color: Colors.amber),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90.0.w,
                                    height: 7.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      color: Colors.white10,
                                      child: TextField(
                                        controller: name,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          //prefixText: '+91  ',
                                          labelStyle: TextStyle(color: Colors.white,fontSize: 3.0.w,fontWeight: FontWeight.bold),
                                          prefixStyle: TextStyle(color: Colors.white,fontSize: 3.0.w,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 2.0.h
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: new EdgeInsets.only(left: 5.0.w),
                                child: Text("Description",
                                  style: TextStyle(
                                      fontSize: 3.0.w, color: Colors.amber),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90.0.w,
                                    height: 15.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      color: Colors.white10,
                                      child: TextField(
                                        controller: description,
                                        maxLines: 6,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          //prefixText: '+91  ',
                                          labelStyle: TextStyle(color: Colors.white,fontSize: 3.0.w,fontWeight: FontWeight.bold),
                                          prefixStyle: TextStyle(color: Colors.white,fontSize: 3.0.w,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 2.0.h
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: new EdgeInsets.only(left: 5.0.w),
                                child: Text("Game URL",
                                  style: TextStyle(
                                      fontSize: 3.0.w, color: Colors.amber),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90.0.w,
                                    height: 7.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      color: Colors.white10,
                                      child: TextField(
                                        controller: gameurl,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                          prefixStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 2.0.h
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: new EdgeInsets.only(left: 5.0.w),
                                child: Text("Players Count",
                                  style: TextStyle(
                                      fontSize: 3.0.w, color: Colors.amber),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: new EdgeInsets.only(left: 5.0.w),
                                      child: Text("Minimum Count",
                                        style: TextStyle(
                                            fontSize: 3.0.w, color: Colors.amber),),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),

                                  Container(
                                    width: 10.0.w,
                                    height: 7.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12.0)
                                          )),
                                      color: Colors.white10,
                                      child: TextField(
                                        controller: minimumcount,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                          prefixStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: new EdgeInsets.only(left: 5.0.w),
                                      child: Text("Maximum Count",
                                        style: TextStyle(
                                            fontSize: 3.0.w, color: Colors.amber),),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),

                                  Container(
                                    width: 10.0.w,
                                    height: 7.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12.0)
                                          )),
                                      color: Colors.white10,
                                      child: TextField(
                                        controller: maximumcount,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                          prefixStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: new EdgeInsets.only(left: 5.0.w),
                                child: Text(" Category",
                                  style: TextStyle(
                                      fontSize: 3.0.w, color: Colors.amber),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90.0.w,
                                    height: 7.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      color: Colors.white10,
                                      child: DropdownButton<String>(

                                        hint: _dropDownValue == null
                                            ? Text('Categories',style: TextStyle(color: Colors.amber,fontSize: 3.0.w
                                        ),)
                                            : Text(
                                          _dropDownValue,
                                          style: TextStyle(color: Colors.white),
                                        ),

                                        focusColor: Colors.white,
                                        // hint: Text('Categories',style: TextStyle(color: Colors.white),),
                                        items: <String>['Action', 'Adventure', 'Arcade', 'Board','Card','Casino','Casual','Educational','Music','Puzzle','Racing','Role Playing','Simulation','Sports','Strategy','Trivia','Word'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _dropDownValue = newValue;
                                          });
                                        },
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90.0.w,
                                    height: 10.0.h,
//                                  color: Colors.black45,
                                    child: Card(
                                      color: Colors.white10,
                                      child: MaterialButton(
                                        onPressed: getImage,
                                        color: Colors.white10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(flex:1,child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.drive_folder_upload,
                                                    color: Colors.amber,
                                                    size: 4.0.w,
                                                  ),
                                                  Text('  Upload an image',style: TextStyle(color: Colors.amber,fontSize: 2.5.w),),
                                                ],
                                              )),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 8.0.h,
                                                  width: 100,
                                                  child:
                                                  imageURI == null
                                                      ? Center(child: new Text('No image selected.',style: TextStyle(color: Colors.amber,fontSize: 2.5.w),))
                                                      : new Image.file(imageURI),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7.0.h,
                            ),
                            Center(
                              child: SizedBox(
                                height: 5.0.h,
                                width: 25.0.w,
                                child: RaisedButton(
                                  onPressed: (){
                                    NAME = name.text;
                                    DESCRIPTION = description.text;
                                    GAMEURL = gameurl.text;
                                    MINIMUMCOUNT = minimumcount.text;
                                    MAXIMUMCOUNT = maximumcount.text;
                                    if(NAME.isEmpty||NAME==null){
                                      Toast.show("Please Enter Game Name", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    } else if(DESCRIPTION.isEmpty||DESCRIPTION==null){
                                      Toast.show("Please Enter Game Description", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    } else if(GAMEURL.isEmpty||GAMEURL==null){
                                      Toast.show("Please Enter Game Url", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    } else if(MINIMUMCOUNT.isEmpty || MINIMUMCOUNT == null){
                                      Toast.show("Please Enter Player Minimum Count", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    } else if (MAXIMUMCOUNT.isEmpty || MAXIMUMCOUNT == null){
                                      Toast.show("Please Enter Player Maximum Count", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    }else if(_dropDownValue.isEmpty||_dropDownValue==null){
                                      Toast.show("Please Select Category", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    }else if (imageURL==null){
                                      Toast.show("Please Select Image", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black);
                                    }
                                    else{
                                      firestoreInstance.collection(_dropDownValue).add(
                                          {
                                            "Name" : NAME,
                                            "Description" : DESCRIPTION,
                                            "Category" : CATEGORY,
                                            "GameUrl" : GAMEURL,
                                            "MinimumCount" : MINIMUMCOUNT,
                                            "MaximumCount" : MAXIMUMCOUNT,
                                            "Category" : _dropDownValue,
                                            "Image" : imageURL
                                          }).then((value){
                                        print(value.id);
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => listgames(category)),
                                      );
                                    }
                                  }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                  elevation: 10.0,
                                  color: Colors.amber,
                                  child: Text('Submit',
                                    style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 3.0.w
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
