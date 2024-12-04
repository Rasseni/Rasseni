import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/auth_controller.dart';
import '../../../model/app_style.dart';

class AuthPassword extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final _authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: height * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: height * 0.07),
                _buildPasswordField(_authController),
                SizedBox(height: height * 0.02),
                _buildConfirmPasswordField(_authController),
                SizedBox(height: height * 0.07),
                _buildNextButton(context, width, height, _authController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please enter your",
          style: AppStyles.bold40(AppStyles.blackColor),
        ),
        Text(
          "password",
          style: AppStyles.medium32(AppStyles.indigoColor),
        ),
      ],
    );
  }

  Widget _buildPasswordField(AuthController _authController) {
    return _buildInputField(
      label: "Password",
      controller: _passwordController,
      obscureText: _authController.isPasswordHidden,
      toggleVisibility: _authController.togglePasswordVisibility,
    );
  }

  Widget _buildConfirmPasswordField(AuthController _authController) {
    return _buildInputField(
      label: "Confirm Password",
      controller: _confirmPasswordController,
      obscureText: _authController.isPasswordHidden,
      toggleVisibility: _authController.togglePasswordVisibility,
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.regular16(AppStyles.greenColor),
        ),
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
        ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context, double width, double height,
      AuthController _authController) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Validate email and password
          if (_authController.email == null || _authController.email!.isEmpty) {
            _showSnackBar(context, "Email cannot be empty.");
            return;
          }
          if (_passwordController.text.isEmpty) {
            _showSnackBar(context, "Password cannot be empty.");
            return;
          }
          if (_confirmPasswordController.text.isEmpty) {
            _showSnackBar(context, "Confirm password cannot be empty.");
            return;
          }
          if (_passwordController.text != _confirmPasswordController.text) {
            _showSnackBar(context, "Passwords do not match.");
            return;
          }

          // Set password and proceed with registration
          _authController.setPassword(_passwordController.text);
          _authController.registerUser (context);
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

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red, // Change color to indicate error
      ),
    );
  }
}
