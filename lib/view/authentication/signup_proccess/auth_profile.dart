import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/auth_controller.dart';

import '../../../controller/image_pick_contoller.dart';
import '../../../controller/profile_controller.dart';
import '../../../model/app_style.dart';
import '../../shared/bottom_nav_bar.dart';

class AuthProfile extends StatelessWidget {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    final _authController = Provider.of<AuthController>(context);
    final _imageController = Provider.of<ProfileImageController>(context);
    final _profileController = Provider.of<ProfileController>(context);
    final _userId = _authController.userId; // Access userId from provider

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(),
              SizedBox(height: height * 0.03),
              _buildProfilePicture(_imageController, width, _profileController),
              SizedBox(height: height * 0.04),
              _buildTextField(
                "First Name",
                "Walid",
                _firstName,
                height,
              ),
              SizedBox(height: height * 0.04),
              _buildTextField(
                "Last Name",
                "Besheer",
                _lastName,
                height,
              ),
              SizedBox(height: height * 0.04),
              _buildNextButton(width, height, _firstName.text, _lastName.text,
                  _userId!, _profileController, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text.rich(
      TextSpan(
        text: "Complete",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          color: const Color(0xff6339FF),
        ),
        children: [
          TextSpan(
            text: " your \nprofile",
            style: TextStyle(color: const Color(0xff121619)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture(ProfileImageController _imageProvider,
      double width, ProfileController _profileController) {
    return Center(
      child: CircleAvatar(
        radius: width * 0.22,
        backgroundColor: AppStyles.indigoColor,
        child: CircleAvatar(
          radius: width * 0.21,
          backgroundColor: AppStyles.whiteColor,
          child: _imageProvider.profileImage == null
              ? IconButton(
                  onPressed: () async {
                    await _imageProvider.pickImage(_profileController);
                  },
                  icon: Icon(
                    AppStyles.person,
                    color: AppStyles.indigoColor,
                    size: width * 0.3,
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(_imageProvider.profileImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _buildEditIcon(_imageProvider, _profileController),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildEditIcon(ProfileImageController _imageProvider,
      ProfileController _profileController) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: const Color(0xff5063BF),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: () async {
          await _imageProvider.pickImage(
              _profileController); // Pass authController to pickImage
        },
        icon: Icon(AppStyles.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    double height,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.medium16(AppStyles.greenColor),
        ),
        SizedBox(height: height * 0.007),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppStyles.regular16(AppStyles.grayColor),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppStyles.greenColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppStyles.greenColor,
                width: 1.5,
              ),
            ),
          ),
          style: AppStyles.regular20(AppStyles.blackColor),
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }

  Widget _buildNextButton(
      double width,
      double height,
      String firstName,
      String lastName,
      String _userId,
      ProfileController _profileController,
      BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _profileController.setFirstName(firstName);
          _profileController.setLastName(lastName);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false, // Removes all previous routes
          );
        },
        child: Container(
          width: width * 0.5,
          height: height * 0.06,
          decoration: BoxDecoration(
            color: AppStyles.greenColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Next",
              style: AppStyles.medium20(AppStyles.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
