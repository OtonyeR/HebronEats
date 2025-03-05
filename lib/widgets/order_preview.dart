import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/basket_screen.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../models/food.dart';

class OrderPreview extends StatefulWidget {
  const OrderPreview(this.text, this.total, this.food, {Key? key})
      : super(key: key);

  final Food food;
  final String text;
  final int total;

  @override
  State<OrderPreview> createState() => _OrderPreviewState();
}

class _OrderPreviewState extends State<OrderPreview> {
  final _firestore = FirebaseFirestore.instance;
  String orderNote = '';
  int price = 0;
  //List orderItems = Cart.generateCart();
  Map<String, dynamic> orderItems = {};

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final User user = FirebaseAuth.instance.currentUser!;

  Map saveItem() {
    orderNote = widget.text;
    price = widget.total;
    orderItems.addAll({
      'name': widget.food.name,
      'image': widget.food.imgUrl,
      'price': price,
      'vendor': widget.food.vendorName,
      'quantity': widget.food.quantity,
      'note': orderNote,
      'category': widget.food.category,
    });
    return orderItems;
  }

  void addToCart() {
    saveItem();
    final itemDoc = _firestore.collection('Cart').doc(user.uid);
    final userDocRef = _firestore.collection('Cart').doc(user.uid).get();
    userDocRef.then((doc) async {
      if (doc.exists) {
        itemDoc.update({
          'Order': FieldValue.arrayUnion([saveItem()])
        });
      } else {
        itemDoc.set({'Order': saveItem()});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.655,
        decoration: const BoxDecoration(
          color: kBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 0.4,
              spreadRadius: 0.4,
              color: kDarkWhite,
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 35.0, horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Center(
                        child: Text(
                          'Confirm Addition',
                          style: kMainHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "You're adding ${widget.food.quantity} ${widget.food.name}(s) from ${widget.food.vendorName} to your cart",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Text(
                        'Your Note',
                        textAlign: TextAlign.start,
                        style: kSubHeading2,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textBox(
                        Text(widget.text),
                        width: MediaQuery.of(context).size.width - 80,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Sides',
                        textAlign: TextAlign.start,
                        style: kSubHeading2,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textBox(
                        Text(
                          widget.food.sides[0],
                        ),
                        width: MediaQuery.of(context).size.width - 80,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Types',
                        textAlign: TextAlign.start,
                        style: kSubHeading2,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.only(bottom: 25),
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          color: kDarkWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(widget.food.types[0]),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          color: kDarkWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Price:',
                                    style: kMainHeading,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  kNaira(widget.total, kMainHeading),
                                ]),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Quantity:',
                                  style: kMainHeading,
                                ),
                                Text(
                                  widget.food.quantity.toString(),
                                  style: kMainHeading,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: blackButton(
                'Confirm',
                18.0,
                () async {
                  addToCart();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const BasketScreen(),
                      ));
                },
                margin: const EdgeInsets.only(
                  top: 4,
                  left: 25,
                  right: 25,
                  bottom: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
