import React, { useState,useEffect  } from 'react';
import { FlatList, View, Text, } from 'react-native';
import { Appbar, TextInput, Button } from 'react-native-paper';
import Todo from './Todo'; 

import firebase from 'react-native-firebase';

function Todos() {
  const [ todo, setTodo ] = useState('');
  const [ loading, setLoading ] = useState(true);
  const [ todos, setTodos ] = useState([]);
  const ref = firebase.firestore().collection('todos');

  async function addTodo() {
    await ref.add({
      title: todo,
      completed: false,
    });
    setTodo('');
  }

  useEffect(() => {
    return ref.onSnapshot(querySnapshot => {
      const list = [];
      querySnapshot.forEach(doc => {
        const { title, completed } = doc.data();
        list.push({
          id: doc.id,
          title,
          completed,
        });
      });

      setTodos(list);

      if (loading) {
        setLoading(false);
      }
    });
  }, []);

  if (loading) {
    return null;
  }


  return (
    <>
      <Appbar>
        <Appbar.Content title={'React Firebase'} />
      </Appbar>
      <FlatList 
        style={{flex: 1}}
        data={todos}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => <Todo {...item} />}
      />
      <TextInput label={'New Todo'} value={todo} onChangeText={setTodo} />
      <Button onPress={() => addTodo()}>Add TODO</Button>
    </>
  );
}

export default Todos;