// import 'package:flutter/material.dart';
// import 'package:sqflite_database/add_contact.dart';
// import 'package:sqflite_database/contact.dart';
// import 'package:sqflite_database/db_helper.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("SQF Lite DataBase")),
//       body: Container(
//         padding: EdgeInsets.all(10.0),
//         child: FutureBuilder<List<Contact>>(
//           future: DBHelper.readContact(),
//           // builder: (context, sn) {

//           // },
//           builder:
//               (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text("Loading.....")
//                 ],
//               ));
//             }
//             return snapshot.data!.isEmpty
//                 ? Center(
//                     child: Text("No Data Found"),
//                   )
//                 : ListView(
//                     children: snapshot.data!.map((contacts) {
//                       return Center(
//                         child: Card(
//                           elevation: 5,
//                           color: Colors.green[300],
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               child: Text("${contacts.name![0]}"),
//                             ),
//                             title: Text("${contacts.name}"),
//                             subtitle: Text("${contacts.number}"),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final refress = await Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (context) => AddContact()));
//           if (refress) {
//             setState(() {});
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

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
      appBar: AppBar(
        title: Text('Flutter SQLite'),
        centerTitle: true,
      ),
      //add Future Builder to get contacts
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContact(), //read contacts list here
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          //if snapshot has no data yet
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          //if snapshot return empty [], show text
          //else show contact list
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Contact in List yet!'),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: ListTile(
                        title: Text("${contacts.name}"),
                        subtitle: Text("${contacts.number}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.deleteContacts(contacts.id!);
                            setState(() {
                              //rebuild widget after delete
                            });
                          },
                        ),
                        onTap: () async {
                          //tap on ListTile, for update
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddContact(
                                        contact: Contact(
                                          id: contacts.id,
                                          name: contacts.name,
                                          number: contacts.number,
                                        ),
                                      )));

                          if (refresh) {
                            setState(() {
                              //if return true, rebuild whole widget
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContact()));

          if (refresh) {
            setState(() {
              //if return true, rebuild whole widget
            });
          }
        },
      ),
    );
  }
}

