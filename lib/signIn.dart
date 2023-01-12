// ignore_for_file: use_build_context_synchronously
import 'package:cardiotoxicity/dbHelper.dart';
import 'package:cardiotoxicity/home.dart';
import 'package:cardiotoxicity/signup.dart';
import 'package:flutter/material.dart';

//Sign In Page
//Validates that user exist with the username and the password
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() {
    return SignInPageState();
  }
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  static late User _loggeduser;

  TextEditingController passController = TextEditingController();
  TextEditingController userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0)),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              controller: userController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              controller: passController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 8 || value.length > 30) {
                  return 'Password must be between 8-30 characters long';
                }
                return null;
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                side: const BorderSide(width: 3, color: Colors.black12),
                elevation: 3,
                fixedSize: const Size(200, 50),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //Validate database data
                  _loggeduser = await getUser();
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              username: userController.text,
                              password: passController.text,
                            )),
                  );
                  //Displaying a SnackBar to verify the user that logged in
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Welcome ${userController.text}'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Error to Log in'),
                    ),
                  );
                }
              },
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpForm()),
                    );
                  },
                  child: const Text(
                    "Sing up ",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<User> getUser() async {
    await DBHelper.database();
    var ak = await DBHelper.fetchUser(passController.text, userController.text);
    return User.fromMap(ak);
  }
}
