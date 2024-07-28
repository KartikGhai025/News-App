import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../services/authentication_service.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F9FD),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: kToolbarHeight - 10,
        backgroundColor: const Color(0XFFF5F9FD),
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 19),
          child: Text(
            "MyNews",
            style: TextStyle(
              color: Color(0XFF0C54BE),
              fontSize: 26,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          children: [
            const SizedBox(height: 120),
            buildInputField(
              controller: nameInputController,
              hintText: "Name",
            ),
            const SizedBox(height: 18),
            buildInputField(
              controller: emailInputController,
              hintText: "Email",
            ),
            const SizedBox(height: 18),
            buildInputField(
              controller: passwordInputController,
              hintText: "Password",
              obscureText: true,
            ),
            const Spacer(),
            _buildSignupButton(context),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: Color(0XFF000000),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const TextSpan(text: " "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0XFF0C54BE),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 62),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF0C54BE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        onPressed: () async {
          final authService =
              Provider.of<AuthenticationService>(context, listen: false);
          final name = nameInputController.text;
          final email = emailInputController.text;
          final password = passwordInputController.text;

          try {
            await authService.signUp(
                email: email, password: password, name: name);
            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign up failed: $e')),
            );
          }
        },
        child: const Text(
          "Signup",
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
