import 'package:flutter/material.dart';
import 'package:sqflite_database/add_contact.dart';
import 'package:sqflite_database/contact.dart';
import 'package:sqflite_database/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQF Lite DB")),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder<List<Contact>>(
          future: DBHelper.readContact(),
          // builder: (context, sn) {

          // },
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Loading.....")
                ],
              ));
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text("No Data Found"),
                  )
                : ListView(
                    children: snapshot.data!.map((contacts) {
                      return Center(
                        child: Card(
                          elevation: 5,
                          color: Colors.green[300],
                          child: ListTile(
                            title: Text("${contacts.name}"),
                            subtitle: Text("${contacts.number}"),
                          ),
                        ),
                      );
                    }).toList(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final refress = await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddContact()));
          if (refress) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
