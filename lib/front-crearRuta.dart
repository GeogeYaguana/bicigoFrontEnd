import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Example',
      home: FeedPage(),
    );
  }
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Post> posts = [
    Post(
      username: 'usuario1',
      imageUrl: 'los-ciclistas-mas-populares-en-instagram.jpg',
      content: 'Contenido del post 1',
    ),
  ];

  void _openCreateRouteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateRouteDialog(
          onCreate: (String name, String difficulty, String startPoint, String endPoint) {
            setState(() {
              posts.add(Post(
                username: 'usuario1',
                imageUrl: 'ruta-imagen.jpg',
                content: 'Nombre: $name\nDificultad: $difficulty\nPunto de partida: $startPoint\nPunto final: $endPoint',
              ));
            });
            Navigator.of(context).pop(); // Cerrar el diálogo después de guardar
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BicigoFeed'),
        actions: [
          TextButton(
            onPressed: _openCreateRouteDialog,
            child: Text(
              'Crear Ruta',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
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

class CreateRouteDialog extends StatefulWidget {
  final Function(String, String, String, String) onCreate;

  CreateRouteDialog({required this.onCreate});

  @override
  _CreateRouteDialogState createState() => _CreateRouteDialogState();
}

class _CreateRouteDialogState extends State<CreateRouteDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();
  final TextEditingController _startPointController = TextEditingController();
  final TextEditingController _endPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Crear Ruta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _difficultyController,
            decoration: InputDecoration(labelText: 'Dificultad'),
          ),
          TextField(
            controller: _startPointController,
            decoration: InputDecoration(labelText: 'Punto de partida'),
          ),
          TextField(
            controller: _endPointController,
            decoration: InputDecoration(labelText: 'Punto final'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCreate(
              _nameController.text,
              _difficultyController.text,
              _startPointController.text,
              _endPointController.text,
            );
          },
          child: Text('Guardar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }
}
