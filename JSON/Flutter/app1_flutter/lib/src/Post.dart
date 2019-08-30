class Likers {
  String login;

  Likers({this.login});

  factory Likers.fromJson(Map<String, dynamic> json) {
    return Likers(login: json['login']);
  }
}

class Comentarios {
  String login;
  String texto;
  int id;

  Comentarios({this.login, this.texto, this.id});

  factory Comentarios.fromJson(Map<String, dynamic> json) {
    return Comentarios(
        login: json['login'], texto: json['texto'], id: json['id']);
  }

  // Map<String, dynamic> toJson() {
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['login'] = this.login;
  // data['texto'] = this.texto;
  // data['id'] = this.id;
  // return data;
  // }
}

class PostList {
  List<Post> posts;

  PostList({this.posts});

  factory PostList.fromJson(List<dynamic> json) {
    List<Post> posts = new List<Post>();
    posts = json.map((i) => Post.fromJson(i)).toList();

    return new PostList(posts: posts);
  }
}

class Post {
  String urlPerfil;
  String loginUsuario;
  String horario;
  String urlFoto;
  int id;
  bool likeada;
  List<Likers> likers;
  List<Comentarios> comentarios;
  String comentario;

  Post({
    this.urlPerfil,
    this.loginUsuario,
    this.horario,
    this.urlFoto,
    this.id,
    this.likeada,
    this.likers,
    this.comentarios,
    this.comentario,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var listLikers = json['likers'] as List;
    print(listLikers.runtimeType);
    List<Likers> likers = listLikers.map((i) => Likers.fromJson(i)).toList();

    var listComment = json['comentarios'] as List;
    print(listComment.runtimeType);
    List<Comentarios> comentarios =
        listComment.map((i) => Comentarios.fromJson(i)).toList();

    return new Post(
        urlPerfil: json['urlPerfil'],
        loginUsuario: json['loginUsuario'],
        horario: json['horario'],
        urlFoto: json['urlFoto'],
        id: json['id'],
        likeada: json['likeada'],
        likers: likers,
        comentarios: comentarios,
        comentario: json['comentario']);
  }

//  Map<String, dynamic> toJson() {
  //  final Map<String, dynamic> data = new Map<String, dynamic>();
  //data['urlPerfil'] = this.urlPerfil;
  //data['loginUsuario'] = this.loginUsuario;
  //data['horario'] = this.horario;
  //data['urlFoto'] = this.urlFoto;
  //data['id'] = this.id;
  //dat/a['likeada'] = this.likeada;
  //if (this.likers != null) {
  //  data['likers'] = this.likers.map((v) => v.toJson()).toList();
  // }
  // if (this.comentarios != null) {
  //   data['comentarios'] = this.comentarios.map((v) => v.toJson()).toList();
  // }
  // data['comentario'] = this.comentario;
  // return data;
  // }
}
