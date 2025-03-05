import 'package:HebronEats/models/vendor.dart';
import 'package:HebronEats/screens/vendor_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:HebronEats/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:HebronEats/constants/colors.dart';

import '../models/category.dart';
import '../widgets/menu_category.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomePage(),
        settings: const RouteSettings(name: routeName));
  }

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _vendorsStream = FirebaseFirestore.instance
      .collection('vendors')
      .orderBy('name', descending: true);

  var sortValue;

  // final CollectionReference _category =
  //     FirebaseFirestore.instance.collection('Categories');

  // final vendorsList = Vendor.generateVendor();
  List categoryList = Category.generateCategory();
  // final foodList = Food.generateFood();

  String category = '';
  List catName = [
    'Fast Food',
    'Drinks',
    'Soup',
    'Rice and Pasta',
    'Fruits and Veggies',
    'Combos',
    'Snacks',
    'Dessert',
    'Favourites'
  ];

  var currentSelectionIndex;
  bool favSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                        text: 'Hebron',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Eats',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                    blurRadius: 0.5,
                                    spreadRadius: 2,
                                    color: kDarkWhite,
                                  )
                                ]),
                          )
                        ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/basket');
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFDCDCDC),
                            spreadRadius: 4,
                            blurRadius: 70,
                          ),
                        ],
                      ),
                      child: const Icon(
                        FontAwesomeIcons.basketShopping,
                        color: kSecondaryColor,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              // controller: widget._controller,
              onSubmitted: (String value) {
                sortValue = value;
              },
              decoration: InputDecoration(
                hintStyle: kSubHeading2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                prefixIcon: const ImageIcon(
                  AssetImage('assets/icons/search.png'),
                  size: 30,
                  color: Colors.black45,
                ),
                filled: true,
                fillColor: kDarkWhite,
                hintText: 'Search',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12,
                children: List.generate(
                    categoryList.length,
                    (index) => BuildMenuCategory(
                          index: index,
                          isSelected: currentSelectionIndex == index,
                          deSelect: () {
                            setState(
                              () {
                                currentSelectionIndex = null;
                                category = '';
                              },
                            );
                          },
                          onSelect: () {
                            setState(() {
                              currentSelectionIndex = index;
                              category = catName[index];
                              sortValue = catName[index];
                            });
                          },
                          category: categoryList[index],
                        )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Vendors',
                  textAlign: TextAlign.start,
                  style: kMainHeading,
                ),
                FittedBox(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    decoration: BoxDecoration(
                        color: category != ''
                            ? kPrimaryColor.withOpacity(0.6)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Text(
                        category,
                        textAlign: TextAlign.start,
                        style: kTinyText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: currentSelectionIndex != null
                    ? _vendorsStream
                        .where("category", isEqualTo: sortValue)
                        .snapshots()
                    : _vendorsStream.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.hasError) {
                    return Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text(
                            'Coming Soon',
                            style: kMainInfo,
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }
                  // final vendors = snapshot.data!.docs
                  //     .map((doc) => Vendor.fromDocumentSnapshot(
                  //         doc as DocumentSnapshot<Map<String, dynamic>>))
                  //     .toList();

                  return Expanded(
                      child: GridView.builder(
                    cacheExtent: 10.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0.0),
                    itemCount: snapshot.data?.docs.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 25,
                            childAspectRatio: 0.6,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];

                      String url = snapshot.data?.docs[index]['image'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      VendorScreen(documentSnapshot.id)));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: url,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider,
                                          scale: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black38.withOpacity(0.3),
                                            spreadRadius: 0.45,
                                            blurRadius: 0.6,
                                          ),
                                        ]),
                                  ),
                                  placeholder: (context, url) => const SizedBox(
                                    height: 220,
                                    width: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: overTag1(
                                    FittedBox(
                                      child: Text(
                                        documentSnapshot['category'].toString(),
                                        style: kOverTagText1,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          favSelect = !favSelect;
                                        });
                                      },
                                      isSelected: favSelect,
                                      icon: favSelect
                                          ? Icon(Icons.favorite_border_rounded)
                                          : Icon(
                                              Icons.favorite_rounded,
                                              color: Colors.red,
                                            ),
                                      padding: EdgeInsets.all(0),
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: [
                                Text(
                                  documentSnapshot['name'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  documentSnapshot['location'].toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: subText),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
