import 'package:flutter/material.dart';
import '../Models/MagicCard.dart';

class CardItem extends StatelessWidget {
  CardItem({Key? key, this.cart}) : super (key: key);

  MagicCard? cart;

  LinearGradient cardcolor() {
    List<Color> colors = [];
    for (var color in cart!.colors!) {
      switch(color) {
        case 'Red':
          colors.add(Colors.red);
          break;
        case 'Blue':
          colors.add(Colors.blue);
          break;
        case 'Green':
          colors.add(Colors.green);
          break;
        case 'Black':
          colors.add(Colors.black);
          break;
        case 'White':
          colors.add(Colors.yellow[100]!);
          break;
      }
    }
    if(colors.length == 1) {
      colors.add(colors[0]);
    }
    if(colors.isEmpty) {
      colors.add(Colors.grey);
      colors.add(Colors.grey);
    }
    return LinearGradient(
      colors: colors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: cardcolor(),
        borderRadius: BorderRadius.circular(10)
      ),
      child: ClipRect(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/card',
                    arguments: {
                      'multiverseid': cart!.multiverseid,
                      'name': cart!.name
                    });
                },
                icon: FadeInImage(
                  placeholder: const AssetImage('assets/images/spinner.gif'),
                  image: NetworkImage(cart!.imageUrl ?? ''),
                  imageErrorBuilder:
                    (context, error, stackTrace) {
                      return Image.asset('assets/images/shruggie.jpg', fit: BoxFit.fitWidth);
                  },
                  fadeInDuration: const Duration(milliseconds: 1000),
                ),
                iconSize: 200,
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(100),
                ),
                child: Text(
                  cart!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}