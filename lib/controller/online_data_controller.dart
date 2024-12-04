import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/courses_model.dart';

class OnlineData {
  final String _Api = 'https://rasseni-8004a-default-rtdb.firebaseio.com/.json';
  List<CoursesModel> theCourses = [];

  Future<List<CoursesModel>?> theCoursesList() async {
    var response = await http.get(Uri.parse(_Api));
    if (response.statusCode == 200) {
      var responseBody = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in responseBody) {
        theCourses.add(CoursesModel.fromJson(element));
      }
      return theCourses;
    } else {
      print('Request failed ${response.statusCode}');
      return null;
    }
  }
}
