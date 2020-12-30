import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class CardMovieHorizontal extends StatelessWidget {
  final Pelicula pelicula;
  const CardMovieHorizontal({Key key, @required this.pelicula})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Pelicula titulo ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/not-found.png'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.fill,
                height: 140.0,
              ),
            ),
            SizedBox(),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
