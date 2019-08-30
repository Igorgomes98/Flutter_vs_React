import 'dart:convert';
import './src/Post.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<PostList> fetchPost() async {
  final foto = await http
      .get('https://instalura-api.herokuapp.com/api/public/fotos/rafael');

  if (foto.statusCode == 200) {
    final jsonResponse = json.decode(foto.body);
    PostList listaPost = PostList.fromJson(jsonResponse);
    return listaPost;
  } else {
    throw Exception('Failed to load post');
  }
}

void main() => runApp(MyApp(foto: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<PostList> foto;
  MyApp({Key key, this.foto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instalura Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(foto: foto),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.foto}) : super(key: key);
  final Future<PostList> foto;

  @override
  _MyHomePageState createState() => _MyHomePageState(foto: foto);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({Key key, this.foto});
  Future<PostList> foto;
  Future<Post> post;

  carregaIcone(likeada) {
    return likeada
        ? Image.asset('assets/img/likeada.png')
        : Image.asset('assets/img/like.png');
  }

  like(like) {
      return !like;
  }

  exibeLikes(likers) {
    if (likers.length <= 0) return Container();
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              child: Text(
            '{$likers.length}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          Container(
              child: likers.length > 1
                  ? Text('Likes', style: TextStyle(fontWeight: FontWeight.bold))
                  : Text('Like', style: TextStyle(fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  exibeLegenda(foto) {
    if (foto.comentario == '') return Container();
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: Text(foto.loginUsuario,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            child: Text(foto.comentario),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: FutureBuilder<PostList>(
          future: foto,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return (Container(
                child: ListView.builder(
                  itemCount: snapshot.data.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Center(
                                    child: Row(
                                  children: <Widget>[
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data.posts[index]
                                                    .urlPerfil))),
                                    Container(
                                      child: Text(snapshot
                                          .data.posts[index].loginUsuario),
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
                          Container(
                            width: width,
                            height: width,
                            child: Image.network(
                                snapshot.data.posts[index].urlFoto),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {                                    
                                    setState(() {
                                       snapshot.data.posts[index].likeada = like(snapshot.data.posts[index].likeada);                                      
                                    });                                    
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        width: 40,
                                        height: 40,
                                        child: carregaIcone(
                                            snapshot.data.posts[index].likeada),
                                      ),
                                    ],
                                  ),
                                ),
                                exibeLikes(snapshot.data.posts[index].likers),
                                exibeLegenda(snapshot.data.posts[index]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ));
            } else if (snapshot.hasError) {
              return Container(
                margin: EdgeInsets.all(100),
                child: Text('${snapshot.error}'),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
