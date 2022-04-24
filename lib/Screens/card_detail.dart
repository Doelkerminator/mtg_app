
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtg_app/Network/api_cards.dart';

import '../Models/MagicCard.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key}) : super(key: key);

  static Widget oopsAnErrorHappened() {
    return Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('assets/images/error.png'),
            height: 200,
            width: 200,
          ),
          Text(
            'Error',
            style: TextStyle(
                fontFamily: 'Inlanders',
                color: Colors.white,
                fontSize: 80
            ),
          ),
          Text('Could not retrieve data', style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }

  Widget _showDetails(MagicCard? card) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInImage(
                placeholder: const AssetImage('assets/images/spinner.gif'),
                fadeInDuration: const Duration(seconds: 1),
                image: NetworkImage(card?.imageUrl ?? ''),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/spinner.gif');
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: DataTable(
                  columnSpacing: 25,
                  border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.white,
                      )
                  ),
                  columns: <DataColumn>[
                    const DataColumn(label: Text('Name:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(card?.name ?? '', style: const TextStyle(color: Colors.white)))
                  ],
                  rows: <DataRow> [
                    DataRow(
                        cells: <DataCell> [
                          const DataCell(Text('Mana Cost:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataCell(Text(card?.manaCost ?? '', style: const TextStyle(color: Colors.white),))
                        ]
                    ),
                    DataRow(
                        cells: <DataCell> [
                          const DataCell(Text('Type:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataCell(Text(card?.type ?? '', style: const TextStyle(color: Colors.white),))
                        ]
                    ),
                    DataRow(
                        cells: <DataCell> [
                          const DataCell(Text('Rarity:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataCell(Text(card?.rarity ?? '', style: const TextStyle(color: Colors.white),))
                        ]
                    ),
                    DataRow(
                        cells: <DataCell> [
                          const DataCell(Text('Text:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataCell(Text(card?.text ?? '', style: const TextStyle(color: Colors.white),))
                        ]
                    ),
                  ],
                ),
              )
            ]
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    String multiverseid = ((ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map)['multiverseid'];
    String name = ((ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map)['name'];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(name),
        elevation: 1,
        backgroundColor: Colors.orange[900],
      ),
      body: FutureBuilder(
        future: ApiCards.getCard(multiverseid),
        builder: (BuildContext context, AsyncSnapshot<MagicCard?> snapshot) {
          if(snapshot.hasError) {
            return oopsAnErrorHappened();
          }
          else {
            if(snapshot.connectionState == ConnectionState.done) {
              return _showDetails(snapshot.data);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      )
    );
  }
}