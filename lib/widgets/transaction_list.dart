import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransActionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransActionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
                children: [
                  Text(
                    'No transactions Added Yet !',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  Container(
                      height: constrains.maxHeight*.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '\$ ${transactions[index].price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22),
                  ),
                  subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => deleteTx(transactions[index].id)),
                  onTap: () {
                    print('tap');
                  },
                ),
              );
              // return Card(
              //   borderOnForeground: true,
              //   elevation: 10,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0)),
              //   margin: EdgeInsets.all(5),
              //   child: Row(
              //     children: [
              //       Container(
              //         child: Text(
              //           '\$ ${transactions[index].price.toStringAsFixed(2)}',
              //           style:
              //               TextStyle(color: Theme.of(context).primaryColor),
              //         ),
              //         decoration: BoxDecoration(
              //             border: Border.all(
              //                 color: Theme.of(context).primaryColor,
              //                 width: 2,
              //                 style: BorderStyle.solid)),
              //         margin: EdgeInsets.all(10),
              //         padding: EdgeInsets.all(10),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title,
              //             style: Theme.of(context).textTheme.title,
              //           ),
              //           Text(
              //             DateFormat('d/M/y')
              //                 .format(transactions[index].date),
              //             style: TextStyle(color: Colors.grey),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: transactions.length,
          );
  }
}
