import 'dart:io';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      theme: ThemeData(
          fontFamily: 'QuickSand',
          primarySwatch: Colors.teal,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )
          // accentColor: Colors.teal
          ),
      title: 'Flutter App',
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _appBar(){
    return Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    )
        : AppBar(
      title: Text(
        'Personal Expenses',
      ),

      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
          // color: Colors.white,
        )
      ],
    );
  }
  List<Transaction> transactions = [
    Transaction('t1', 'new shoes', DateTime.now(), 99.99),
    Transaction('t2', 'new pants', DateTime.now(), 59.99),
    Transaction('t3', 'new cap', DateTime.now(), 79.99)
  ];
  bool _showChart = false;

  List<Transaction> get recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addTransaction(String txTitle, double txPrice, DateTime dateTime) {
    final tx =
        Transaction(DateTime.now().toString(), txTitle, dateTime, txPrice);
    setState(() {
      transactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isOrinted =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final  PreferredSizeWidget appBar=Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    )
        : AppBar(
      title: Text(
        'Personal Expenses',
      ),

      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
          // color: Colors.white,
        )
      ],
    );
    final pageBody = SafeArea(child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isOrinted)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart',
                style: Theme.of(context).textTheme.title,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    })
              ],
            ),
          if (!isOrinted)
            Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
                  .2,
              child: Chart(recentTransaction),
            ),
          if (!isOrinted)
            Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                    .8,
                child: TransActionList(transactions, _deleteTransaction)),
          if (isOrinted)
            _showChart
                ? Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
                  .7,
              child: Chart(recentTransaction),
            )
                : Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                    .8,
                child: TransActionList(transactions, _deleteTransaction)),
        ],
      ),
    ),);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: _appBar(),
          )
        : Scaffold(
            backgroundColor: Colors.teal.shade50,
            appBar: _appBar(),
            // drawer: SafeArea(
            //   child: Drawer(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //
            //       children: [
            //
            //         Row(
            //           children: [
            //             CircleAvatar(),
            //             Card(child: Text('ahmed'),
            //             elevation: 5,
            //             ),
            //           ],
            //         ),
            //         Text('mohamed')
            //       ],
            //     ),
            //   ),
            // ),
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                    foregroundColor: Colors.white,
                  ),
          );
  }
}
