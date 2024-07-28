import 'package:flutter/material.dart';
import 'package:news_app/views/signup_screen.dart';
import 'package:news_app/views/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../services/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F9FD),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        foregroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: kToolbarHeight-10,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 120),
              buildInputField(
                controller: _emailController,
                hintText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              buildInputField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const Spacer(),
              _buildLoginButton(context),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.bottom,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Signup",
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
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }





  Widget _buildLoginButton(BuildContext context) {
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
          if (_formKey.currentState?.validate() ?? false) {
            try {
              await context.read<AuthenticationService>().signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
            } catch (e) {
              setState(() {
                _errorMessage = 'User does not exist';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_errorMessage)),
              );
            }
          }
        },
        child: const Text(
          "Login",
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
