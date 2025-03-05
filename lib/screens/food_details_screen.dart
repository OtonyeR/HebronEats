import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';
import '../models/food.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/order_preview.dart';

class FoodDetailScreen extends StatefulWidget {
  static const String routeName = '/food-details';
  final Food food;

  // static Route route() {
  //   return MaterialPageRoute(
  //     builder: (_) => FoodDetailScreen(),
  //     settings: RouteSettings(name: routeName),
  //   );
  // }

  const FoodDetailScreen(this.food, {Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int total = 0;
  final myController = TextEditingController();

  SnackBar noFood = const SnackBar(
    backgroundColor: kSecondaryColor,
    duration: Duration(seconds: 1),
    content: Text('You haven\'t made any selection'),
  );

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackground,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                widget.food.imgUrl,
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: 360,
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 20.0,
                  ),
                  child: CustomAppBar(
                    leftIcon: Icons.arrow_back_ios_rounded,
                    leftCallBack: () {
                      Navigator.of(context).pop();
                    },
                    rightIcon: Icons.share_outlined,
                    rightCallBack: () {},
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 300),
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: const Divider(
                  endIndent: 175,
                  indent: 175,
                  thickness: 3.5,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food.name,
                          style: kMainHeading,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.food.category,
                          style: kSubHeading2,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: kDarkWhite,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.food.quantity != 0) {
                                widget.food.quantity--;
                              }
                              total = widget.food.price * widget.food.quantity;
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                                color: kBackground,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          widget.food.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.food.quantity++;
                              total = widget.food.price * widget.food.quantity;
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                                color: kBackground,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Details',
                                style: kSubHeading1,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.food.desc,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Types',
                            style: kSubHeading1,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 35),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.food.types.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 0),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: .8),
                                    color: kDarkWhite,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                      child: Text(
                                    widget.food.types[index],
                                    style:
                                        const TextStyle(color: kSecondaryColor),
                                  )),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Sides',
                            style: kSubHeading1,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 35),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.food.sides.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 0),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.6),
                                    //  border: Border.all(width: .8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                      child: Text(
                                    widget.food.sides[index],
                                    style:
                                        const TextStyle(color: kSecondaryColor),
                                  )),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Order Note',
                            style: kSubHeading1,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: myController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            fillColor: kDarkWhite,
                            hintText:
                                'Include additional notes \nabout your order',
                            hintStyle: kHintStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 14, top: 4),
                height: 85,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kDarkWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: subText,
                              ),
                            ),
                            kNaira(
                              (total),
                              const TextStyle(
                                fontSize: 24,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                      blackButton(
                        'Add To Bag',
                        17.0,
                        () {
                          if (total != 0) {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: kBackground.withOpacity(0.1),
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: OrderPreview(myController.text,
                                            total, widget.food),
                                      ),
                                    );
                                  });
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(noFood);
                          }
                        },
                        width: 160.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
