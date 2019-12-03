import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firestore = Firestore.instance.collection('todos');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _todo;

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    String titulo = document['title'];
    bool completed = document['completed'];
    return ListTile(
        leading: completed ? Icon(Icons.check) : Icon(Icons.block),
        title: Text(
          titulo,
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          setState(() {
            firestore
                .document(document.documentID)
                .setData({'completed': !completed, 'title': titulo});
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6200EE),
        title: Text('Flutter Firebase'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: StreamBuilder(
                  stream: firestore.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => buildItem(
                              context, snapshot.data.documents[index]));
                    }
                  }),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      color: Color(0xffE7E7E7),
                      child: TextFormField(
                        initialValue: '',
                        validator: (input){
                          if(input.isEmpty || input == ''){
                            return 'Digite o Todo';
                          }
                        },
                        onSaved: (input) => _todo = input,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xffE7E7E7),
                            hintText: 'New Todo'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: FlatButton(
                          child: Text('ADD TODO', style: TextStyle(color: Colors.deepPurple),),
                          onPressed: () {
                            if(_formKey.currentState.validate() == true){
                              _formKey.currentState.save();
                              firestore.add({'title': _todo, 'completed': false});
                              _formKey.currentState.reset();
                            }
                          } //=> subirTodo(),
                          ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
