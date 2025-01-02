import 'package:flutter/material.dart';

class AppStyles {
  //Color
  static const Color yellowColor = Color(0xffFDC613);
  static const Color blueColor = Color(0xff3C62DD);
  static const Color maybeCyan = Color(0xff31AFD5);
  static const Color maybeBlueColor = Color(0xff004ffe);
  static const Color greenColor = Color(0xff00B232);
  static const Color orangeColor = Color(0xffFF7427);
  static const Color roseColor = Color(0xffFF017E);
  static const Color indigoColor = Color(0xff6338FE);
  static const Color whiteColor = Color(0xffF7F9F8);
  static const Color blackColor = Color(0xff050505);
  static const Color grayColor = Color(0xffBDBEBE);
  static const Color darkGrayColor = Color(0xffD9D9D9);
  static const Color maybeGray = Color(0xffA6A9CB);
  static const Color redColor = Color(0xffC73E1C);
  static const Color darkOrangeColor = Color(0xffFF5B00);

  //Text Style
  static TextStyle bold96(Color c) => TextStyle(
      color: c,
      fontSize: 96,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold64(Color c) => TextStyle(
      color: c,
      fontSize: 64,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold48(Color c) => TextStyle(
      color: c,
      fontSize: 48,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold40(Color c) => TextStyle(
      color: c,
      fontSize: 40,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold32(Color c) => TextStyle(
      color: c,
      fontSize: 32,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold24(Color c) => TextStyle(
      color: c,
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold20(Color c) => TextStyle(
      color: c,
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold18(Color c) => TextStyle(
      color: c,
      fontSize: 18,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);
  static TextStyle bold15(Color c) => TextStyle(
      color: c,
      fontSize: 15,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);

  static TextStyle bold12(Color c) => TextStyle(
      color: c,
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700);

  static TextStyle semiBold36(Color c) => TextStyle(
      color: c,
      fontSize: 36,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600);
  static TextStyle semiBold32(Color c) => TextStyle(
      color: c,
      fontSize: 32,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600);
  static TextStyle semiBold24(Color c) => TextStyle(
      color: c,
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600);
  static TextStyle semiBold20(Color c) => TextStyle(
      color: c,
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600);
  static TextStyle semiBold16(Color c) => TextStyle(
      color: c,
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600);
  static TextStyle semiBold12(Color c) => TextStyle(
      color: c,
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600);

  static TextStyle regular32(Color c) => TextStyle(
      color: c,
      fontSize: 32,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular24(Color c) => TextStyle(
      color: c,
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular20(Color c) => TextStyle(
      color: c,
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular16(Color c) => TextStyle(
      color: c,
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular15(Color c) => TextStyle(
      color: c,
      fontSize: 15,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular14(Color c) => TextStyle(
      color: c,
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular12(Color c) => TextStyle(
      color: c,
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);
  static TextStyle regular10(Color c) => TextStyle(
      color: c,
      fontSize: 10,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w400);

  static TextStyle medium40(Color c) => TextStyle(
      color: c,
      fontSize: 40,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500);
  static TextStyle medium32(Color c) => TextStyle(
      color: c,
      fontSize: 32,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500);
  static TextStyle medium24(Color c) => TextStyle(
      color: c,
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500);
  static TextStyle medium20(Color c) => TextStyle(
      color: c,
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500);
  static TextStyle medium16(Color c) => TextStyle(
      color: c,
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500);

  static TextStyle light24(Color c) => TextStyle(
      color: c,
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w300);
  static TextStyle light20(Color c) => TextStyle(
      color: c,
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w300);

  // images
  static const String logoWithoutBackground =
      'assets/images/logo/Rasseni-removebg-preview.png';
  static const String logoWhithBackground =
      'assets/images/logo/Rasseni-removebg-preview-white.png';

  static const String mobile = 'assets/images/courses logo/mobile.png';
  static const String web = 'assets/images/courses logo/web.png';
  static const String cPlusPlus = 'assets/images/courses logo/c++.png';
  static const String python = 'assets/images/courses logo/python.png';
  static const String pythonWhite = 'assets/images/courses logo/pythowhite.png';
  static const String react = 'assets/images/courses logo/react.png';
  static const String flutter = 'assets/images/courses logo/flutter.png';
  static const String dart = 'assets/images/courses logo/dart.png';
  static const String java = 'assets/images/courses logo/java.png';
  static const String kotlin = 'assets/images/courses logo/kotlin.png';
  static const String swift = 'assets/images/courses logo/swift.png';
  static const String csharp = 'assets/images/courses logo/c-sharp.png';
  static const String js = 'assets/images/courses logo/js.png';
  static const String html = 'assets/images/courses logo/html.png';
  static const String css = 'assets/images/courses logo/css.png';
  static const String sql = 'assets/images/courses logo/mysql.png';
  static const String unity = 'assets/images/courses logo/unity.png';
  static const String reactNative =
      'assets/images/courses logo/react-native.png';
  static const String php = 'assets/images/courses logo/php.png';
  static const String nodeJs = 'assets/images/courses logo/nodejs.png';
  static const String mongodb = 'assets/images/courses logo/mongodb.png';

  static const String trends = 'assets/images/icons/trends.png';
  static const String skills = 'assets/images/icons/skills.png';
  static const String project = 'assets/images/icons/project.png';
  static const String hardware = 'assets/images/icons/hardware.png';
  static const String git = 'assets/images/icons/git.png';
  static const String coding = 'assets/images/icons/coding.png';
  static const String main = 'assets/images/icons/main.png';

  //Icons
  static const IconData home = Icons.home_filled;
  static const IconData profile = Icons.person_rounded;
  static const IconData dashboard = Icons.dashboard_rounded;
  static const IconData logout = Icons.logout_rounded;
  static const IconData chat = Icons.chat_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData notificationNone = Icons.notifications_active_rounded;
  static const IconData menu = Icons.menu_rounded;
  static const IconData add = Icons.add_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData delete = Icons.delete_rounded;
  static const IconData save = Icons.save_rounded;
  static const IconData back = Icons.arrow_back_ios_rounded;
  static const IconData done = Icons.done_rounded;
  static const IconData badge = Icons.badge_rounded;
  static const IconData streak = Icons.local_fire_department;
  static const IconData person = Icons.person_4_rounded;

  static final Map<String, Map<String, dynamic>> courseResources = {
    "C++": {
      "color": AppStyles.yellowColor,
      "image": AppStyles.cPlusPlus,
    },
    "Python": {
      "color": AppStyles.greenColor,
      "image": AppStyles.python,
    },
    "React": {
      "color": AppStyles.maybeCyan,
      "image": AppStyles.react,
    },
    "Flutter": {
      "color": AppStyles.maybeCyan,
      "image": AppStyles.flutter,
    },
    "Dart": {
      "color": AppStyles.indigoColor,
      "image": AppStyles.dart,
    },
    "Java": {
      "color": AppStyles.darkOrangeColor,
      "image": AppStyles.java,
    },
    "Kotlin": {
      "color": AppStyles.roseColor,
      "image": AppStyles.kotlin,
    },
    "Swift": {
      "color": AppStyles.orangeColor,
      "image": AppStyles.swift,
    },
    "C#": {
      "color": AppStyles.blueColor,
      "image": AppStyles.csharp,
    },
    "JavaScript": {
      "color": AppStyles.maybeBlueColor,
      "image": AppStyles.js,
    },
    "HTML": {
      "color": AppStyles.orangeColor,
      "image": AppStyles.html,
    },
    "CSS": {
      "color": AppStyles.roseColor,
      "image": AppStyles.css,
    },
    "MySQL": {
      "color": AppStyles.redColor,
      "image": AppStyles.sql,
    },
    "Unity": {
      "color": AppStyles.greenColor,
      "image": AppStyles.unity,
    },
    "React Native": {
      "color": AppStyles.maybeBlueColor,
      "image": AppStyles.reactNative,
    },
    "PHP": {
      "color": AppStyles.blueColor,
      "image": AppStyles.php,
    },
    "Node.js": {
      "color": AppStyles.indigoColor,
      "image": AppStyles.nodeJs,
    },
    "MongoDB": {
      "color": AppStyles.darkOrangeColor,
      "image": AppStyles.mongodb,
    },
  };
}
