import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fidigames/addGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';


class listgames extends StatefulWidget {
  static String categories;
  listgames(String category){
    categories = category;
  }

  @override
  _listgamesState createState() => _listgamesState();
}

class _listgamesState extends State<listgames> {
  String _dropDownValue;
  final firestoreInstance = FirebaseFirestore.instance;
  List<String> name = List<String>();
  List<String> description = List<String>();
  List<String> gameurl = List<String>();
  List<String> minimumcount = List<String>();
  List<String> maximumcount = List<String>();
  List<String> category = List<String>();
  List<String> image = List<String>();
  void initState() {
    super.initState();
    _dropDownValue = listgames.categories;
    name.clear();
    description.clear();
    gameurl.clear();
    minimumcount.clear();
    maximumcount.clear();
    category.clear();
    image.clear();
    onpress();

  }
  void onpress() {
    setState(() {
      FirebaseFirestore.instance
          .collection(_dropDownValue)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          name.add(doc["Name"]);
          description.add(doc["Description"]);
          gameurl.add(doc["GameUrl"]);
          minimumcount.add(doc["MinimumCount"]);
          maximumcount.add(doc["MaximumCount"]);
          category.add(doc["Category"]);
          image.add(doc["Image"]);
          print(doc["Name"]);
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return new Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.amber,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addGame()),
                  );
                },
                icon: Icon(Icons.add,color: Colors.black,),
                label: Text('Add Games',
                  style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 2.0.w
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              backgroundColor: Colors.black,
              body:
              SingleChildScrollView(
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Fidigames",
                              style: TextStyle(
                                  fontSize: 5.0.w, color: Colors.white),),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 30.0.w,
                                height: 5.0.h,
                                color: Colors.white10,
                                child: DropdownButton<String>(

                                  hint: _dropDownValue == null
                                      ? Text('Categories',style: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold
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
                                    setState(()  {
                                      _dropDownValue = newValue;
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => listgames(_dropDownValue))).whenComplete(initState);
                                    });

                                  },
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),


                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80.0.h,
                          child:SingleChildScrollView(
                            child: Column(
                              children: new List.generate(name.length,(index){
                                return Column(
                                  children: [
                                    Container(
                                        width: 95.0.w,
                                        height: 20.0.h,
                                        child: Card(
                                            color: Colors.white10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(12.0)
                                                )),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: new EdgeInsets.only(left: 4.0.w,top: 2.0.h),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: 20.0.w,
                                                            height: 10.0.h,
                                                            child:Image.network(image[index].toString(),fit: BoxFit.cover,) ,
                                                          ),
                                                          SizedBox(
                                                            height: 1.0.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              // Container(
                                                              //   width: 15.0.w,
                                                              //   height: 5.0.h,
                                                              //   child:
                                                              Center(
                                                                child: IconButton(
                                                                  icon: const Icon(Icons.favorite_border,color: Colors.amber,),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                    });
                                                                  },
                                                                ),
                                                              ) ,
                                                              //  ),
                                                              Text("240",style: TextStyle(color: Colors.white),)

                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 4.0.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: SingleChildScrollView(
                                                                  scrollDirection: Axis.horizontal,
                                                                  child: Text(name[index].toString(),style: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),)),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width:60.0.w,
                                                          child: SingleChildScrollView(
                                                              scrollDirection: Axis.horizontal,child: Text(description[index].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 3.0.w,),)),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 8.0.h,
                                                      width: 65.0.w,
                                                      child: Row(
                                                        children: [
                                                          Expanded(flex: 1,child: Text(""),),
                                                          Expanded(flex:2,
                                                            child: RaisedButton(
                                                              onPressed: (){
                                                                Toast.show("COMMING SOON", context,
                                                                    duration: Toast.LENGTH_LONG,
                                                                    gravity: Toast.CENTER,
                                                                    backgroundColor: Colors.amber,
                                                                    textColor: Colors.black);
                                                                // Navigator.push(
                                                                //   context,
                                                                //   MaterialPageRoute(builder: (context) => listgames(_dropDownValue)),
                                                                // );
                                                              }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                              elevation: 10.0,
                                                              color: Colors.amber,
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 3.0.w,
                                                                  ),
                                                                  Icon(
                                                                    Icons.play_arrow,
                                                                    color: Colors.black,
                                                                    size: 4.0.w,
                                                                  ),
                                                                  Text('Play',
                                                                    style: TextStyle(
                                                                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 3.0.w
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(flex:3,
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 3.0.w,
                                                                  ),
                                                                  Icon(
                                                                    Icons.people_alt_outlined,
                                                                    color: Colors.amber,
                                                                    size: 4.0.w,
                                                                  ),
                                                                  Text(minimumcount[index],
                                                                    style: TextStyle(
                                                                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 2.0.w
                                                                    ),
                                                                  ),
                                                                  Text(' - ',
                                                                    style: TextStyle(
                                                                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 2.0.w
                                                                    ),
                                                                  ),
                                                                  Text(maximumcount[index],
                                                                    style: TextStyle(
                                                                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 2.0.w
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                  ],
                                );
                              }),
                              //   for (var name in list) {
                              // return new Text(name);
                              // }
                            ),
                          ),
                        )

                      ],
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
