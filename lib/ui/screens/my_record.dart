import 'package:attendanceapp/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyRecord extends StatelessWidget {
   MyRecord({Key? key}) : super(key: key);

  TextEditingController classNameController =  TextEditingController();
  TextEditingController studentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Record"),

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children:  [
            TextField(
              controller: classNameController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Name',
                border: InputBorder.none
              ),
            ),
            const SizedBox(height: 10,),
            TextField(controller: studentNameController,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Class Name',
                  border: InputBorder.none
              ),),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed:(){
              Provider.of<ClassProvider>(context,listen: false).getMyAttendance(classNameController.value.text, studentNameController.value.text);}

              , child: Text('Find'),),
            const SizedBox(height: 30,),
            // Consumer<ClassProvider>(builder: (_,_,_))
            // ListTile(title: Text(studentNameController.value.text),
            // trailing: ,)

          ],
        ),
      ),
    );
  }
}
