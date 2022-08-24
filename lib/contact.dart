class Contact{
  int? id;
  String? name;
  String? number;

  Contact({this.id, required this.name, required this.number});

  factory Contact.fromJson(Map<String, dynamic>json) => Contact(
  id:  json["id"],
  name: json["name"], 
  number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'number' : number,
  };

}