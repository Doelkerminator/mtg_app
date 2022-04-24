
import 'package:flutter/material.dart';
import 'package:mtg_app/Network/api_cards.dart';
import 'package:mtg_app/Views/card_item.dart';

import '../Models/MagicCard.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {

  String search = '';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _listCards(List<MagicCard>? cards) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x12FFFFFF),
                borderRadius: BorderRadius.circular(1.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                controller: _controller,
                onSubmitted: (String value) => searchedName(value),
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 16.0),
                    hintText: "Search by card's name...",
                    hintStyle: TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          Flexible(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: (1/1.5)
              ),
              itemBuilder: (BuildContext context, index) {
                MagicCard card = cards![index];
                return CardItem(cart: card);
              },
              itemCount: cards!.length,
            )
          )
        ],
      )
    );
  }

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

  void searchedName(String name) {
    setState(() {
      search = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('MTG Cards List'),
        elevation: 1,
        backgroundColor: Colors.orange[900],
      ),
      body: FutureBuilder(
        future: ApiCards.getAllCards(search),
        builder: (BuildContext context, AsyncSnapshot<List<MagicCard>?> snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);
            return oopsAnErrorHappened();
          }
          else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listCards(snapshot.data);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        }
      )
    );
  }
}