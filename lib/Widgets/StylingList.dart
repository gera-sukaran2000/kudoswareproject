import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teachersapp/Models/Teachers.dart';

class StylingList extends StatefulWidget {
  final StudentData singleobject;

  StylingList(this.singleobject);

  @override
  _StylingListState createState() => _StylingListState();
}

class _StylingListState extends State<StylingList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 7, right: 7),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            isThreeLine: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            leading: Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.black87))),
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            title: Text(widget.singleobject.name,
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(
              'D.O.B - ${DateFormat.yMMMd().format(widget.singleobject.dateofBirth)} \nGender - ${widget.singleobject.gender}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: IconButton(
                onPressed: () async {
                  await Provider.of<StudentDataList>(context, listen: false)
                      .removeStudentData(widget.singleobject.id);
                },
                icon: Icon(Icons.delete, color: Colors.black, size: 25.0)),
          ),
        ),
      ),
    );
  }
}
