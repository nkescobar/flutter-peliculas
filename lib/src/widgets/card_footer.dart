import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class CardFooterWidget extends StatelessWidget {
  final List<Pelicula> peliculas;

  const CardFooterWidget({
    Key key,
    @required this.peliculas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/images/not-found.png'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.fill,
              height: 160.0,
            )
          ],
        ),
      );
    }).toList());
  }
}
