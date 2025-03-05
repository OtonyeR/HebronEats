import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
//import 'package:hebron_eats/constants/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.leftIcon,
      required this.leftCallBack,
      this.rightIcon,
//    this.centerText,
      this.rightCallBack})
      : super(key: key);

//final dynamic centerText;
  final dynamic rightIcon;
  final IconData leftIcon;
  final dynamic rightCallBack;
  final dynamic leftCallBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallBack,
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: const [
                  BoxShadow(
                    color: kDarkWhite,
                    spreadRadius: 4,
                    blurRadius: 70,
                  ),
                ],
              ),
              child: Center(child: Icon(leftIcon)),
            ),
          ),
          /*centerText != null
              ? Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: true,
                  child: Center(child: Text(centerText, style: kMainHeading)),
                )
              : Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: false,
                  child: Center(child: Text(centerText)),
                ),*/
          rightIcon != null
              ? GestureDetector(
                  onTap: rightCallBack,
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: kDarkWhite,
                          spreadRadius: 4,
                          blurRadius: 70,
                        ),
                      ],
                    ),
                    child: Center(child: Icon(rightIcon)),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
