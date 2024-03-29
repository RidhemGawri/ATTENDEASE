
import 'package:attendanceapp/providers/class_provider.dart';
import 'package:attendanceapp/ui/auth/login_screen.dart';
import 'package:attendanceapp/ui/screens/my_record.dart';
import 'package:attendanceapp/ui/screens/student_list_screen.dart';
import 'package:attendanceapp/ui/screens/home_screen.dart';
import 'package:attendanceapp/ui/screens/previous_record_screen.dart';
import 'package:attendanceapp/ui/screens/record.dart';
import 'package:attendanceapp/ui/screens/splash_screen.dart';
import 'package:attendanceapp/ui/screens/calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // WidgetFlutterBinding is used to interact with flutter engine
  await Firebase
      .initializeApp(); // Firebase.initializedApp() needs to call native code to initialize firebase,
  // and since the plugins needs to use platform channels to call the native code,which is done asynchronously by calling ensureinitialized()
  //to make sure that we have an instance of widget binding.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ClassProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: const Color(0xffefa59a),
           ),
         ),
        // theme: ThemeData(
        //   primarySwatch:Colors.orange,
        // ),


        //starting with myrecord screen just to make sure we can query the data
        home:MyRecord(),
        //home: const SplashScreen(),

        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          StudentListScreen.routeName: (ctx) =>  StudentListScreen(),
          Records.routeName: (ctx) => const Records(),
          Calender.routeName: (ctx) => const Calender(),
          PreviousRecordScreen.routeName: (ctx) => const PreviousRecordScreen(),
        },
      ),
    );
  }
}
//to get the attendance of a certain student we can query all the document where that student is present and hence return the size of that db query