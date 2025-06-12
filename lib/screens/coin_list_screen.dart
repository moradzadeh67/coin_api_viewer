import 'package:api/data/constant/constants.dart';
import 'package:api/data/model/crypto.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '  قیمت آنلاین ارزهای دیجیتال',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'morbaee',
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black45,
        ),
        backgroundColor: blackColor,
        body: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                cryptoList![index].name,
                style: const TextStyle(
                  color: Colors.green,

                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                cryptoList![index].symbol,
                style: const TextStyle(color: greyColor),
              ),
              leading: SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    cryptoList![index].rank,
                    style: const TextStyle(color: greyColor, fontSize: 15),
                  ),
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          double.parse(
                            cryptoList![index].priceUsd,
                          ).toStringAsFixed(2),
                          style: TextStyle(color: greyColor, fontSize: 15),
                        ),
                        Text(
                          double.parse(cryptoList![index].changePercent24Hr)
                              .toStringAsFixed(2)
                              .replaceFirstMapped(
                                RegExp(r'^[^-]'),
                                (m) => '+${m[0]}',
                              ),
                          style: TextStyle(
                            color: _getColor(
                              cryptoList![index].changePercent24Hr,
                            ),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: _getIconChangePercent(
                          cryptoList![index].changePercent24Hr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _getIconChangePercent(String changePercent) {
  if (changePercent.contains('-')) {
    return Icon(Icons.trending_down, color: redColor);
  } else {
    return Icon(Icons.trending_up, color: greenColor);
  }
}

Color _getColor(String changePercent) {
  if (changePercent.contains('-')) {
    return redColor;
  } else {
    return greenColor;
  }
}
