import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentData with ChangeNotifier {
  final String id;
  final String name;
  final String gender;
  final DateTime dateofBirth;

  StudentData(
      {@required this.id,
      @required this.name,
      @required this.gender,
      @required this.dateofBirth});
}

class StudentDataList with ChangeNotifier {
  List<StudentData> _students = [
    // StudentData(
    //     id: '1', name: 'Sukaran', gender: 'Male', dateofBirth: DateTime.now()),
    // StudentData(
    //     id: '2', name: 'Brick', gender: 'Male', dateofBirth: DateTime.now()),
    // StudentData(
    //     id: '3', name: 'Drick', gender: 'Male', dateofBirth: DateTime.now()),
    // StudentData(
    //     id: '4', name: 'Stick', gender: 'Male', dateofBirth: DateTime.now()),
  ];

  final String AuthToken;
  final String userId;

  StudentDataList(this.AuthToken, this.userId, this._students);

  List<StudentData> get allData {
    return [..._students];
  }

  Future<void> fetchAndSetData() async {
    try {
      final url = Uri.parse(
          'https://teacherdashboard-6ed8b-default-rtdb.asia-southeast1.firebasedatabase.app/StudentData.json?auth=$AuthToken&orderBy="creatorId"&equalTo="$userId"');
      final response = await http.get(url);
      List<StudentData> studentsAllData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((dataId, dataObject) {
        studentsAllData.add(StudentData(
            id: dataId,
            name: dataObject['name'],
            gender: dataObject['gender'],
            dateofBirth: DateTime.parse(dataObject['dateofBirth'])));
      });
      _students = studentsAllData;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addNewStudentData(StudentData data) async {
    final url = Uri.parse(
        'https://teacherdashboard-6ed8b-default-rtdb.asia-southeast1.firebasedatabase.app/StudentData.json?auth=$AuthToken');
    final response = await http.post(url,
        body: json.encode({
          'name': data.name,
          'gender': data.gender,
          'dateofBirth': data.dateofBirth.toIso8601String(),
          'creatorId': userId
        }));
    final newData = StudentData(
        id: json.decode(response.body)['name'],
        name: data.name,
        gender: data.gender,
        dateofBirth: data.dateofBirth);
    _students.add(newData);
    notifyListeners();
  }

  Future<void> removeStudentData(String id) async {
    final url = Uri.parse(
        'https://teacherdashboard-6ed8b-default-rtdb.asia-southeast1.firebasedatabase.app/StudentData/$id.json?auth=$AuthToken');
    await http.delete(url);
    _students.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
