import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  late DocumentSnapshot _userDocument;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection('users').doc(_user.uid).get();
      setState(() {
        _userDocument = userDocument;
      });
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: _userDocument == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${_userDocument['name']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('College: ${_userDocument['college']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Address: ${_userDocument['address']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Phone: ${_userDocument['phone']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Email: ${_userDocument['email']}', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
    );
  }
}
