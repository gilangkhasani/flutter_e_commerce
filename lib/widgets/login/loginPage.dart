import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utility.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageSate createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  String _email;
  String _password;

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final formkey = new GlobalKey<FormState>();
  bool _saving = false;

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  checkLogin() {
    if (checkFields()) {
      Utility.showLoading(context, true);
      new Future.delayed(new Duration(seconds: 3), () {
        Utility.showAlert(context, "homepage", "Login Success");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage(
            "images/flutter1.png",
          ),
          height: 30.0,
          fit: BoxFit.fitHeight,
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 110.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/monkey.gif'), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                  child: Form(
                key: formkey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _input(
                          "required email",
                          false,
                          "Email",
                          'Enter your Email',
                          TextInputType.emailAddress,
                          TextInputAction.next,
                          focusNodeEmail,
                          focusNodePassword,
                          (value) => _email = value),
                      SizedBox(
                        width: 20.0,
                        height: 20.0,
                      ),
                      _input(
                          "required password",
                          true,
                          "Password",
                          'Password',
                          TextInputType.text,
                          TextInputAction.done,
                          focusNodePassword,
                          null,
                          (value) => _password = value),
                      new Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: OutlineButton(
                                          child: Text("Login "),
                                          onPressed: checkLogin),
                                      flex: 1,
                                    ),
                                    SizedBox(
                                      height: 18.0,
                                      width: 18.0,
                                    ),
                                    SizedBox(
                                      height: 18.0,
                                      width: 18.0,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: OutlineButton(
                                          //child: Text("login with google"),
                                          // child: ImageIcon(AssetImage("images/google1.png"),semanticLabel: "login",),
                                          child: Text("Sign Up"),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed("/signup");
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String validation, bool, String label, String hint,
      keyboardType, textInputAction, focusNode, focus, save) {
    return new TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      textInputAction: textInputAction,
      obscureText: bool,
      validator: (value) => value.isEmpty ? validation : null,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus);
      },
      onSaved: save,
    );
  }
}
