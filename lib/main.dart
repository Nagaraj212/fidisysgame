import 'package:fidigames/listgames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
// import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  String category = "Action";

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.0.h,
                          ),
                          Text("Fidigames",
                            style: TextStyle(
                                fontSize: 6.0.w, color: Colors.white),),
                          SizedBox(
                            height: 10.0.h
                          ),
                          Text("Log In",
                            style: TextStyle(
                                fontSize: 4.0.w, color: Colors.white),),
                          SizedBox(
                              height: 3.0.h
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
                                      controller: email,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        //prefixText: '+91  ',
                                        labelText: 'Email',
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        prefixStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        hintText: 'Email',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                      controller: password,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,

                                        //prefixText: '+91  ',
                                        labelText: 'Password',
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        prefixStyle: TextStyle(color: Colors.white,fontSize: 4.0.w,fontWeight: FontWeight.bold),
                                        hintText: 'Password',
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
                                _email = email.text;
                                _password = password.text;
                                auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => listgames(category)));
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => listgames()),
                                // );
                              }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                              elevation: 10.0,
                              color: Colors.amber,
                              child: Text('Sign In',
                                style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 3.0.w
                                ),
                              ),
                            ),
                          ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Center(
                            child: SizedBox(
                              height: 5.0.h,
                              width: 25.0.w,
                              child: RaisedButton(
                                onPressed: (){
                                  _email = email.text;
                                  _password = password.text;
                                  auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => listgames(category)));
                                  });
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => listgames()),
                                  // );
                                }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                elevation: 10.0,
                                color: Colors.amber,
                                child: Text('Sign Up',
                                  style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 3.0.w
                                  ),
                                ),
                              ),
                            ),
                          )

                        ],
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

