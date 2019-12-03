import React from 'react';
import { StyleSheet, Platform, Image, Text, View, ScrollView } from 'react-native';

import firebase from 'react-native-firebase';
import TodoApp from './src/Todos';

export default class App extends React.Component {
  constructor() {
    super();
    this.state = {};
  }
  render() {
    return (
      <TodoApp/>
    );
  }
}
