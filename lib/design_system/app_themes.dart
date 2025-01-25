import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';

class AppTheme {
  static const TextStyle loginHead = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle loginBtn = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle logintextFormLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryColor,
  );
  static const TextStyle logintextFormtext = TextStyle(
    fontSize: 18,
    color: Color.fromRGBO(189, 189, 189, 1),
    height: 1,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle logintextFormHint = TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(189, 189, 189, 1),
    height: 1,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle loadText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
  static const TextStyle headText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle orderItemId = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle orderItemPending = TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(189, 189, 189, 1),
    fontWeight: FontWeight.w900,
  );
  static const TextStyle orderItemChange = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.blue,
    height: 1,
    decoration: TextDecoration.underline,
    fontSize: 14,
  );
  static const TextStyle orderItemtitle = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle orderItemsubtitle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Color.fromRGBO(189, 189, 189, 1),
    fontSize: 13,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle orderItemsInvoice = TextStyle(
    height: 1,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Colors.black,
  );
  static const TextStyle orderItemsViewDoc = TextStyle(
    fontWeight: FontWeight.w800,
    height: 1,
    color: Color.fromRGBO(189, 189, 189, 1),
    fontSize: 14,
  );
  static const TextStyle floatBtnHead = TextStyle(
    height: 1,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 14,
  );
  static const TextStyle sortHead = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle sortOpt = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(158, 158, 158, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle saveBtn = TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(255, 255, 255, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle cancelBtn = TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(189, 189, 189, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle clearBtn = TextStyle(
    fontSize: 14,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle filterHead =
      TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900);
  static const TextStyle orderStatusHead =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w900);
  static const TextStyle orderStatusTitle = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(158, 158, 158, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle customOrderStatusTitle = TextStyle(
      height: 1,
      fontSize: 16,
      color: Color.fromRGBO(158, 158, 158, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle paymentMethodHead =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w900);
  static const TextStyle paymentMethodTitle = TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(158, 158, 158, 1),
      fontWeight: FontWeight.w600);
  static const TextStyle changeOrderStatusHead = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle changeOrderStatusSubHead = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle navigationBarTitle =
      TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);
  static const TextStyle orderStatusProgressHead = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle orderDetailsOrderStatusTitleopt1 = TextStyle(
    fontSize: 8.5,
    fontWeight: FontWeight.w500,
    color: Colors.green,
  );
  static const TextStyle orderDetailsOrderStatusTitleopt2 = TextStyle(
    fontSize: 8.5,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
  static const TextStyle orderDetialsAppbarTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle orderDetialsItemTitle = TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle orderDetialsItemSubTitle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(117, 117, 117, 1));
  static const TextStyle orderDetailsReciteHead = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle orderDetailsReciteSubTotal = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle orderDetailsReciteVat = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle orderDetailsReciteVatPrice = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle orderDetailsReciteTotal = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle orderDetailsReciteTotalPrice = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
  );
  static const TextStyle orderDetailsReciteSubTotalPrice = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle orderDetailsReciteCurrency = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle orderDetailsTaxRecite = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle orderDetailsTaxReciteViewDoc = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(117, 117, 117, 1),
  );
  static const TextStyle cardItem = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(255, 255, 255, 1),
  );
  static const TextStyle successText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w900,
    color: Colors.green,
  );
  static const TextStyle errorText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: Colors.red,
  );
}

// static ThemeData theme = ThemeData(
  //   primaryColor: AppColors.primaryColor,
  //   textTheme: const TextTheme(
  //     labelLarge: TextStyle(
  //         fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
  //     labelSmall:
  //         TextStyle(fontSize: 16, color: Color.fromRGBO(158, 158, 158, 1)),
  //     headlineLarge: TextStyle(
  //         fontSize: 28, color: Colors.black, fontWeight: FontWeight.w900),
  //     headlineMedium: TextStyle(
  //         fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
  //     displayLarge: TextStyle(
  //         fontSize: 24, color: Colors.black, fontWeight: FontWeight.w900),
  //     displayMedium: TextStyle(
  //         fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
  //     displaySmall: TextStyle(
  //         fontSize: 14, color: Colors.black, fontWeight: FontWeight.w200),
  //   ),
  // );