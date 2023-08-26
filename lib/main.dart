import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Definición de eventos
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

// Definición de estados
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthAuthenticatedState extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginEvent) {
      // Simulación de lógica de inicio de sesión
      if (event.username == 'usuario' && event.password == 'contrasena') {
        yield AuthAuthenticatedState();
      }
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Example',
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FeedPage()),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLoginEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FeedPage extends StatelessWidget {
  final List<Post> posts = [
    Post(
      username: 'usuario1',
      imageUrl: 'los-ciclistas-mas-populares-en-instagram.jpg',
      content: 'Contenido del post 1',
    ),
    Post(
      username: 'usuario2',
      imageUrl: 'los-ciclistas-mas-populares-en-instagram.jpg',
      content: 'Contenido del post 2',
    ),
    // Agregar más publicaciones aquí...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BicigoFeed')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.imageUrl),
            ),
            title: Text(post.username),
          ),
          Image.network(post.imageUrl),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String username;
  final String imageUrl;
  final String content;

  Post({required this.username, required this.imageUrl, required this.content});
}
