import 'package:flutter/material.dart';
import 'package:flutter_events/dao/user_dao.dart';
import 'package:flutter_events/model/signup_model.dart';
import 'package:flutter_events/model/user_model.dart';
import 'package:flutter_events/navigator/tab_navigator.dart';
import 'package:flutter_events/pages/prompt_page.dart';
import 'package:flutter_events/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  UserModel userModel;
  PromptPage promptPage = new PromptPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Opacity(
          opacity: 0.5,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('images/sign_up_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 53, top: 180),
            width: MediaQuery.of(context).size.width * 0.77,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    icon: Icon(
                      Icons.account_circle,
                    ),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(
                      Icons.lock_outline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: FlatButton(
              child: Container(
                height: 30,
                width: 230,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                ),
                child: Center(
                    child: Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                        ))),
              ),
              onPressed: () {
                print('Login');
                String username = _usernameController.text;
                String password = _passwordController.text;
                _handleSubmit(username, password);
              },
            ),
          ),
          Center(
              child: FlatButton(
            child: Text("Don't have an account ?  Sign Up",
                style: TextStyle(
                  color: Color(0xff000000),
                )),
            onPressed: () {
              print('sign up');
              _openSignUp();
            },
          ))
        ],
      )
    ]));
  }

  _openSignUp() {
    setState(() {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return SignupPage();
        },
      ));
    });
  }

  _handleSubmit(String username, String password) {
    String signupUrl =
        'http://10.0.2.2:5000/login?username=$username&password=$password';
//        'http://172.20.10.5:8080/http_server/login?name=$username&password=$password';
    UserDao.fetch(signupUrl).then((SignupModel model) async {
      print(model.errno);
      if (model.errno == 0) {
        setState(() {
          userModel = model.data;
        });
        _jumpToHomePage(userModel);
      } else if (model.errno == 1) {
        await promptPage.showMessage(context, "Invalid password!");
        return;
      } else if (model.errno == 2) {
        await promptPage.showMessage(
            context, "Username does not exist!");
      }
    });
  }

  _jumpToHomePage(UserModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabNavigator(
                  userModel: model,
                )));
  }
}
