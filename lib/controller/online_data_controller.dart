// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// import '../model/courses_model.dart';

// class OnlineData {
//   final String _Api = 'https://rasseni-8004a-default-rtdb.firebaseio.com/.json';
//   List<CoursesModel> coursesList = [];

//   Future<List<CoursesModel>?> theCoursesList() async {
//     var response = await http.get(Uri.parse(_Api));
//     if (response.statusCode == 200) {
//       var responseBody = convert.jsonDecode(response.body) as List<dynamic>;
//       for (var element in responseBody) {
//         coursesList.add(CoursesModel.fromJson(element));
//       }
//       return coursesList;
//     } else {
//       print('Request failed ${response.statusCode}');
//       return null;
//     }
//   }
// }


// course_api_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/course_item_model.dart';
import '../model/courses_model.dart';

class CourseApiRepository {
  static const String apiUrl = "https://rasseni-8004a-default-rtdb.firebaseio.com/.json"; // Replace with your actual API URL

  // Fetch courses from the API
  Future<List<CoursesModel>> fetchCoursesFromApi() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((courseData) {
        List<CourseItem> content = (courseData['content'] as List).map((item) {
          return CourseItem(
            id: item['id'].toString(),
            title: item['title'],
            url: item['url'],
            length: item['length'],
          );
        }).toList();
        
        return CoursesModel(
          id: courseData['id'].toString(),
          name: courseData['name'],
          label: courseData['label'],
          image: courseData['image'],
          content: content,
        );
      }).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
