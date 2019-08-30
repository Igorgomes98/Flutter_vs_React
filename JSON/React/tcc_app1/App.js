import React, { Component } from "react";
import {
  StyleSheet,
  Text,
  View,
  Image,
  Dimensions,
  FlatList
} from "react-native";

import Post from './src/components/Post.js'

export default class Tcc_App extends Component {
  constructor() {
    super();
    this.state = {
      fotos: []
    }
  }

  componentDidMount() {
    fetch('https://instalura-api.herokuapp.com/api/public/fotos/rafael')
      .then(resposta => resposta.json())
      .then(json => this.setState({ fotos: json }))
      .catch(e => {
        console.warn('Não foi possivel carregar as fotos: ' + e);
        this.setState({ status: 'ERRO' })
      });
  }

  render() {
    return (
      <FlatList
        style={styles.container}
        data={this.state.fotos}
        keyExtractor={item => item.id}
        renderItem={({ item }) => (
          <Post foto={item} />
        )}
      />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    marginTop: 20
  },
});
