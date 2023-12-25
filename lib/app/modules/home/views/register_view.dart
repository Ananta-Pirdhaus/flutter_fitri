import 'dart:math';
import 'package:appwrite/models.dart' as models;
import 'package:flipcard_game/app/modules/home/views/login_view.dart';
import 'package:flipcard_game/app/modules/home/widgets/button_register.dart';
import 'package:flipcard_game/app/modules/home/widgets/my_textfield.dart';
import 'package:flipcard_game/app/modules/home/widgets/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:shared_preferences/shared_preferences.dart';

final client = Appwrite.Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6588d8c1031e28eb430e');
final account = Appwrite.Account(client);

String generateRandomString() {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-';
  final random = Random();
  return List.generate(
      36, (index) => characters[random.nextInt(characters.length)]).join();
}

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isLoggedIn', value);
  }

  // text editing controllers
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    try {
      if (isPasswordConfirmed()) {
        // Creating an account using provided data
        final user = await account.create(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          userId: generateRandomString(),
        );

        // Creating an email session for the newly created account
        final models.Session response = await account.createEmailSession(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Handling SharedPreferences
        final SharedPreferences prefs = await _prefs;
        prefs.setString('userId', response.userId);
        prefs.setString('email', emailController.text.trim());
        prefs.setString('password', passwordController.text.trim());
        setLoggedIn(true);

        print(user);
      } else {
        // Showing a Snackbar if password confirmation fails
        Get.snackbar(
          "Password Confirmation",
          "Password and Confirm Password do not match.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        return; // Exiting the function if password confirmation fails
      }

      // Navigating to the HomePage if sign-up is successful
      Get.to(() => LoginView());

      // Showing a success Snackbar after successful sign-up
      Get.snackbar(
        "Sign Up Success",
        "Welcome to the app!",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      // Handling errors during sign-up
      print("Error during sign up: $e");

      // Showing an error Snackbar if sign-up fails
      Get.snackbar(
        "Sign Up Error",
        "There was an error during sign up. Please check your Email and Password.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  bool isPasswordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.monetization_on_rounded,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text(
                  'Lets register with our app >_<',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
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
                ButtonRegister(
                  onTap: signUp,
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
                      child: SquareTile(imagePath: 'lib/app/assets/google.png'),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: SquareTile(imagePath: 'lib/app/assets/apple.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LoginView());
                      },
                      child: Text(
                        'Lets Sign In',
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
    );
  }
}
