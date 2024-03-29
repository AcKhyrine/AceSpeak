import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/frame3.jpg'),
              SizedBox(height: 20,),
              Text(
                'Receive an email to reset your password.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Email'),
                  autovalidateMode : AutovalidateMode.onUserInteraction,
                  validator: (email) => 
                    email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                resetPassword();
              }, child: Text('Reset Password')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> resetPassword() async {
  EasyLoading.show(status: 'Sending Password Reset Email...');
  
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailController.text.trim(),
    );
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Password Reset Email Sent');
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    print(e);
    EasyLoading.showError(e.toString());
  }
}

}