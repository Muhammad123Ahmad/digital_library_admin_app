import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo_app/ui/post/show_post.dart';
import 'package:firestore_todo_app/utils/utils.dart';
import 'package:firestore_todo_app/widgets/round_button.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {


  //final databaseref = FirebaseDatabase.instance.ref('Post'); // creating refrence

  final fireStore = FirebaseFirestore.instance.collection('bookdetails');

  bool loading = false;

  final booknameController = TextEditingController();
  final bookcategoryController = TextEditingController();
  final bookdescriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Book Details',style: TextStyle(color: Colors.white),),
      backgroundColor: const Color(0xff8207ed),
      centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Form(
            key: _formkey,
            child: 
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              const SizedBox(height: 30,),
          
              const Text('Name',style: TextStyle(fontSize: 16),),
              TextFormField(
                controller: booknameController,
                maxLines: 1,
                decoration:const InputDecoration(
                hintText: "Enter book name",
                hintStyle: TextStyle(color: Color(0xff9E9E9E)),
                
                  //labelText: "bookname",
                  
                border: OutlineInputBorder(),  
                ),
                validator: (value){
            if (value!.isEmpty){
              return 'Enter book name';
            }
            return null;
          },
                
              ),
              const SizedBox(height: 20,),
          
              const Text('Category',style: TextStyle(fontSize: 16),),
              TextFormField(
                controller: bookcategoryController,
                maxLines: 1,
                decoration:const InputDecoration(
                hintText: "Enter book category",
                hintStyle: TextStyle(color: Color(0xff9E9E9E)),
                 
                border: OutlineInputBorder(),  
                ),
                validator: (value){
            if (value!.isEmpty){
              return 'Enter book category';
            }
            return null;
          },
                
              ),
              const SizedBox(height: 20,),
          
              const Text('Description',style: TextStyle(fontSize: 16),),
              TextFormField(
                controller: bookdescriptionController,
                maxLines: 4,
                decoration:const InputDecoration(
                hintText: "Enter book decription",
                hintStyle: TextStyle(color: Color(0xff9E9E9E)),
                border: OutlineInputBorder(),  
                ),
                validator: (value){
            if (value!.isEmpty){
              return 'Enter book description';
            }
            return null;
          },
                
              ),
          
              const SizedBox(height: 120,),
          
              RoundButton(
                
                title: 'Add Data', 
              loading: loading,
                onTap:(){
                  if (_formkey.currentState!.validate()){

                    setState(() {
                  loading = true;
                });

                    String id = DateTime.now().microsecondsSinceEpoch.toString();
          
              fireStore.doc(id).set({
                'BookName': booknameController.text.toString(),
                'BookCategory' :bookcategoryController.text.toString(),
                'BookDescription': bookdescriptionController.text.toString(),
              }).then((value) {
                booknameController.clear();
                bookcategoryController.clear();
                bookdescriptionController.clear();

                Utils().toastMessage('Data added sucessfully');
          
                setState(() {
                  loading = false;
                });
                
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString()); 
                setState(() {
                  loading = false;
                });
          
                booknameController.clear();
                bookcategoryController.clear();
                bookdescriptionController.clear();
          
              },);
                    

                  }
                
                
          
                
              
            }),
          
              const SizedBox(height: 10,),
          
              RoundButton(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ShowPostScreen()));
                }
              
              , title: 'Show Data')
          
          
            ],
          ),
          
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          
          //     const SizedBox(height: 30,),
          
          //     const Text('Name',style: TextStyle(fontSize: 16),),
          //     TextFormField(
          //       controller: booknameController,
          //       maxLines: 1,
          //       decoration:const InputDecoration(
          //       hintText: "Enter book name",
          //       hintStyle: TextStyle(color: Color(0xff9E9E9E)),
                
          //         //labelText: "bookname",
                  
          //       border: OutlineInputBorder(),  
          //       ),
                
          //     ),
          //     const SizedBox(height: 20,),
          
          //     const Text('Category',style: TextStyle(fontSize: 16),),
          //     TextFormField(
          //       controller: bookcategoryController,
          //       maxLines: 1,
          //       decoration:const InputDecoration(
          //       hintText: "Enter book category",
          //       hintStyle: TextStyle(color: Color(0xff9E9E9E)),
                 
          //       border: OutlineInputBorder(),  
          //       ),
                
          //     ),
          //     const SizedBox(height: 20,),
          
          //     const Text('Description',style: TextStyle(fontSize: 16),),
          //     TextFormField(
          //       controller: bookdescriptionController,
          //       maxLines: 4,
          //       decoration:const InputDecoration(
          //       hintText: "Enter book decription",
          //       hintStyle: TextStyle(color: Color(0xff9E9E9E)),
          //       border: OutlineInputBorder(),  
          //       ),
                
          //     ),
          
          //     const SizedBox(height: 120,),
          
          //     RoundButton(
          //       title: 'Add Data', 
          //     loading: loading,
          //       onTap:(){
                
          //       setState(() {
          //         loading = true;
          //       });
          
                
          //     String id = DateTime.now().microsecondsSinceEpoch.toString();
          
          //     fireStore.doc(id).set({
          //       'BookName': booknameController.text.toString(),
          //       'BookCategory' :bookcategoryController.text.toString(),
          //       'BookDescription': bookdescriptionController.text.toString(),
          //     }).then((value) {

          //       Utils().toastMessage('Data added sucessfully');
          
          //       setState(() {
          //         loading = false;
          //       });
                
          //     }).onError((error, stackTrace) {
          //       Utils().toastMessage(error.toString()); 
          //       setState(() {
          //         loading = false;
          //       });
          
          //       booknameController.clear();
          //       bookcategoryController.clear();
          //       bookdescriptionController.clear();
          
          //     },);
              
          
              
          //   }),
          
          //     const SizedBox(height: 10,),
          
          //     RoundButton(
          //       onTap:(){
          //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const ShowPostScreen()));
          //       }
              
          //     , title: 'Show Data')
          
          
          //   ],
          // ),
        ),
      ),
    );
  }
}