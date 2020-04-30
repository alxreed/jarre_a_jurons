class Friend {
  String uid;
  String name;
  String photoUrl;
  int moneyEarned;
  int moneyEarnedBy;

  Friend(dynamic map) {
    uid = map["uid"];
    name = map["name"];
    photoUrl = map["photoUrl"];
    moneyEarned = map["moneyEarned"];
    moneyEarnedBy = map["moneyEarnedBy"];

  }

}
