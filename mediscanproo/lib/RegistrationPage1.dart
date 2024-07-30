import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'LoginPage1.dart';
import 'LoginPage.dart';

class RegistrationPage1 extends StatefulWidget {
  final bool isOrg;

  RegistrationPage1({this.isOrg = true});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage1> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user info in Firestore
      await FirebaseFirestore.instance.collection(widget.isOrg ? 'Organisation' : 'Users').doc(userCredential.user?.uid).set({
        'email': email,
      });

      // Navigate to login page
      if (mounted) { // Check if widget is still mounted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication errors
      print('Failed with error code: ${e.code}');
      print(e.message);
      // Show error to user if needed
    } catch (e) {
      // Handle other potential errors
      print('An unexpected error occurred: $e');
      // Show error to user if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isOrg ? 'Register as ORG' : 'Register as User'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SvgPicture.asset(
                //   'assets/logo.svg', // Replace with the path to your SVG
                //   height: 100,
                // ),
                SizedBox(height: 20),
                Text(
                  'Join us and make a difference!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage1()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage1()),
                    );
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
