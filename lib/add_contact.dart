import 'package:flutter/material.dart';
import 'package:sqflite_database/contact.dart';
import 'package:sqflite_database/db_helper.dart';
import 'package:sqflite_database/home_screen.dart';

class AddContact extends StatefulWidget {
  AddContact({
    Key? key,
    this.contact,
  }) : super(key: key);

  Contact? contact;
  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name!;
      _numberController.text = widget.contact!.number!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildTextField(_nameController, "Name"),
            SizedBox(
              height: 10.0,
            ),
            _buildTextField(_numberController, "Phone Number"),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  await DBHelper.createContact(
                    Contact(
                      name: _nameController.text,
                      number: _numberController.text,
                    ),
                  );
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
  }
}
