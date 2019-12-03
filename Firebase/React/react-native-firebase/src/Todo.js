import React from 'react';
import firebase from 'react-native-firebase';
import { List } from 'react-native-paper';

function Todo({ id, title, completed }) {
  async function toggleCompleted() {
    await firebase.firestore()
      .collection('todos')
      .doc(id)
      .update({
        completed: !completed,
      });
  }

  return (
    <List.Item
      title={title}
      onPress={() => toggleCompleted()}
      left={props => (
        <List.Icon {...props} icon={completed ? 'check' : 'cancel'} />
      )}
    />
  );
}

export default React.memo(Todo);