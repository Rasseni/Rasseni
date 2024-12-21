import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controller/progress_controller.dart';
import '../model/app_style.dart';

class LessonPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final String title;
  final String courseId;
  final String itemId;

  const LessonPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.courseId,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Invalid Video"),
        ),
        body: const Center(child: Text("The provided video URL is invalid.")),
      );
    }

    final _progressController =
        Provider.of<ProgressController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lesson Player",
          style: AppStyles.bold20(AppStyles.whiteColor),
        ),
        backgroundColor: AppStyles.indigoColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: width * 0.03, right: width * 0.03, top: height * 0.02),
          child: Column(
            children: [
              YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                ),
                showVideoProgressIndicator: true,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                title,
                style: AppStyles.bold20(
                  AppStyles.blackColor,
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              ElevatedButton(
                onPressed: () {
                  // Mark this lesson as complete
                  _progressController.onContinueTap(courseId);
                  Navigator.pop(context);
                },
                child: Text(
                  'Continue',
                  style: AppStyles.semiBold32(AppStyles.whiteColor),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  minimumSize: Size(double.infinity, height * 0.1),
                  backgroundColor: AppStyles.greenColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
