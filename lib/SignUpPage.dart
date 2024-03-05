import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String btnSubmit = "Submit";

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  Future<void> _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', text);
  }

  Future<void> _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('userId') != '' && prefs.getString('userId') != null){
      context.go('/home');
      print(prefs.getString('userId'));
    }
  }



  void _registerUser (BuildContext context) async {
    setState(() {
      btnSubmit = "Loading...";
    });
    // Perform registration logic here
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // For demonstration, just print the user details
    // print('User Registered:');
    // print('First Name: $firstName');
    // print('Last Name: $lastName');
    // print('Email: $email');
    // print('Password: $password');

    // Save user info to db
    try {

      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> user = {
       "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "password": password
      };

      final url = Uri.parse('https://flutternewsdb.onrender.com/user');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(user);

      final response = await http.post(url, headers: headers, body: body);

      if(response.statusCode == 201){
        setState(() {
          _isLoading = false;
          btnSubmit = "Successful";
        });

        Map userData = json.decode(response.body);
        String idNumber = userData['_id'];
        // save it using shared preference!
        await _saveText(idNumber);
        // route to the home page if everything goes well.
        GoRouter.of(context).go('/home');
      }

    } catch(e) {
      setState(() {
        btnSubmit = "Try Again";
      });

      print('Request failed with status: ${e}');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SIGN UP TEXT---HEADER TEXT
                    const Text('Sign Up', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black87),),
                    // ALREADY HAVE AN ACCOUNT.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have An Account? ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),),
                        GestureDetector(onTap: (){ GoRouter.of(context).go('/log-in');}, child: const Text('Log In', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),)),
                      ],
                    ),
                    SizedBox(height: 40,),
                    // FIRSTNAME FIELD
                    textField(hText: 'Enter Your First Name', lText: 'First Name', errorMessage: 'Please enter your first name', controller: _firstNameController),
                    SizedBox(height: 10,),
                    // LASTNAME FIELD
                    textField(hText: 'Enter Your Last Name', lText: 'Last Name', errorMessage: 'Please enter your last name', controller: _lastNameController),
                    SizedBox(height: 10,),
                    // EMAIL FIELD
                    textField(hText: 'Enter Your Email', lText: 'Email Address', errorMessage: 'Please enter your email', controller: _emailController),
                    SizedBox(height: 10,),
                    // PASSWORD FIELD
                    textField(hText: 'Enter Your Password', lText: 'Password', errorMessage: 'Please enter your password', controller: _passwordController),
                    SizedBox(height: 40,),
                    // SUBMIT BUTTON
                    GestureDetector(
                      onTap:_isLoading ?
                      null : () {
                        if (_formKey.currentState!.validate()) {
                          // All fields are valid, proceed with registration
                          _registerUser(context);

                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10), // Adjust the value to change the roundness
                        ),
                        child: Center(
                            child: Text(
                              btnSubmit,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 25),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({
    required String hText,
    required String lText,
    required String errorMessage,
    required TextEditingController controller})
  {
    var result = Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hText,
          labelText: lText,
          labelStyle: const TextStyle(color: Colors.black38, fontSize: 14),
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
    return result;
  }


}
