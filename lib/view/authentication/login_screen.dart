
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/profile_controller.dart';

import 'signup_proccess/auth_email.dart';
import '../../controller/auth_controller.dart';
import '../../model/app_style.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    final _authController = Provider.of<AuthController>(context);
    final _profileController = Provider.of<ProfileController>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: width * 0.05,
              top: height * 0.08,
              left: width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back!👋",
                  style: AppStyles.bold40(AppStyles.indigoColor),
                ),
                Text(
                  "Please Sign-in to \nyour account",
                  style: AppStyles.medium32(AppStyles.blackColor),
                ),
                SizedBox(height: height * 0.07),
                _buildInputLabel(
                  "Email Address",
                ),
                // SizedBox(height: height * 0.007),
                _buildEmailField(_authController),
                SizedBox(height: height * 0.04),
                _buildInputLabel(
                  "Password",
                ),
                // SizedBox(height: height * 0.007),
                _buildPasswordField(_authController),
                _buildTextResetPass(
                    context, _authController, _profileController),
                SizedBox(height: height * 0.05),
                _buildNextButton(
                  width,
                  height,
                  _emailController.text,
                  _passwordController.text,
                  _authController,
                  context,
                  _profileController,
                ),
                SizedBox(
                  height: height * 0.03,
                ),

                _buildTextHaveAcc(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Text(
      text,
      style: AppStyles.medium16(AppStyles.greenColor),
    );
  }

  Widget _buildPasswordField(AuthController _authController) {
    return _buildInputField(
      controller: _passwordController,
      obscureText: _authController.isPasswordHidden,
      toggleVisibility: _authController.togglePasswordVisibility,
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: toggleVisibility,
            ),
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
        ),
      ],
    );
  }

  Widget _buildEmailField(AuthController _authController) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "rasseni@gmail.com",
        hintStyle: AppStyles.regular16(AppStyles.grayColor),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppStyles.greenColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppStyles.greenColor,
            width: 1.5,
          ),
        ),
      ),
      style: AppStyles.regular20(AppStyles.blackColor),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildNextButton(
    double width,
    double height,
    String email,
    String password,
    AuthController _authController,
    BuildContext context,
    ProfileController _profileController,
  ) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _authController.setEmail(email);
          _authController.setPassword(password);
          _authController.loginUser(context, _profileController);
        },
        child: Container(
          width: width * 0.5,
          height: height * 0.06,
          decoration: BoxDecoration(
            color: AppStyles.greenColor,
            borderRadius: BorderRadius.circular(35),
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

  Widget _buildTextResetPass(BuildContext context,
      AuthController _authController, ProfileController _profileController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            _resetPassword(context, _authController, _profileController);
          },
          child: Text(
            "Forget password?",
            style: AppStyles.regular16(AppStyles.indigoColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTextHaveAcc(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AuthEmail(),
            ),
            ModalRoute.withName('/'),
          );
        },
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: "Don’t have an account? ",
            style: AppStyles.regular16(AppStyles.blackColor),
            children: [
              TextSpan(
                text: "Sign up",
                style: AppStyles.regular16(AppStyles.indigoColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetPassword(
    BuildContext context,
    AuthController _authController,
    ProfileController _profileController,
  ) async {
    final _emailResetController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailResetController,
                decoration:
                    const InputDecoration(labelText: 'Enter your email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _authController.resetPassword(
                    context, _emailResetController.text);
              },
              child: const Text('Reset Password'),
            ),
          ],
        );
      },
    );
  }
}
