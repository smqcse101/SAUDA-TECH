import 'dart:io';
import 'package:camera/lastpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class HomePage extends StatefulWidget {
  String name;
  String description;

  HomePage(this.name,this.description);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>   with SingleTickerProviderStateMixin {


  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }


  File dp;
  List<File> photo=[];

  void _pickFromGallery() async {
    PickedFile _pickedfilefromgallery =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      photo.add(File(_pickedfilefromgallery.path));
    });
  }
  void _forDp() async {
    PickedFile pickedFromGallery=   await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      dp=File(pickedFromGallery.path);
    });
  }
  void _pickFromCamera() async {
    PickedFile _pickedfilefromcamera =
    await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      photo.add(File(_pickedfilefromcamera.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.grey[900],

    body: Column(
      children: <Widget>[

        Container(
         padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
         color: Colors.grey[900],
         width: width,
         height: 200,
         child: Row(
           children: <Widget>[
             Stack(
               children: <Widget>[
                dp==null?CircleAvatar(
                  backgroundImage:AssetImage("assets/123.png"),
                  radius: 70,
                ):ClipOval(
                  child: CircleAvatar(
                    radius: 70,
                     child: Image.file(dp,fit:BoxFit.fill,),
                  ),
                ),
                 
                 Positioned(
                   top: 110,
                   left: 100,
                   child: GestureDetector(
                     onTap: () { _forDp();},
                     child:Container(width: 30,color: Colors.amber,child: Center(child: Text("+",style: TextStyle(fontSize: 18),),)),
                   )
                 ),
               ],
             ),
             SizedBox(width: 15,),
             Padding(
               padding: const EdgeInsets.fromLTRB(5,60,2,5),
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Container(width: 200,child: Text(widget.name,maxLines:2,style: TextStyle(color: Colors.white,fontSize: 18,fontStyle: FontStyle.normal),)),
                   SizedBox(height: 50,),
                   Container(width: 200,child: Text(widget.description,maxLines:2,style: TextStyle(color: Colors.white,fontSize: 12,fontStyle: FontStyle.italic),)),

                 ],
               ),
             )
           ],
         ),
       ),
        Container(
            color: Colors.grey[700],
            width: width,
          child: TabBar(
            controller: _controller,
           indicatorWeight:3,
            indicatorColor: Colors.white,

            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.grid_on,color: Colors.white,),
              ),
              Tab(
                icon: const Icon(Icons.collections,color: Colors.white,),
              ),
            ],
          )
        ),
        Container(
          height: 490,
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              Container(
                width: 250,
                height: 400,
                child: photo.length==0?Container(child: Center(child: Text("NOTHING HERE !!!",style:TextStyle(color: Colors.white),),),): GridView.count(crossAxisCount: 2,
                    children:List.generate(photo.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Lastpage(photo[index])));
                        },
                        child: Card(
                          child: Image.file(photo[index],fit: BoxFit.cover,),
                        ),
                      );

                    })
                ),
              ),
              Container(
                width: 250,
                height: 400,
                child: photo.length==0?Container(child: Center(child: Text("NOTHING HERE !!!",style:TextStyle(color: Colors.white),),),)
                    :ListView.builder(itemBuilder: (context,index){

                      return  Container(

                        child: Image.file(photo[index],fit: BoxFit.cover,),
                      );

                },itemCount: photo.length,)

              ),

            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton.icon(onPressed: (){_pickFromCamera();}, icon: Icon(Icons.camera_alt), label:Text("Upload from Camera")),
            RaisedButton.icon(onPressed: (){_pickFromGallery();}, icon: Icon(Icons.photo), label:Text("Upload from Gallery")),
          ],

        )
      ],
    )
    );
  }
}
