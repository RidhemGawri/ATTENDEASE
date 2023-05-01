import 'package:attendanceapp/models/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/class_provider.dart';

class StudentListScreen extends StatefulWidget {
   StudentListScreen({super.key});

  static const routeName = '/class_groups';

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> studentList = [];

  Map<String, String> argsData = <String,String>{};
  @override
  // Future getStudentList(String className, String recordDate) async{
  @override
  Widget build(BuildContext context) {
    //getting the name of class we are in
      argsData =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    Provider.of<ClassProvider>(context,listen: false).getStudentList(
        argsData['name']!, argsData['recordDate']!); //called the function

     //getStudentList(argsData['name']!, argsData['recordDate']!);//we should put  it in init state



     final loadedClass = Provider.of<ClassProvider>(context).findById(argsData[
        'name']!); //this findById method is defined in class_provider.dart file

    studentList = Provider.of<ClassProvider>(context,listen: false).studentList;//now we have a student list which contains the list of all students
    //creating a local list to store the data locally so its easier to change
      //List<Student> localList = List.castFrom(studentList);//this is just the local list not connected with db in any sense


    //lets return just a listview
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedClass.name),
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext ctx, int index) {
            return Card(
              shadowColor: Colors.teal,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
               ),
               elevation: 2,
              child: ListTile(
                title: Text(studentList[index].name),
                trailing: Checkbox(
                    value: studentList[index].isPresent,


                    onChanged: ( val) {
                      //whenever the value is changed we need to change it instantly in the db
                      Provider.of<ClassProvider>(context,listen: false).updateRecord(argsData['name']!, argsData['recordDate']!,
                          {
                            studentList[index].name : val!,
                          });

                      //studentList[index].isPresent = val!;
                      //print(val);
                      //
                      // setState(
                      //   () {
                      //     // studentList[index].isPresent =val!;
                      //     // print(val);
                      //     // print(studentList[index].isPresent);
                      //     localList[index].isPresent = val!;
                      //
                      //   },
                      //);
                    }),
              ),
            );
          },
          itemCount: studentList.length),
           floatingActionButton:  FloatingActionButton(
             onPressed: (){
               // //this will update the record in firebase
               // var updatedData ={ for (var e in studentList) e.name : e.isPresent };
               // Provider.of<ClassProvider>(context,listen: false).updateRecord(argsData['name']!, argsData['recordDate']!,updatedData);
               Navigator.pop(context);

             },
             child: Icon(Icons.save),
      ),
    );

    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text(loadedClass.name),
    //       centerTitle: true,
    //       bottom: const TabBar(tabs: [
    //         Tab(text: 'C-1'),
    //         Tab(text: 'C-2'),
    //       ]),
    //     ),
    //     body: TabBarView(children: [
    //       CheckboxListTile(
    //         title: const Text('12001190 - ABCD'),
    //         value: _isChecked,
    //         onChanged: (bool? newValue) {
    //           setState(() {
    //             _isChecked = newValue;
    //           });
    //         },
    //         //  activeColor: Colors.white,
    //         // checkColor: Colors.black,
    //       ),
    //       CheckboxListTile(
    //           title: const Text('12001141 - XYZ'),
    //           value: _isChecked,
    //           onChanged: (bool? newValue) {
    //             setState(() {
    //               _isChecked = newValue;
    //             });
    //           }),
    //     ]),
    //     // body: NestedScrollView(
    //     //   headerSliverBuilder:(context, innerBoxIsScrolled) => [
    //     //   SliverAppBar(
    //     //     floating: true,
    //     //     snap: true,
    //     //     title: Text('Hide'),
    //     //     centerTitle: true,
    //     //     ),
    //     //    ],
    //     //    body: ListView.builder(
    //     //     itemBuilder: (context,index) => ListTile(
    //     //       title: Text(
    //     //          'Item ${index +1}',
    //     //           style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100),
    //     //       ),
    //     //     ),
    //     //     )
    //     //   ),
    //
    //     floatingActionButton: const FloatingActionButton(
    //       onPressed: null,
    //       child: Icon(Icons.save),
    //     ),
    //   ),
    // );
  }
}