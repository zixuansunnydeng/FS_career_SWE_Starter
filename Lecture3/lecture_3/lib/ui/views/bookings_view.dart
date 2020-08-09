import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class BookingsView extends StatefulWidget {
  final void Function(String) setupUserEmail;

  BookingsView({@required this.setupUserEmail});
  @override
  _BookingsViewState createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  bool loggedin = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<Map<String, dynamic>> login(email, password) async {
    var param = {
      'email': email,
      'password': password,
    };
    var headers = {'Content-type': 'application/json'};
    var endpoint = 'http://52.205.82.172/login';
    var response =
        await post(endpoint, headers: headers, body: json.encode(param));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Bookings', style: TextStyle(color: Colors.white))),
        body: loggedin
            ? BookingsColumn()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'email',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'password',
                      ),
                    ),
                    SizedBox(height: 16),
                    RaisedButton(
                      onPressed: () async {
                        // call login api
                        var response = await login(
                            emailController.text, passwordController.text);
                        print(response);
                        var output = response['status'];
                        if (output == 'Success') {
                          // do something
                          for (var resName in response['user_reservations']) {
                            Provider.of<List<String>>(context, listen: false)
                                .add(resName);
                          }
                          widget.setupUserEmail(emailController.text);
                          setState(() {
                            loggedin = true;
                          });
                        } else if (output == 'Incorrect email') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Wrong Email'),
                                  content:
                                      Text('Please into the correct email'),
                                );
                              });
                        } else if (output == 'Wrong Password') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Wrong Password'),
                                  content:
                                      Text('Please into the correct password'),
                                );
                              });
                        }
                      },
                      child:
                          Text('Log In', style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                    ),
                  ],
                ),
              ));
  }
}

class BookingsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bookings = Provider.of<List<String>>(context, listen: false);
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(bookings[index]),
        );
      },
    );
  }
}
