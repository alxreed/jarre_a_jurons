class Invitation {
  String userUid;
  String name;
  String userPhoto;
  bool accepted;

  Invitation(dynamic map) {
    userUid = map["userUid"];
    name = map["name"];
    userPhoto = map["userPhoto"];
    accepted = map["accepted"];

  }

  void turnOff() {
    this.accepted = true;
  }

}