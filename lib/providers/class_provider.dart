import 'package:attendanceapp/models/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassProvider with ChangeNotifier {
  final CollectionReference classList = FirebaseFirestore.instance.collection(
      "classes"); //this is the collection reference to classes collection

  final List<Class> _classes = [
    // Class(name: "3CE12", subject: "ML", instructor: "Navdeep"),
    // Class(name: "3CE34", subject: "ML", instructor: "Navdeep"),
    // Class(name: "3CE56", subject: "ML", instructor: "Navdeep"),
    // Class(name: "3CE78", subject: "ML", instructor: "Navdeep"),
  ];

  final List<String> _recordList = [
    // Class(name: "3CE12", subject: "ML", instructor: "Navdeep"),
    // Class(name: "3CE34", subject: "ML", instructor: "Navdeep"),
    // Class(name: "3CE56", subject: "ML", instructor: "Navdeep"),
    // Class(name: "3CE78", subject: "ML", instructor: "Navdeep"),
  ];
  final List<Student> _studentList = [
    //this list will store the students
  ];

  //method to get the list of classes from firebase
  Future getClassesList() async {
    await classList.get().then((querySnapshot) {
      //querySnapshot is the list of all the documents in classes collection
      _classes.clear();
      for (var element in querySnapshot.docs) {
        _classes.add(Class(
            name: element.get("className"),
            subject: element.get("subject"),
            instructor: element.get("instructor")));
      }
    });
    notifyListeners();
  }

  List<Class> get classes {
    // getter function
    getClassesList(); //calling the classes function
    return [
      ..._classes
    ]; // ... is used because the copy of that data is stored in classes variable
  }

  List<String> get recordList {
    // getter function
    //getClassesList(); //calling the classes function
    return [
      ..._recordList
    ]; // ... is used because the copy of that data is stored in classes variable
  }

  List<Student> get studentList {
    return [..._studentList];
  }

  Class findById(String className) {
    return _classes.firstWhere((element) => element.name == className);
  }
  //below is the code to fetch the previous records from firebase

  Future getRecordList(String className) async {
   // _recordList.clear();
    final CollectionReference currentRecordList =
        classList.doc(className).collection('record');
    await currentRecordList.get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        _recordList.add(element.id);
      }
    });
    notifyListeners();
  }

  //below is the code to fetch all the student roll numbers in a class
  Future getStudentList(String className, String recordDate) async {
    _studentList.clear();
    final currentRecordDate = classList.doc(className).collection('record').doc(
        recordDate); //this currentRecordDate stores the id of document we are trying to access
    final data = await currentRecordDate.get();
    Map<String, dynamic> values =
        data.data() as Map<String, bool>; //this map contains all the values
    values.forEach((key, value) {
      _studentList.add(Student(name: key, isPresent: values[key]));
    });
    notifyListeners();
  }
}
