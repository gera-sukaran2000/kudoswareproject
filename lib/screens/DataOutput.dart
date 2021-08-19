import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:teachersapp/Models/Teachers.dart';
import 'package:teachersapp/Widgets/StylingList.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DataOutput extends StatefulWidget {
  @override
  _DataOutputState createState() => _DataOutputState();
}

class _DataOutputState extends State<DataOutput> {
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<StudentDataList>(context).fetchAndSetData();
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final listOfStudents =
        Provider.of<StudentDataList>(context, listen: false).allData;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: 120,
                    color: Colors.blue[300].withOpacity(0.8),
                    child: Center(
                        child: Text(
                      "Student Data",
                      style: GoogleFonts.lobster(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return StylingList(listOfStudents[index]);
                    },
                    itemCount: listOfStudents.length,
                  ),
                ),
              ],
            ),
    );
  }
}
