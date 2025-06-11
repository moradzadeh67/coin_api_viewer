class User {
  String id;
  String rank;
  String name;
  String maxSupply;
  String volumeUsd24Hr;
  String priceUsd;
  String changePercent24Hr;

  User(
    this.id,
    this.rank,
    this.name,
    this.maxSupply,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.changePercent24Hr,
  );

  factory User.fromJson(Map<String, dynamic> jsonObject) {
    return User(
      jsonObject['id'],
      jsonObject['rank'],
      jsonObject['name'],
      jsonObject['maxSupply'],
      jsonObject['volumeUsd24Hr'],
      jsonObject['priceUsd'],
      jsonObject['changePercent24Hr'],
    );
  }
}
