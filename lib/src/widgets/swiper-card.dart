import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  const CardSwiperWidget({Key key, @required this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/not-found.png'),
                image: NetworkImage(peliculas[index].getPosterImg()),
                fit: BoxFit.fill,
              ));
        },
        itemCount: peliculas.length,
        itemWidth: _screenSize.size.width * 0.7,
        itemHeight: _screenSize.size.height * 0.5,
        // pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
