import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:teachersapp/Widgets/Form.dart';

class AddNewData extends StatefulWidget {
  @override
  _AddNewDataState createState() => _AddNewDataState();
}

class _AddNewDataState extends State<AddNewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Add Data",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                FormFill(),
              ],
            ),
          ),
        ));
  }
}
