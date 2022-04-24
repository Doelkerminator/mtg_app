class MagicCard {
  String? multiverseid;
  String? name;
  String? manaCost;
  List<dynamic>? colors;
  String? type;
  String? rarity;
  String? text;
  String? imageUrl;

  MagicCard({
    this.multiverseid,
    this.name,
    this.manaCost,
    this.colors,
    this.type,
    this.rarity,
    this.text,
    this.imageUrl
  });

  factory MagicCard.fromMap(Map<String, dynamic> map) {
    return MagicCard(
      multiverseid: map['multiverseid'] ?? '',
      name: map['name'] ?? '',
      manaCost: map['manaCost'] ?? '',
      colors: map['colors'] ?? [],
      type: map['type'] ?? '',
      rarity: map['rarity'] ?? '',
      text: map['text'] ?? '',
      imageUrl: map['imageUrl'] ?? ''
    );
  }
}
