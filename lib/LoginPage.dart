import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _registerUser() {
    // Perform registration logic here
    String email = _emailController.text;
    String password = _passwordController.text;

    // For demonstration, just print the user details
    print('User Registered:');
    print('Email: $email');
    print('Password: $password');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      // SIGN UP TEXT---HEADER TEXT
                      Text('Log In', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black87),),
                      // DON'T HAVE AN ACCOUNT.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't Have An Account? ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),),
                          GestureDetector(onTap: (){ GoRouter.of(context).go('/sign-up');}, child: const Text('Sign Up', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),)),
                        ],
                      ),
                      SizedBox(height: 40,),
                      // EMAIL FIELD
                      textField(hText: 'Enter Your Email', lText: 'Email Address', errorMessage: 'Please enter your email', controller: _emailController),
                      SizedBox(height: 10,),
                      // PASSWORD FIELD
                      textField(hText: 'Enter Your Password', lText: 'Password', errorMessage: 'Please enter your password', controller: _passwordController),
                      SizedBox(height: 40,),
                      // SUBMIT BUTTON
                      GestureDetector(
                        onTap: () {
                        if (_formKey.currentState!.validate()) {
                            // All fields are valid, proceed with registration
                            _registerUser();
                            GoRouter.of(context).go('/home');
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10), // Adjust the value to change the roundness
                          ),
                          child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
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
