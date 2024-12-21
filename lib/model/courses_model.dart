import 'course_item_model.dart';

class CoursesModel {
  String id;
  String name;
  String label;
  String image;
  List<CourseItem> content;

  CoursesModel({
    required this.id,
    required this.name,
    required this.label,
    required this.image,
    required this.content,
  });

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is CoursesModel && runtimeType == other.runtimeType && name == other.name;

  // @override
  // int get hashCode => name.hashCode;

  // factory CoursesModel.fromJson(Map<String, dynamic> json) {
  //   return CoursesModel(
  //     id: json['id'].toString(),
  //     name: json['name'],
  //     label: json['label'],
  //     image: json['image'],
  //     content:
  //         CourseItem.CoursefromTheJsonList(json['content'] as List<dynamic>),
  //   );
  // }
}
