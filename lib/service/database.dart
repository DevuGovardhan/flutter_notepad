import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addNote(Map<String, dynamic> notes,String id)async{
return await FirebaseFirestore.instance.collection("Notes").doc(id).set(notes);
  }

Future<Stream<QuerySnapshot>> getnotes()async{
return await FirebaseFirestore.instance.collection("Notes").snapshots();
}

Future updatenote(String id,Map<String, dynamic> noteinfo)async{
 return await FirebaseFirestore.instance.collection("Notes").doc(id).update(noteinfo);
}
Future deleteenote(String id)async{
 return await FirebaseFirestore.instance.collection("Notes").doc(id).delete();
}

}