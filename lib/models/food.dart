class Food {
  String imgUrl;
  String name;
  String category;
  String desc;
  String vendorName;
  int price;
  int quantity;
  List<String> sides;
  List<String> types;
  bool favStat;

  Food({
    required this.imgUrl,
    required this.name,
    required this.category,
    required this.desc,
    required this.vendorName,
    required this.price,
    required this.quantity,
    required this.sides,
    required this.types,
    required this.favStat,
  });

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'name': name,
      'category': category,
      'desc': desc,
      'vendorName': vendorName,
      'price': price,
      'quantity': quantity,
      'sides': sides,
      'types': types,
      'favStat': favStat,
    };
  }

  Food.fromMap(Map<String, dynamic> foodMap)
      : imgUrl = foodMap['imgUrl'],
        name = foodMap['name'],
        category = foodMap['category'],
        desc = foodMap['desc'],
        vendorName = foodMap['vendorName'],
        price = foodMap['price'],
        quantity = foodMap['quantity'],
        sides = List<String>.from(foodMap['sides']),
        types = List<String>.from(foodMap['types']),
        favStat = foodMap['favStat'];
}
