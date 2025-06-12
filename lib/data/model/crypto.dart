class Crypto {
  final String id;
  final String rank;
  final String name;
  final String maxSupply;
  final String volumeUsd24Hr;
  final String priceUsd;
  final String changePercent24Hr;

  Crypto(
    this.id,
    this.rank,
    this.name,
    this.maxSupply,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.changePercent24Hr,
  );

  factory Crypto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      jsonMapObject['id']?.toString() ?? '',
      jsonMapObject['rank']?.toString() ?? '',
      jsonMapObject['name']?.toString() ?? '',
      jsonMapObject['maxSupply']?.toString() ?? '',
      jsonMapObject['volumeUsd24Hr']?.toString() ?? '',
      jsonMapObject['priceUsd']?.toString() ?? '',
      jsonMapObject['changePercent24Hr']?.toString() ?? '',
    );
  }
}
