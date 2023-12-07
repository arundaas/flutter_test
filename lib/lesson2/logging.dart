import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sample/lesson2/HomePage.dart';

//email field

class EmailInput extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const EmailInput({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextFormField(
          // key: Key('emailInput'),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter valid email id as abc@gmail.com',
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required"),
            EmailValidator(errorText: "Enter valid email id"),
          ]),
        ));
  }
}

class PasswordInput extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const PasswordInput({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextFormField(
            // key: Key('passwordInput'),
            obscureText: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter secure password'),
            validator: MultiValidator([
              RequiredValidator(errorText: "* Required"),
              MinLengthValidator(6,
                  errorText: "Password should be atleast 6 characters"),
              MaxLengthValidator(15,
                  errorText:
                      "Password should not be greater than 15 characters")
            ])
            //validatePassword,        //Function to check validation
            ));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => __LoginPageState();
}

class __LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/flutter-logo.png')),
                ),
              ),
              Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: EmailInput(formKey: formkey)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: PasswordInput(
                  formKey: formkey,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  disabledForegroundColor:
                      const Color.fromARGB(255, 54, 149, 244),
                ),
                onPressed: null,
                child: Text('Forget Password'),
              ),
              SizedBox(
                height: 50,
                width: 250,
                // decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              Text('New User? Create Account')
            ],
          ),
        ),
      ),
    );
  }
}
