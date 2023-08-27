import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Info Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final String name = 'Peter Rodriguez';
   final String edad = '21';
  final String email = 'peroreye@espol.edu.ec';
  final String phoneNumber = '+593 987654421';
  final String photoUrl = 'https://example.com/profile.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(photoUrl),
            ),
            SizedBox(height: 20),
            Text('Name: $name'),
            SizedBox(height: 10),
            Text('Edad: $edad'),
            SizedBox(height: 10),
            Text('Email: $email'),
            SizedBox(height: 10),
            Text('Phone Number: $phoneNumber'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Por problemas del env, no he podido trabajar directamente en mi pc.
                // Aqui va la logica para cerrar sesion
              },
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
