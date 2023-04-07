import 'package:attendanceapp/providers/class_provider.dart';
import 'package:attendanceapp/ui/screens/class_groups.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//this screen will get all the previous record dates available in record collection of each class
class PreviousRecordScreen extends StatelessWidget {
  const PreviousRecordScreen({Key? key}) : super(key: key);
  static const routeName = '/previous_record_screen';

  @override
  Widget build(BuildContext context) {
    final className = ModalRoute.of(context)?.settings.arguments as String;
    Provider.of<ClassProvider>(context).getRecordList(className);
    final currentRecordList = Provider.of<ClassProvider>(context).recordList;

    // Map<String, String> args = {
    //   //this is the map we will pass in arguments
    //   'name': className,
    //   're'
    // };
    return Scaffold(
      appBar: AppBar(title: const Text("Current class"),
      ),
      body: ListView.builder(itemCount: currentRecordList.length,itemBuilder: (BuildContext ctx , int index){
        return ListTile(title: Text(currentRecordList[
          index]),onTap: (){
            Navigator.pushNamed(context, ClassGroups.routeName,arguments: {'name': className , 'recordDate':currentRecordList[index] });
            },
          );
      }),
    );
  }
}
