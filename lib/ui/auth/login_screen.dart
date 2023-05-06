import 'package:attendanceapp/ui/screens/home_screen.dart';
import 'package:attendanceapp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHiddenPassword = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance; // creating reference for authentication

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    // creating a function
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString()); // future function
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      // );
      Navigator.pushNamed(context, HomeScreen.routeName);
      setState(() {
        loading = false;
      });
    }).onError((error, StackTrace) {
      debugPrint(error
          .toString()); // to remove errors automatically in production mode
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
           width: double.infinity,
           decoration: BoxDecoration(
             gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors:[
                  Color(0xffefa59a),
                  Color(0xffefa57a),
                  Color.fromARGB(255, 241, 165, 163),
               ],
              ),
           ),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(height: 90,),
               Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                   children: [
                      Text("Login",style: TextStyle(color: Colors.white,fontSize: 35),),
                      SizedBox(height: 5),
                      Text("Welcome Back",style: TextStyle(color: Colors.white,fontSize: 25),),
                      SizedBox(height: 40,),
                 ],
                ),
               ),
               Expanded(
                child: Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                   ),
                   child: Padding(
                    padding: EdgeInsets.only(top: 80,right: 20,left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                            height: 350,
                            decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20),
                               boxShadow: [BoxShadow(
                                 color: Color.fromARGB(255, 241, 165, 163),
                                 blurRadius: 20,
                                 offset: Offset(0, 10),
                               )]
                            ),
                           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right:20.0),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              //helperText: 'enter email e.g. john@gmail.com',
                              prefixIcon: Icon(Icons.alternate_email)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:20.0,left:20),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: _isHiddenPassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_open),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RoundButton(
                title: 'Login',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text("Don't have an account"),
              //     TextButton(
              //         onPressed: () {
              //           // Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //       builder: (context) => SignUpScreen(),
              //           //     ));
              //           Navigator.pushNamed(context, SignUpScreen.routeName);
              //         },
              //         child: const Text("Sign up")),
              //   ],
              // ),
              // InkWell(
              //   onTap: () {
              
              //   },
              // ),
              // Container(
              //           height: 50,
              //           decoration:BoxDecoration(
              //            // color: Colors.blueGrey,
              //             borderRadius: BorderRadius.circular(30),
              //             border: Border.all(
              //              color: Colors.black,
              //             ),
              //           ),
              //           child: Center(
              //             child:Text('Login with phone'),
              //             ),
              //         )
            ],
          ),
                         ),
                       ],
                    ),
                  ),
                ),
              ),
             ],
           ),
        ),
        // appBar: AppBar(
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   title: const Text('Login'),
        // ),
        // body: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Form(
        //         key: _formKey,
        //         child: Column(
        //           children: [
        //             TextFormField(
        //                 keyboardType: TextInputType.emailAddress,
        //                 controller: emailController,
        //                 decoration: const InputDecoration(
        //                     hintText: 'Email',
        //                     helperText: 'enter email e.g. john@gmail.com',
        //                     prefixIcon: Icon(Icons.alternate_email)),
        //                 validator: (value) {
        //                   if (value!.isEmpty) {
        //                     return 'Enter email';
        //                   }
        //                   return null;
        //                 }),
        //             const SizedBox(
        //               height: 30,
        //             ),
        //             TextFormField(
        //                 keyboardType: TextInputType.text,
        //                 controller: passwordController,
        //                 obscureText: _isHiddenPassword,
        //                 decoration: InputDecoration(
        //                   hintText: 'Password',
        //                   prefixIcon: const Icon(Icons.lock_open),
        //                   suffixIcon: InkWell(
        //                     onTap: _togglePasswordView,
        //                     child: Icon(
        //                       _isHiddenPassword
        //                           ? Icons.visibility
        //                           : Icons.visibility_off,
        //                     ),
        //                   ),
        //                 ),
        //                 validator: (value) {
        //                   if (value!.isEmpty) {
        //                     return 'Enter password';
        //                   }
        //                   return null;
        //                 }),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 50,
        //       ),
        //       RoundButton(
        //         title: 'Login',
        //         loading: loading,
        //         onTap: () {
        //           if (_formKey.currentState!.validate()) {
        //             login();
        //           }
        //         },
        //       ),
        //       // const SizedBox(
        //       //   height: 20,
        //       // ),
        //       // Row(
        //       //   mainAxisAlignment: MainAxisAlignment.center,
        //       //   children: [
        //       //     const Text("Don't have an account"),
        //       //     TextButton(
        //       //         onPressed: () {
        //       //           // Navigator.push(
        //       //           //     context,
        //       //           //     MaterialPageRoute(
        //       //           //       builder: (context) => SignUpScreen(),
        //       //           //     ));
        //       //           Navigator.pushNamed(context, SignUpScreen.routeName);
        //       //         },
        //       //         child: const Text("Sign up")),
        //       //   ],
        //       // ),
        //       // InkWell(
        //       //   onTap: () {

        //       //   },
        //       // ),
        //       // Container(
        //       //           height: 50,
        //       //           decoration:BoxDecoration(
        //       //            // color: Colors.blueGrey,
        //       //             borderRadius: BorderRadius.circular(30),
        //       //             border: Border.all(
        //       //              color: Colors.black,
        //       //             ),
        //       //           ),
        //       //           child: Center(
        //       //             child:Text('Login with phone'),
        //       //             ),
        //       //         )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  void _togglePasswordView() {
    // if (_isHiddenPassword == true) {
    //   _isHiddenPassword == false;
    // } else {
    //   _isHiddenPassword = true;
    // }
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
}



// import 'package:attendanceapp/ui/screens/home_screen.dart';
// import 'package:attendanceapp/widgets/round_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../utils/utils.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   static const routeName = '/login_screen';

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isHiddenPassword = true;
//   bool loading = false;
//   bool _validate = false;
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final _auth = FirebaseAuth.instance; // creating reference for authentication
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }

//   void login() {
//     // creating a function
//     setState(() {
//       loading = true;
//     });
//     _auth
//         .signInWithEmailAndPassword(
//             email: emailController.text,
//             password: passwordController.text.toString())
//         .then((value) {
//       Utils().toastMessage(value.user!.email.toString()); // future function
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => const HomeScreen()),
//       // );
//       Navigator.pushNamed(context, HomeScreen.routeName);
//       setState(() {
//         loading = false;
//       });
//     }).onError((error, StackTrace) {
//       debugPrint(error
//           .toString()); // to remove errors automatically in production mode
//       Utils().toastMessage(error.toString());
//       setState(() {
//         loading = false;
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return true;
//       },
//       child: Scaffold(
//         body: Container(
//           // padding: EdgeInsets.symmetric(vertical: 30),
//           width: double.infinity,
//           decoration: BoxDecoration(
//               gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//             Color(0xffefa59a),
//             Color.fromARGB(255, 241, 165, 163),
//           ])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "Login",
//                         style: TextStyle(color: Colors.white, fontSize: 40),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         "Welcome Back",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       ),
//                     ]),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(60),
//                       topRight: Radius.circular(60),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       children:[
//                         SizedBox(
//                           height: 80,
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0xffefa59a),
//                                   blurRadius: 20,
//                                   offset: Offset(0, 10),
//                                 )
//                               ]),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(color: Colors.grey)),
//                                 ),
//                                 child: TextField(
//                                   keyboardType: TextInputType.emailAddress,
//                                   controller: emailController,
//                                   decoration: InputDecoration(
//                                     hintText: "Enter Email",
//                                     prefixIcon: Icon(Icons.alternate_email),
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     border: InputBorder.none,
//                                     errorText: _validate
//                                         ? 'Please enter your email'
//                                         : null,
//                                   ),
//                                   //  validator: (value) {
//                                   //    if (value!.isEmpty) {
//                                   //      return 'Enter email';
//                                   //     }
//                                   //     return null;
//                                   //   }
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                       bottom: BorderSide(color: Colors.grey)),
//                                 ),
//                                 child: TextField(
//                                   keyboardType: TextInputType.text,
//                                   controller: passwordController,
//                                   obscureText: _isHiddenPassword,
//                                   decoration: InputDecoration(
//                                     hintText: 'Password',
//                                     border: InputBorder.none,
//                                     prefixIcon: const Icon(Icons.lock_open),
//                                     errorText: _validate
//                                         ? 'Please enter your password'
//                                         : null,
//                                     suffixIcon: InkWell(
//                                       onTap: _togglePasswordView,
//                                       child: Icon(
//                                         _isHiddenPassword
//                                             ? Icons.visibility
//                                             : Icons.visibility_off,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         RoundButton(
//                           title: 'Login',
//                           loading: loading,
//                           onTap: () {
//                             if (_formKey.currentState!.validate()) {
//                             login();
//                             }
//                            },
//                          ),
//                         // Container(
//                         //   height: 50,
//                         //   margin: EdgeInsets.symmetric(horizontal: 50),
//                         //   decoration: BoxDecoration(
//                         //     borderRadius: BorderRadius.circular(50),
//                         //     color: Color.fromARGB(255, 243, 157, 143),
//                         //   ),
//                         //   child: Center(
//                         //     child: Text(
//                         //       "Login",
//                         //       style: TextStyle(
//                         //           color: Colors.white,
//                         //           fontWeight: FontWeight.bold),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _togglePasswordView() {
//     // if (_isHiddenPassword == true) {
//     //   _isHiddenPassword == false;
//     // } else {
//     //   _isHiddenPassword = true;
//     // }
//     setState(() {
//       _isHiddenPassword = !_isHiddenPassword;
//     });
//   }
// }
