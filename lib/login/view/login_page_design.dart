import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/home/view/home_page_design.dart';
import 'package:flutter_app_demo/login/model/login_collect.dart';
import 'package:flutter_app_demo/registration/view/registration_page_design.dart';

class LoginPageDesign extends StatefulWidget {
  const LoginPageDesign({Key? key}) : super(key: key);

  @override
  _LoginPageDesignState createState() => _LoginPageDesignState();
}

class _LoginPageDesignState extends State<LoginPageDesign> {
  bool _passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(children: [
        Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.3,
          child: FlutterLogo(),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hintText: "Enter EmailId"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: passwordController,
            obscureText: !_passwordVisible,
            //This will obscure text dynamically
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
              hintText: "Enter Your Password",
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(status),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(80, 10, 80, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            onPressed: () {
              CollectUserLoginData()
                  .loginRequiedData(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((value) {
                setState(() {
                  loading = false;
                  status = value;
                  if(status=="sucessful login"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePageDesign()),
                    );
                  }
                });
              });
              setState(() {
                loading = true;
                status = "";
              });


            },
            child:
                loading == false ? Text('Login') : CircularProgressIndicator(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
              child: Text(
            "OR",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(80, 0, 80, 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationPageDesign()),
              );
            },
            child: Text('Register'),
          ),
        ),
      ]),
    ));
  }

  bool loading = false;
  String status = "";
}
