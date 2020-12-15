import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter_peliculas/src/widgets/footer.dart';
import 'package:flutter_peliculas/src/widgets/swiper-card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PeliculasProvider _peliculasProvider = new PeliculasProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: this._peliculasProvider.getEnCines(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return CardSwiperWidget(
                      peliculas: snapshot.data,
                    );
                  } else {
                    return Container(
                      height: 300.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
              FooterWidget(
                peliculasProvider: this._peliculasProvider,
              )
            ],
          ),
        ));
  }
}
