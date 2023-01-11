// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cardiotoxicity/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

//Sign Up Page that contains a Form that ask user to enter some data
//When the user press the ign Up button it validate that the entities are correct(type,length etc.)
class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

//Text Controllers for each TextField
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ), // Build a Form widget using the _formKey created above.
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0)),
                        Text("Sign Up",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            controller: nameController,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Surname',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            controller: surnameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            controller: birthdateController,
                            //Controller that is holding the birthdate
                            decoration: InputDecoration(
                              labelText: "Date of birth", //labels
                              hintText: "Ex. Insert your dob",
                            ),
                            onTap: () async {
                              DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());
                              //Displaying a datePicker for the user to enter the birth date
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              //Formatting the date in a more readable way - dd-mm-yyyy
                              final DateFormat formatterDate =
                                  DateFormat('dd/MM/yyyy');
                              final String birthDate =
                                  formatterDate.format(date!);
                              birthdateController.text = birthDate;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          DropdownButtonFormField(
                              //Setting the default value
                              value: selectedGender,
                              //The List with all the available options
                              items: dropdownItems,
                              onChanged: (String? newValue) {
                                //Adding the new value to the selectedGender String if changed
                                setState(() {
                                  selectedGender = newValue!;
                                });
                              }),
                          Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Weight',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            controller: weightController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              final isDigitOnly = int.tryParse(value);

                              return isDigitOnly == null
                                  ? 'Please enter only number'
                                  : null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            controller: usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
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
                          Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            controller: emailController,
                            validator: (value) {
                              if (value == null ||
                                  !value.contains("@") ||
                                  !value.contains(".")) {
                                //Email Validation
                                //Looking for @ and .
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 45.0),
                            child: SizedBox(
                              height: 70,
                              //height of button
                              width: 370,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigoAccent,
                                    side: BorderSide(
                                        width: 3, color: Colors.black12),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        //To set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: EdgeInsets.all(20)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    //Validate all the data and adding user to the database
                                    _addUser();
                                    //Returning back to sign in page if the data are validated
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    //Adding the user to the database
    await DBHelper.database();
    DBHelper.insert('users', {
      'name': nameController.text,
      'surname': surnameController.text,
      'birthdate': birthdateController.text,
      'gender': selectedGender,
      'weight': weightController.text,
      'username': usernameController.text,
      'password': passController.text,
      'email': emailController.text,
    });
  }

  void resetData() {
    //Clear Text Controllers
    nameController.clear();
    surnameController.clear();
    birthdateController.clear();
    weightController.clear();
    genderController.clear();
    usernameController.clear();
    passController.clear();
    emailController.clear();
  }
}

String selectedGender = "Male"; //Default value for gender

List<DropdownMenuItem<String>> get dropdownItems {
  //Creating a list of Dropdown menu with the possible options
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(value: "Male", child: Text("Male")),
    DropdownMenuItem(value: "Female", child: Text("Female")),
    DropdownMenuItem(
        value: "Don't want to declare", child: Text("Don't want to declare")),
  ];
  return menuItems;
}
