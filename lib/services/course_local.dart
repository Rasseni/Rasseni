// course_local_repository.dart
import 'package:sqflite/sqflite.dart';
import 'local_db.dart'; // Assuming SqlDb is defined here
import '../model/courses_model.dart';
import '../model/course_item_model.dart';

class CourseLocalRepository {
  final SqlDb _sqlDb = SqlDb.instance;

  // Save course and its content to local DB
  Future<void> saveCourseToLocalDB(CoursesModel course) async {
    final db = await _sqlDb.db;

    // Insert into `courses` table
    await db.insert(
      'courses',
      {
        'id': course.id,
        'name': course.name,
        'label': course.label,
        'image': course.image,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insert into `course_content` table
    for (var contentItem in course.content) {
      await db.insert(
        'course_content',
        {
          'id': contentItem.id,
          'course_id': course.id,
          'title': contentItem.title,
          'url': contentItem.url,
          'length': contentItem.length,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Fetch all user-added courses from local DB
  Future<List<CoursesModel>> fetchUserAddedCourses() async {
    final db = await _sqlDb.db;

    // Query all courses
    final courses = await db.query('courses');

    // Fetch content for each course and build the list
    List<CoursesModel> userCourses = [];
    for (var course in courses) {
      final content = await db.query(
        'course_content',
        where: 'course_id = ?',
        whereArgs: [course['id']],
      );

      List<CourseItem> courseItems = content.map((item) {
        return CourseItem(
          id: item['id'] as String,
          title: item['title'] as String,
          url: item['url'] as String,
          length: item['length'] as String,
        );
      }).toList();

      userCourses.add(CoursesModel(
        id: course['id'] as String,
        name: course['name'] as String,
        label: course['label'] as String,
        image: course['image'] as String,
        content: courseItems,
      ));
    }
    return userCourses;
  }

  // Delete a course from the local DB
  Future<void> deleteCourse(String id) async {
    final db = await _sqlDb.db;

    // Delete from `course_content` table first due to foreign key
    await db.delete('course_content', where: 'course_id = ?', whereArgs: [id]);

    // Then delete from `courses` table
    await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }
}
