// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pintreset_flutter_samin/data/UserSimplePrefeneces.dart';
import 'package:pintreset_flutter_samin/data/dataLogin.dart';
import 'package:pintreset_flutter_samin/provider/Provider.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<User> myAlldata = [];
  String name = '';
  String password = '';
  bool _passwordVisible = true, _rememberMe = true, check = false;
  final _fromkey = GlobalKey<FormState>();

  loadData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      for (var data in jsonBody) {
        myAlldata.add(User(
            id: data['id'],
            name: data['name'],
            username: data['username'],
            email: data['email'],
            address: Address.fromJson(data['address']),
            phone: data['phone'],
            website: data['website'],
            company: Company.fromJson(data['company'])));
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  void initState() {
    loadData();
    _passwordVisible = true;
    super.initState();
    name = UserSimplePreferences.getUsername() ?? '';
    if (UserSimplePreferences.getPass().toString() == 'null') {
      password = '';
    } else {
      password = UserSimplePreferences.getPass().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 40.0),
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            image: const DecorationImage(
                image: AssetImage('assets/images/1.png'), fit: BoxFit.fill),
            color: Colors.black,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        SizedBox(
          height: 40.0,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Welcome to Pinterest',
            textAlign: TextAlign.center,
            textScaleFactor: 1.7,
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30.0)),
        Form(
          key: _fromkey,
          child: Column(children: [
            SizedBox(
              width: 300.0,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                initialValue: name,
                decoration: InputDecoration(
                  border: myinputborder(),
                  enabledBorder: myinputborder(),
                  labelText: 'username',
                  labelStyle: const TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.only(left: 10.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter userName';
                  }
                  return null;
                },
                onChanged: (name) {
                  this.name = name;
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            SizedBox(
                width: 300.0,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  obscureText: _passwordVisible,
                  initialValue: password,
                  decoration: InputDecoration(
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                  onChanged: (password) {
                    this.password = password;
                  },
                )),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            _renderRememberMe(),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            ElevatedButton(
                onPressed: () async {
                  for (var i = 0; i < myAlldata.length; i++) {
                    if (name == myAlldata[i].username &&
                        password == myAlldata[i].id.toString()) {
                      //--------------------------------
                      await UserSimplePreferences.setUsername(
                          myAlldata[i].username);
                      await UserSimplePreferences.setPass(myAlldata[i].id);
                      check = true;
                      //-------///////////
                      Provider.of<hideShow>(context, listen: false)
                          .nextPage(context);
                    }
                  }
                  if (!check) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Result'),
                        content: const Text('Incorrect Username or Password'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'))
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 201, 33, 39),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('login'))
          ]),
        ),
      ]),
    ));
  }

  Widget _renderRememberMe() {
    return Row(children: <Widget>[
      GestureDetector(
        onTap: () => _pressRememberMe(!_rememberMe),
        child: Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: _pressRememberMe,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: const Text(
                  "Remember Me",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  void _pressRememberMe(val) {
    setState(() {
      _rememberMe = val;
    });
  }
}

OutlineInputBorder myinputborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 90, 187, 93),
        width: 2,
      ));
}
