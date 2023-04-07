import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/class_provider.dart';

class Attd_list extends StatefulWidget {
  const Attd_list({super.key});
  static const routeName = '/attd_list';
  @override
  State<Attd_list> createState() => _Attd_listState();
}

class _Attd_listState extends State<Attd_list> {
  bool? _CheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's date"),
      ),
      body: ListView.separated(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(15),
                ),
               // color: Colors.lightGreen[100],
                child: ListTile(
                  leading: Icon(Icons.person),
                  trailing: Checkbox(
                     tristate: true,
                      value: _CheckBox,
                      onChanged: (value) {
                        setState(() {
                          _CheckBox = value;
                        });
                      }),
                  title: Text('Person $index'),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 5,
              )),
    );
  }
}
