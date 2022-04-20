import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/home/view/home_page_design.dart';

import '../model/user_input_data.dart';

class RegistrationPageDesign extends StatefulWidget {
  const RegistrationPageDesign({Key? key}) : super(key: key);

  @override
  _RegistrationPageDesignState createState() => _RegistrationPageDesignState();
}

class _RegistrationPageDesignState extends State<RegistrationPageDesign> {
  bool _passwordVisible = false;
  String gender = "Gender";
  bool autofocuas = true;
  TextEditingController controllerMobile = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.3,
          child: FlutterLogo(),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controllerMobile,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hintText: "Enter EmailId"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controllerName,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                hintText: "Enter Your Password"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(statusUser, style: TextStyle(color: Colors.blue)),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            onPressed: () {
              CollectUserInputData()
                  .registrationRequiedData(
                      email: controllerMobile.text,
                      password: controllerName.text)
                  .then((value) {
                setState(() {
                  loding = false;
                  statusUser = value;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePageDesign()),
                  );
                });
              });
              setState(() {
                loding = true;

                statusUser = "";
              });
              /* showDialog(
                context: context,
                builder: (BuildContext context) => OtpPopUpDilog(context),
              );*/
            },
            child: loding == false
                ? const Text('Register')
                : CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ]),
    ));
  }

  bool loding = false;
  String statusUser = "";
}
