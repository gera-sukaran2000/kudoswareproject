import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachersapp/Models/Teachers.dart';
import 'package:intl/intl.dart';

class FormFill extends StatefulWidget {
  @override
  _FormFillState createState() => _FormFillState();
}

class _FormFillState extends State<FormFill> {
  DateTime dob;

  TextEditingController dobText = TextEditingController();

  var _currentSelectedValue;

  List<String> gender = ['Male', 'Female'];

  final _formKey = GlobalKey<FormState>();

  var finalData =
      StudentData(id: null, name: '', gender: '', dateofBirth: null);

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ));

  void _saveForm() async {
    var isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    await Provider.of<StudentDataList>(context, listen: false)
        .addNewStudentData(finalData);

    setState(() {
      _formKey.currentState.reset();
      dobText.clear();
      _currentSelectedValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    focusedBorder: border,
                    hintText: 'Enter Student Name',
                    prefixIcon:
                        Icon(Icons.person_outlined, color: Colors.white),
                    border: border,
                    fillColor: Colors.white24,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    )),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  finalData = StudentData(
                      id: DateTime.now().toString(),
                      name: value,
                      gender: finalData.gender,
                      dateofBirth: finalData.dateofBirth);
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dobText,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    focusedBorder: border,
                    hintText: 'Choose D.O.B',
                    prefixIcon:
                        Icon(Icons.date_range_outlined, color: Colors.white),
                    border: border,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white24,
                    filled: true,
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    )),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Choose A Date of Birth';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime.now());
                  if (pickedDate == null) {
                    return null;
                  }
                  setState(() {
                    dob = pickedDate;
                    dobText.text = DateFormat.yMMMd().format(pickedDate);
                  });
                },
                onSaved: (_) {
                  finalData = StudentData(
                      id: finalData.id,
                      name: finalData.name,
                      gender: finalData.gender,
                      dateofBirth: dob);
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: border,
                  focusedBorder: border,
                  fillColor: Colors.white24,
                  filled: true,
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                value: _currentSelectedValue,
                hint: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Row(children: [
                      Icon(
                        Icons.male_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Choose Gender',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ])),
                onChanged: (String newValue) {
                  setState(() {
                    _currentSelectedValue = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please Choose A Gender';
                  }
                  return null;
                },
                items: gender.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onSaved: (value) {
                  finalData = StudentData(
                      id: finalData.id,
                      name: finalData.name,
                      gender: value,
                      dateofBirth: finalData.dateofBirth);
                },
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: RaisedButton(
                    child: Text('Submit Form',
                        style: TextStyle(color: Colors.black)),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    onPressed: () {
                      _saveForm();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
