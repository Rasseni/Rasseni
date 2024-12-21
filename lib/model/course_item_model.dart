class CourseItem {
  String id;
  String title;
  String url;
  String length;
  CourseItem({
    required this.id,
    required this.title,
    required this.url,
    required this.length,
  });

  // static List<CourseItem> CoursefromTheJsonList(List<dynamic> jsonList) {
  //   List<CourseItem> lessonsList = [];
  //   for (var item in jsonList) {
  //     lessonsList.add(CourseItem.fromJson(item as Map<String, dynamic>));
  //   }
  //   return lessonsList;
  // }

  // factory CourseItem.fromJson(Map<String, dynamic> json) {
  //   return CourseItem(
  //       id: json['id'].toString(),
  //       title: json['title'],
  //       url: json['url'],
  //       length: json['length']);
  // }
}
