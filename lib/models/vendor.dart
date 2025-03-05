import 'package:HebronEats/models/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  final String? id;
  String category;
  String vendorName;
  String location;
  String imgUrl;
  List<Food> vendorMenu;
  bool favStat;
  Vendor(
    this.id,
    this.vendorName,
    this.category,
    this.location,
    this.vendorMenu,
    this.imgUrl,
    this.favStat,
  );

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'vendorName': vendorName,
      'location': location,
      'imgUrl': imgUrl,
      'vendorMenu': vendorMenu,
      'favStat': favStat,
    };
  }

  // Named constructor to create a Vendor object from a Firestore DocumentSnapshot
  Vendor.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        category = doc.data()!["category"],
        vendorName = doc.data()!["vendorName"],
        location = doc.data()!["location"],
        imgUrl = doc.data()!["imgUrl"],
        vendorMenu = (doc.data()!["vendorMenu"] as List<dynamic>)
            .map((foodMap) => Food.fromMap(foodMap))
            .toList(),
        favStat = doc.data()!["favStat"];
}
