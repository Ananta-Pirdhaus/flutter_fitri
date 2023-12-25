import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as models;
import 'package:flipcard_game/app/modules/home/views/home_view.dart';
import 'package:flipcard_game/app/modules/home/views/register_view.dart';
import 'package:flipcard_game/app/modules/home/widgets/my_button.dart';
import 'package:flipcard_game/app/modules/home/widgets/my_textfield.dart';
import 'package:flipcard_game/app/modules/home/widgets/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final client = Appwrite.Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6588d8c1031e28eb430e');
final account = Appwrite.Account(client);

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isLoggedIn', value);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  void signUserIn() async {
    final SharedPreferences prefs = await _prefs;
    try {
      final models.Session response = await account.createEmailSession(
        email: emailController.text,
        password: passwordController.text,
      );
      prefs.setString('userId', response.userId);
      final String storedUserId = prefs.getString('userId') ?? "";

      if (response.userId == storedUserId) {
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
        setLoggedIn(true);

        Get.to(() => HomeView());

        Get.snackbar(
          "Login Success",
          "Welcome to the app!",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      } else {
        print("Result type: ${response.runtimeType}");
        print("Error during login: ${response}");
        Get.snackbar(
          "Login Error",
          "There was an error during login. Please check your Email and Password.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Error during login: $e");
      Get.snackbar(
        "Login Error",
        "There was an error during login. Please check your Email and Password.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    key: Key('emailTextField'),
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!value.contains('@')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    key: Key('passwordTextField'),
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) => value!.length < 8
                        ? "Password must be at least 8 characters"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    key: Key('loginButton'),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        signUserIn();
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                        child:
                            SquareTile(imagePath: 'lib/app/assets/google.png'),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child:
                            SquareTile(imagePath: 'lib/app/assets/apple.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterView());
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
