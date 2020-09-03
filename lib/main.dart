import 'package:camera/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: FirstPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String name;

  String description;

  GlobalKey<FormState> mykey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Form(
        key: mykey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
           padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
              child: Text("WELCOME TO THE GALERIA",textAlign: TextAlign.center,maxLines: 2,style: TextStyle(color: Colors.amber,fontSize: 25,),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 5, 20, 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(

                  width: 280,
                  color: Colors.white,
                  child: TextFormField(
                  decoration: InputDecoration(hintText: "YOUR NAME",contentPadding: EdgeInsets.all(10)),
                   validator: (String value){
                    if(value.isEmpty){
                      return "enter your name";
                    }
                    return null;
                   },
                    onSaved: (String value){
                    setState(() {
                      name=value;
                    });
                    },
                ),
              ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 5, 20, 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(

                  width: 280,
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "ONE LINE DESCRIPTION OF YOU",contentPadding: EdgeInsets.all(10)),
                    validator: (String value){
                      if(value.isEmpty){
                        return "Try something";
                      }
                      return null;
                    },
                    onSaved: (String value){
                      setState(() {
                        description=value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              color: Colors.amber,
              child: Text("PROCEED"),
              onPressed: (){
                mykey.currentState.save();
                if(mykey.currentState.validate()){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage(name,description)));
                }
              },
            ),
            SizedBox(height: 100,),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
              child: Text("UPLOAD IMAGES FROM CAMERA AND DRIVE TO CREATE YOUR ALBUMS",maxLines: 2,textAlign:TextAlign.center,style: TextStyle(color: Colors.amber,fontSize: 12),),
            )



          ],
        ),
      ),


    );
  }
}
