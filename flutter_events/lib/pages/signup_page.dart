import 'package:flutter/material.dart';
import 'package:flutter_events/dao/user_dao.dart';
import 'package:flutter_events/model/signup_model.dart';
import 'package:flutter_events/model/user_model.dart';
import 'package:flutter_events/navigator/tab_navigator.dart';
import 'package:flutter_events/pages/prompt_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  UserModel userModel;
  String _correctUsername = '';
  String _correctPassword = '';
  PromptPage promptPage = new PromptPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Opacity(
          opacity: 0.5,
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('images/sign_up_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 53, top: 140),
            width: MediaQuery.of(context).size.width * 0.77,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      errorText:
                          (_correctUsername == "") ? null : _correctUsername,
                      icon: Icon(
                        Icons.account_circle,
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        if (value.isEmpty) {
                          _correctUsername = "Username cannot be empty";
                        } else if (value.trim().length < 3) {
                          _correctUsername =
                              "Username length is less than 3 bits";
                        } else {
                          _correctUsername = "";
                        }
                      });
                    }),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: 'Password',
                    errorText:
                        (_correctPassword == "") ? null : _correctPassword,
                    icon: new Icon(
                      Icons.lock_outline,
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      if (value.isEmpty) {
                        _correctPassword = "Password cannot be empty";
                      } else if (value.trim().length < 6) {
                        _correctPassword =
                            "Password length is less than 6 bits";
                      } else {
                        _correctPassword = "";
                      }
                    });
                  },
                )
              ],
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 60),
              child: FlatButton(
                child: Container(
                  height: 30,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                  child: Center(
                      child: Text("Join",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                ),
                onPressed: () {
                  print('Join');
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  _handleSubmit(username, password);
                },
              ),
            ),
          ),
        ],
      ),
      Container(
        padding: EdgeInsets.only(top: 45, left: 20),
        child: BackButton(),
      )
    ]));
  }

  _handleSubmit(String name, String password) async {
    //TODO: handle invalid input => prompt page
    if (name == '' || password == '') {
      await promptPage.showMessage(context, "Invalid input!");
      return;
    }
    String signupUrl =
        'http://10.0.2.2:5000/signup?name=$name&password=$password';
//    'http://172.20.10.5:8080/http_server/signup?name=$username&password=$password';
    UserDao.fetch(signupUrl).then((SignupModel model) async {
      print(model.toJson());
      if (model.errno == 0) {
        setState(() {
          userModel = model.data;
        });
        _jumpToHomePage(userModel);
      } else if (model.errno == 1) {
        await promptPage.showMessage(context, "Username already exists!");
        return;
      } else if (model.errno == 2) {
        await promptPage.showMessage(
            context, "Username or password format is incorrect!");
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
