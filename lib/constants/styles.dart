import 'package:flutter/material.dart';
import 'package:HebronEats/constants/colors.dart';

const kMainHeading = TextStyle(fontSize: 22, fontWeight: FontWeight.w800);
const kMainInfo =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey);

const kSubHeading1 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kSubHeading2 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: subText,
);

const kSubHeading3 = TextStyle(
  color: subText,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

const kTinyText = TextStyle(
  color: kSecondaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const kOverTagText1 = TextStyle(
  color: kBackground,
  fontSize: 12,
);

const kHintStyle =
    TextStyle(fontSize: 14, color: subText, fontStyle: FontStyle.italic);

InkWell blackButton(text, fontSize, pressed,
    {margin, width, alignment, padding}) {
  return InkWell(
    onTap: pressed,
    child: Container(
      alignment: alignment,
      height: 55,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.4,
            blurRadius: 0,
            color: Colors.black38.withOpacity(0.2),
          ),
        ],
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: kBackground,
                fontWeight: FontWeight.w500,
                fontSize: fontSize)),
      ),
    ),
  );
}

Container textBox(child, {width}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    width: width,
    decoration: BoxDecoration(
      color: kDarkWhite,
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}

GestureDetector circleIcon(icon, pressed) {
  return GestureDetector(
    onTap: pressed,
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
      child: Center(child: icon),
    ),
  );
}

Row kNaira(int amount, style) {
  return Row(
    children: [
      const ImageIcon(
        AssetImage(
          'assets/icons/naira.png',
        ),
        size: 18,
      ),
      const SizedBox(
        width: 1.5,
      ),
      Text(
        commaNotation(amount),
        style: style,
      ),
    ],
  );
}

commaNotation(int amount) {
  String stringAmount = amount.toString();
  if (stringAmount.toString().length == 6) {
    String thousand =
        '${stringAmount[0]}${stringAmount[1]}${stringAmount[2]},${stringAmount[3]}${stringAmount[4]}';
    String thousand3 = thousand.padRight(7, '0');
    return thousand3;
  } else if (stringAmount.length == 5) {
    String thousand =
        '${stringAmount[0]}${stringAmount[1]},${stringAmount[2]}${stringAmount[3]}';
    String thousand2 = thousand.padRight(6, '0');
    return thousand2;
  } else if (stringAmount.toString().length == 4) {
    String thousand = '${stringAmount[0]},${stringAmount[1]}';
    String thousand1 = thousand.padRight(5, '0');
    return thousand1;
  } else {
    return amount.toString();
  }
}

Container overTag1(text) {
  return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 20,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0x80000000),
      ),
      child: Center(child: text));
}
