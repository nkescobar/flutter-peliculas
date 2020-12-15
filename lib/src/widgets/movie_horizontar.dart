import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Pelicula> peliculas;

  const MovieHorizontalWidget({
    Key key,
    @required this.peliculas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context);
    return Container(
      height: _screen.size.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
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
      );
    }).toList();
  }
}
