import 'package:desafio_toro/constants/colors_constants.dart';
import 'package:desafio_toro/services/stock_provider.dart';
import 'package:desafio_toro/services/user_provider.dart';
import 'package:desafio_toro/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  var money = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$ ');

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: SvgPicture.asset('assets/images/logo_toro.svg'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        currentIndex: userProvider.selectedSortMethod,
        fixedColor: Color.fromRGBO(52, 173, 209, 1),
        onTap: (int index) {
          userProvider.setSortMethod(index);
          stockProvider.sortList(index);
          _scrollController.animateTo(1, duration: Duration(seconds: 1), curve: Curves.ease);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), title: Text('Em Alta')),
          BottomNavigationBarItem(icon: Icon(Icons.trending_down), title: Text('Em Baixa')),
          BottomNavigationBarItem(icon: Icon(Icons.sort_by_alpha), title: Text('Por Nome')),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8),
              physics: ScrollPhysics(),
              itemCount: stockProvider.stocksList.length,
              itemBuilder: (BuildContext context, int index) {
                money.updateValue(stockProvider.stocksList[index].currentValue);

                return Card(
                  elevation: 5,
                  child: Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              stockProvider.stocksList[index].name,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: chartCard(stockProvider.stocksList[index].quotes),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  money.text,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
                                ),
                                Card(
                                  elevation: 0,
                                  color: Colors.white.withOpacity(0.1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: Text(
                                      '${(stockProvider.stocksList[index].growthPercentage * 100).toStringAsFixed(2)}%',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: stockProvider.stocksList[index].growthPercentage > 0 ? kColorsPositiveRate : kColorsNegativeRate,
                                      ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
