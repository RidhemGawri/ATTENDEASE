import 'package:attendanceapp/providers/class_provider.dart';
import 'package:attendanceapp/ui/screens/calendar.dart';
import 'package:attendanceapp/ui/screens/student_list_screen.dart';
import 'package:attendanceapp/ui/screens/previous_record_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  static const routeName = '/record';

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    final className = ModalRoute.of(context)?.settings.arguments as String;


    return Scaffold(
      appBar: AppBar(
        title:  Text(className),
      ),
       
       body: Center(
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             children:[
              // Row(
              //   children: [
              //     IconButton(
              //     icon: const Icon(Icons.arrow_back),
              //     onPressed: (){
              //       Navigator.pop(context);
              //     },
              //    ),
              //    const SizedBox(width: 2),
              //     Text('Records',
              //     style: const TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold),
              //     ),
              //    ],
              //   ),
               const SizedBox(height: 30),
                InkWell(
                  onTap:(){ Navigator.pushNamed(context, PreviousRecordScreen.routeName , arguments: className);},
                  child: Container(
                      alignment: Alignment.center,
                       height: 250,
                       width: 400,
                       // margin: new EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: const LinearGradient(
                             begin: Alignment.topRight,
                             end: Alignment.bottomLeft,
                             colors:[
                               Color(0xfffefa58a),
                             //  Color(0xfffefa57a),
                               Color.fromARGB(255, 241, 165, 163),
                              ],
                           ),
                                        ),
                                    child: const Center(
                                      child: Text(
                                        'View Previous Record',
                                        style:  TextStyle(fontSize: 20),
                                      ),
                                    ),
           
                                  ),
                ),
           
               const SizedBox(height: 30),
                InkWell(
                    child: Container(
                      alignment: Alignment.center,
                       height: 250,
                       width: 400,
                       // margin: new EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: const LinearGradient(
                             begin: Alignment.topRight,
                             end: Alignment.bottomLeft,
                             colors:[
                               Color(0xfffefa58a),
                             //  Color(0xfffefa57a),
                               Color.fromARGB(255, 241, 165, 163),
                              ],
                           ),
                                        ),
                                    child: const Center(
                                      child: Text(
                                        'Add New Record',
                                        style:  TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                     onTap:(){
                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime.now())
                          .then((pickedDate) {
                            if(pickedDate ==null){
                              //this means user has pressed cancel
                              return;
                            }
                            //when the user has picked a date we need to add an entry to the db
                        //so will create a function in the provider file and call it here
                            Provider.of<ClassProvider>(context,listen: false).createNewRecord(className, pickedDate.toString());
                            //now we can add the new records to the database
                        //after adding them we gonna fetch them from db and show as listview in student_list_screen
                        Navigator.pushNamed(context, StudentListScreen.routeName,arguments: {'name': className , 'recordDate':pickedDate.toString()});
           
                      });
                     },
                     // onTap: () {
                     //          Navigator.pushNamed(context, Calender.routeName,arguments: className );
                     //        },
                  ),
           
             ],
           ),
         ),
       ),
    );
  }
}
