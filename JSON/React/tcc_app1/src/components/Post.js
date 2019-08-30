import React, { Component } from "react";
import {
  StyleSheet,
  Text,
  View,
  Image,
  Dimensions,
  TouchableOpacity
} from "react-native";

const width = Dimensions.get("screen").width;

export default class Post extends Component {

  constructor(props) {
    super(props);
    this.state = {
      foto: { ...this.props.foto, likers: [{}, {}] }
    }
  }

  carregaIcone(likeada) {
    return likeada ? require('../../assets/img/likeada.png') : require('../../assets/img/like.png')
  }

  exibeLikes(likers) {
    if (likers.length <= 0)
      return;
    return (
      <Text style={styles.likes}>
        {likers.length} {likers.length > 1 ? 'Likes' : 'Like'}
      </Text>
    );
  }

  exibeLegenda(foto) {
    if (foto.comentario === '')
      return;
    return (
      <View style={styles.comentario}>
        <Text style={styles.tituloComentario}>{foto.loginUsuario}</Text>
        <Text>{foto.comentario}</Text>
      </View>
    );
  }

  like() {
    const fotoAtualizada = {
      ...this.state.foto,
      likeada: !this.state.foto.likeada
    }
    this.setState({ foto: fotoAtualizada })
  }

  render() {

    const { foto } = this.state;

    return (
      <View>
        <View style={styles.cabecalho}>
          <Image
            source={{ uri: foto.urlPerfil }}
            style={styles.fotoDePerfil}
          />
          <Text>{foto.loginUsuario}</Text>
        </View>
        <Image
          source={{ uri: foto.urlFoto }}
          style={styles.foto} />
        <View style={styles.rodape}>
          <TouchableOpacity onPress={this.like.bind(this)}>
            <Image style={styles.botaoDeLike}
              source={this.carregaIcone(foto.likeada)} />
          </TouchableOpacity>

          {this.exibeLikes(foto.likers)}
          {this.exibeLegenda(foto)}
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  cabecalho: {
    margin: 10,
    flexDirection: "row",
    alignItems: "center"
  },
  fotoDePerfil: {
    marginRight: 10,
    borderRadius: 20,
    width: 40,
    height: 40
  },
  foto: {
    width: width,
    height: width
  },
  botaoDeLike: {
    marginBottom: 10,
    height: 40,
    width: 40
  },
  rodape: {
    margin: 10
  },
  likes: {
    fontWeight: "bold"
  },
  comentario: {
    flexDirection: 'row',
  },
  tituloComentario: {
    fontWeight: "bold",
    marginRight: 5
  },
});
