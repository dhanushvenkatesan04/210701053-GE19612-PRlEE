import 'package:flutter/material.dart';
import 'package:pree/Api_call/apiCall.dart';
import 'package:pree/pages/addFood.dart';
import 'package:pree/provider/loginuid.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  int loginStatus = 0;

  Future<void> yourFunctionName(loginuid a) async {
    try {
      loginStatus = await apiCall.login(email.text, pass.text, a);
      // Use the loginStatus value here
    } catch (e) {
      // Handle any errors that occurred during the login process
      print("Error during login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, val, child) => SizedBox(
          child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // int loginStatus=0;
                  // Future<int> loginStatus=apiCall.login(email.text, pass.text);
                  yourFunctionName(val);
                  print(apiCall.getFood());
                  print(loginStatus);
                  if (loginStatus == 1) {
                    print("****");
                    print(val.User_Org);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddFood()),
                    );
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Login Failed. Please try again.'),
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
