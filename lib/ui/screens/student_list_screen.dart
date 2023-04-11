import 'package:attendanceapp/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendanceapp/ui/screens/student_list_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  static const routeName = '/class_groups';

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  //bool? _isChecked = false;
  @override
  Widget build(BuildContext context) {
    //getting the name of class we are in
    final argsData = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    Provider.of<ClassProvider>(context).getStudentList(argsData['name']!, argsData['recordDate']!);//called the function


    final loadedClass = Provider.of<ClassProvider>(context).findById(
        argsData['name']!); //this findById method is defined in class_provider.dart file

    final studentList = Provider.of<ClassProvider>(context).studentList;

    //lets return just a listview
    return Scaffold(appBar: AppBar(title: Text(loadedClass.name),),
    body: ListView.builder(itemBuilder:(BuildContext ctx , int index){
      return  ListTile(title: Text(studentList[index].name),
        leading: Checkbox(value: studentList[index].isPresent, onChanged: null,),

      );
    },itemCount: studentList.length),
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
