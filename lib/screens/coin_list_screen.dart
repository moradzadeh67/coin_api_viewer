import 'package:api/data/constant/constants.dart';
import 'package:api/data/model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  bool isSearchLoadingVisible = false;
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  onChanged: (value) {
                    _filterList(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'سرچ با نام ارز دیجیتال',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    filled: true,
                    fillColor: Colors.teal[300],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isSearchLoadingVisible,
              child: Text(
                '... در حال آپدیت اطلاعات',
                style: TextStyle(color: greenColor, fontSize: 20),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: greenColor,
                color: blackColor,
                child: ListView.builder(
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
                            style: const TextStyle(
                              color: greyColor,
                              fontSize: 15,
                            ),
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
                                  style: TextStyle(
                                    color: greyColor,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  double.parse(
                                        cryptoList![index].changePercent24Hr,
                                      )
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
                onRefresh: () async {
                  List<Crypto> freshData = await getData();
                  setState(() {
                    cryptoList = freshData;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _filterList(String enteredKeyword) async {
    List<Crypto> cryptoResultList = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearchLoadingVisible = true;
      });
      var result = await getData();
      setState(() {
        cryptoList = result;
        isSearchLoadingVisible = false;
      });
      return;
    }

    cryptoResultList = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();
    setState(() {
      cryptoList = cryptoResultList;
    });
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

Future<List<Crypto>> getData() async {
  var response = await Dio().get(
    'https://rest.coincap.io/v3/assets?apiKey=0add4468326e999de8747e8ad5ba36063f54004122bc39dc9c404020cf682c92',
  );
  List<Crypto> cryptoList = response.data['data']
      .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
      .toList();
  return cryptoList;
}
