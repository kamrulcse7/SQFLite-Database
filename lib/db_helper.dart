import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_database/contact.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql = '''
    CREATE TABLE contacts(id INTEGER PRIMARY KEY, name  TEXT, number TEXT)
    ''';
    db.execute(sql);
  }

  static Future<int> createContact(Contact contact) async {
    Database db = await DBHelper.initDB();
    return await db.insert('contacts', contact.toJson());
  }

  static Future<List<Contact>> readContact() async {
    Database db = await DBHelper.initDB();
    var contact = await db.query('contacts', orderBy: 'name');

    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((details) => Contact.fromJson(details)).toList()
        : [];
    return contactList;
  }

  //build update function
  static Future<int> updateContacts(Contact contact) async {
    Database db = await DBHelper.initDB();
    //update the existing contact
    //according to its id
    return await db.update('contacts', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  //build delete function
  static Future<int> deleteContacts(int id) async {
    Database db = await DBHelper.initDB();
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
