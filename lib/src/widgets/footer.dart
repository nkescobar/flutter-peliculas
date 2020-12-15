import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter_peliculas/src/widgets/movie_horizontar.dart';

class FooterWidget extends StatelessWidget {
  final PeliculasProvider peliculasProvider;
  const FooterWidget({
    Key key,
    @required this.peliculasProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5.0,
          ),
          //FutureBuilder
          StreamBuilder(
            // future: this.peliculasProvider.getPopulares(),
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                snapshot.data?.forEach((p) => print(p.title));
                return MovieHorizontalWidget(
                  peliculas: snapshot.data,
                );
              } else {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
