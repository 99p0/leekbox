import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final CreditCardViewModel data;

  const CreditCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.only(left: 20, top: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: data.cardColors,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: Color.fromARGB(20, 0, 0, 0),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: -100,
            bottom: -100,
            child: Image.asset(
              data.bankLogoUrl,
              width: 250,
              height: 250,
              color: Colors.white10,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        data.bankLogoUrl,
                        width: 36,
                        height: 36,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.bankName,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          data.cardType,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(200, 255, 255, 255),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 65, top: 20),
                  child: Text(
                    this.data.cardNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Farrington',
                      letterSpacing: 3,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 65, top: 15),
                  child: Text(
                    data.validDate,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardViewModel {
  /// 银行
  final String bankName;

  /// 银行Logo
  final String bankLogoUrl;

  /// 卡类型
  final String cardType;

  /// 卡号
  final String cardNumber;

  /// 卡片颜色
  final List<Color> cardColors;

  /// 有效期
  final String validDate;

  const CreditCardViewModel({
    required this.bankName,
    required this.bankLogoUrl,
    required this.cardType,
    required this.cardNumber,
    required this.cardColors,
    required this.validDate,
  });
}
