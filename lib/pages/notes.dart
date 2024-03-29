import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notepad/service/database.dart';
import 'package:random_string/random_string.dart';

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  TextEditingController titlecomtroller=new TextEditingController();
  TextEditingController notecontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          Text("ADD NOTE",style: TextStyle(color: Colors.blueGrey,fontSize: 25,fontWeight: FontWeight.bold)),
        ],
        ),
      ),
      body: (
        Container(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
          TextFormField(
            style: TextStyle(
              color:Colors.grey,
              fontSize:30,
            ),
            controller: titlecomtroller,
            decoration: const InputDecoration(
        border:InputBorder.none,
        hintText: '              Title'
            ),
        
          ),
          SizedBox(height:30),

          TextFormField(
            style: TextStyle(
              color:Colors.grey,
              fontSize:30,
            ),
            controller: notecontroller,
            decoration: const InputDecoration(
        border:InputBorder.none,
        hintText: 'Notes'
            ),
        
          ),
          SizedBox(height: 25,),
          Center(
            child: ElevatedButton(onPressed: ()async{
              String id= randomAlphaNumeric(10);
              Map<String,dynamic> notes ={
                "Title":titlecomtroller.text,
                "Notes":notecontroller.text,
                "ID":id,
              };
              await DatabaseMethods().addNote(notes, id).then((value) {
                Fluttertoast.showToast(
        msg: "Notes has added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
              });
            }, child: Text("Add",style:TextStyle(fontSize: 25))))
        ],
        ),)
      ),
      
    );
  }
}