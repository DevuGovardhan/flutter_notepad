// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notepad/pages/notes.dart';
import 'package:notepad/service/database.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController titlecomtroller=new TextEditingController();
  TextEditingController notecontroller=new TextEditingController();

  Stream? NotesStream;
  getontheload()async{
    NotesStream=await DatabaseMethods().getnotes();
    setState(() {

    });
  }
  void initState(){
    getontheload();
    super.initState();
  }


  Widget allNotedetails(){
    return StreamBuilder(
      stream: NotesStream,
      builder:(context,AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context,index){
         DocumentSnapshot ds=snapshot.data.docs[index];
         return  Material(
              elevation: 7,
              borderRadius:BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration:BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(10) ),
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Title :"+ds["Title"],
                      style:TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold,fontSize: 20), 
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          titlecomtroller.text=ds["Title"];
                          notecontroller.text=ds["Notes"];
                          EditNote(ds["ID"]);
                        },
                        child: Icon(Icons.edit,color: Colors.black,)),
                        SizedBox(width: 10.0,),
                        GestureDetector(
                          onTap: ()async{
                            await DatabaseMethods().deleteenote(ds["ID"]);
                          },
                          child: Icon(Icons.delete,color: Colors.black,))
                      ],
                    ),
                    SizedBox(height: 10,),
                     Text("Note :"+ds["Notes"],
                    style:TextStyle(color: Color.fromARGB(255, 225, 169, 84), fontWeight: FontWeight.bold,fontSize: 20), )
                  ],
                ),

              ),
            );
        })
        : Container();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>notes()));},
      child: Icon(Icons.add), ),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          Text("NOTEPAD APP",style: TextStyle(color: Colors.blueGrey,fontSize: 25,fontWeight: FontWeight.bold)),

        ],
        ),
      ),
      body: Container(
        margin:EdgeInsets.only(left: 10,right: 10,top: 10),
        child:Column(children:[
          Expanded(child: allNotedetails()),
        ],
        ),
      ),
      
    );
  }

  Future EditNote(String id)=> showDialog(context:context,builder: (context)=>AlertDialog(
    content: Container(
      child: Column(children: [
        Row(children: [

          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel)),
            SizedBox(width: 70,),
            Text(
              "Edit",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 15,
              ),
            ),

            Text(
              "Details",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 15,
              ),
            ),
        ],),
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

          ElevatedButton(onPressed: () async {
            Map<String, dynamic> noteinfo={
              "ID":id,
              "Notes" :notecontroller.text,
              "Title": titlecomtroller.text,
            };
            await DatabaseMethods().updatenote(id, noteinfo).then((value) {
                Navigator.pop(context);
            });
          },child:Text("Update"))
      ],),
    ),
  ));
}