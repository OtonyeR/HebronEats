import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food.dart';
import '../models/vendor.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../widgets/custom_app_bar.dart';

class VendorScreen extends StatefulWidget {
  static const String routeName = '/vendor-details';
  final String vendorId;

  // static Route route() {
  //   return MaterialPageRoute(
  //     builder: (_) => VendorScreen(),
  //     settings: RouteSettings(name: routeName),
  //   );
  // }

  const VendorScreen(this.vendorId, {Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  late String vendorData;

  @override
  void initState() {
    super.initState();
    vendorData = widget.vendorId; // Access widget's property in initState
  }

  // final CollectionReference _menu = FirebaseFirestore.instance
  //     .collection('vendors')
  //     .doc(vendorData)
  //     .collection('Menu');
  final _vendors = FirebaseFirestore.instance.collection('vendors');
  // final foodList = Food.generateFood();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: _vendors.doc(vendorData).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Loading indicator while waiting for data
            }

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
            final vendorInfo = snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25.0,
                right: 25.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    leftIcon: Icons.arrow_back_ios_rounded,
                    leftCallBack: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vendorInfo['name'].toString(),
                            style: kMainHeading,
                          ),
                          Text(
                            vendorInfo['location'].toString(),
                            textAlign: TextAlign.start,
                            style: kSubHeading3,
                          ),
                        ],
                      ),
                      FittedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Text(
                              vendorInfo['category'].toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _vendors
                          .doc(vendorData)
                          .collection('Menu')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> menuSnapshot) {
                        if (menuSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Loading indicator while waiting for data
                        }

                        if (menuSnapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Display an error message
                        }

                        if (!menuSnapshot.hasData ||
                            menuSnapshot.data == null) {
                          return const Text(
                              'No data available'); // Display a message if no data is available
                        }

                        final foodItems =
                            menuSnapshot.data!.data as Map<String, dynamic>;

                        return Expanded(
                          child: GridView.builder(
                            itemCount: foodItems.length,
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.8,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot foodItem =
                                  foodItems[index];
                              return GestureDetector(
                                onTap: () {
                                  /* Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) => FoodDetailScreen(food)));*/
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 195,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      foodItem['image'] != null
                                                          ? Icon(
                                                              Icons.food_bank)
                                                          : foodItem['image']),
                                                  scale: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black38
                                                      .withOpacity(0.2),
                                                  spreadRadius: 0,
                                                  blurRadius: 0.6,
                                                ),
                                              ]),
                                        ),
                                        Positioned(
                                          top: 5,
                                          left: 5,
                                          child: overTag1(
                                            Text(
                                              foodItem['category'],
                                              style: kOverTagText1,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            child: Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 140),
                                              height: 55,
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(16),
                                                  bottomRight:
                                                      Radius.circular(16),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  top: 150,
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      foodItem['name'],
                                                      style: const TextStyle(
                                                          color: kBackground,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          shadows: [
                                                            BoxShadow(
                                                              blurRadius: .6,
                                                              spreadRadius: 0.4,
                                                              color: subText,
                                                            )
                                                          ]),
                                                    ),
                                                    Text(
                                                      foodItem['price'],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: kBackground,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
