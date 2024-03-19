import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDmzGJfsZHv3X6ArYMgy-Zd41rQDdfDuEA", 
      appId: "1:730259804465:web:767b56ebaeeebc315ee010", 
      messagingSenderId: "730259804465", 
      projectId: "fir-flutter-4793b")
  );
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   String? studentName, studentId, programId;
   double? gpa;

   getStudentName(name){
    this.studentName=name;
   }
   getStudentId(id){
    this.studentId=id;
   }
   getStudyProgramId(programId){
    this.programId=programId;
   }
   getGPA(gpa){
    this.gpa=double.parse(gpa);
   }
   CreateData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("student").doc(studentName);
    Map<String,dynamic> students={
       "studentName":studentName,
       "studentId": studentId,
       "studyProgramId": programId,
       "studentGPA": gpa
    };
    documentReference.set(students);
   }
   ReadData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("student").doc(studentName);
    documentReference.get().then((value) {
      
    });
   }
   UpdateData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("student").doc(studentName);
    Map<String,dynamic> students={
       "studentName":studentName,
       "studentId": studentId,
       "studyProgramId": programId,
       "studentGPA": gpa
    };
    documentReference.set(students);
   }
   DeleteData(){
    DocumentReference documentReference =FirebaseFirestore.instance.collection("student").doc(studentName);
    documentReference.delete();
   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("FLUTTER FIREBASE CRUD"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: TextFormField(
                  onChanged: (String name){
                    getStudentName(name);
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                      )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue
                      )
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: TextFormField(
                  onChanged: (String id){
                    getStudentId(id);
                  },
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                      )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue
                      )
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: TextFormField(
                  onChanged: (String programId){
                    getStudyProgramId(programId);
                  },
                  decoration: InputDecoration(
                    labelText: "Study program ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                      )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue
                      )
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: TextFormField(
                  onChanged: (String gpa){
                    getGPA(gpa);
                  },
                  decoration: InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                      )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue
                      )
                    )
                  ),
                ),
                
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    
                    onPressed: (){
                      CreateData();
                    }, 
                    child: Text("Create")),
                  ElevatedButton(
                    
                    onPressed: (){
                      ReadData();
                    }, 
                    child: Text("Read")),
                    ElevatedButton(
                    
                    onPressed: (){
                      UpdateData();
                    }, 
                    child: Text("Update")),
                    ElevatedButton(
                    
                    onPressed: (){
                      DeleteData();
                    }, 
                    child: Text("Delete"))
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("student").snapshots(), 
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot<Map<String, dynamic>>? documentSnapshot = snapshot.data?.docs[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(documentSnapshot?["studentName"]),
                                Text(documentSnapshot?["studentId"]),
                                Text(documentSnapshot?["studyProgramId"]),
                                Text(documentSnapshot!["studentGPA"].toString())
                              ],
                            ),
                          ),
                        );
                      },
                      );
                  }
                  return CircularProgressIndicator();
                },)
            ],
          ),
        ),
      )    );
  }
}
