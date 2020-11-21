class User {
  String uid;
  String nombre;
  int karma;

  User(Map json)
      : uid = json["uid"],
        nombre = json["nombre"],
        karma = json["karma"];
}
