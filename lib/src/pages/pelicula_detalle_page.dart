import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/actores_model.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetallePage extends StatefulWidget {
  PeliculaDetallePage({Key key}) : super(key: key);

  @override
  _PeliculaDetallePageState createState() => _PeliculaDetallePageState();
}

class _PeliculaDetallePageState extends State<PeliculaDetallePage> {
  PeliculasProvider _peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      /*appBar: AppBar(
        title: Text('${pelicula.title}'),
      ),*/
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(pelicula: pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              PosterTituloWidget(
                pelicula: pelicula,
              ),
              DescripcionWidget(
                pelicula: pelicula,
              ),
              CrearCastingWidget(
                peliculasProvider: _peliculasProvider,
                pelicula: pelicula,
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class PeliculaDetallePageOtro extends StatelessWidget {
  PeliculasProvider _peliculasProvider = new PeliculasProvider();

  PeliculaDetallePageOtro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      /*appBar: AppBar(
        title: Text('${pelicula.title}'),
      ),*/
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(pelicula: pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              PosterTituloWidget(
                pelicula: pelicula,
              ),
              DescripcionWidget(
                pelicula: pelicula,
              ),
              CrearCastingWidget(
                pelicula: pelicula,
                peliculasProvider: _peliculasProvider,
              )
            ]),
          )
        ],
      ),
    );
  }
}

class SliverAppBarWidget extends StatelessWidget {
  final Pelicula pelicula;
  const SliverAppBarWidget({
    Key key,
    @required this.pelicula,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      //  backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '${pelicula.title}',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/images/not-found.png'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PosterTituloWidget extends StatelessWidget {
  final Pelicula pelicula;
  const PosterTituloWidget({
    Key key,
    @required this.pelicula,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DescripcionWidget extends StatelessWidget {
  final Pelicula pelicula;
  const DescripcionWidget({
    Key key,
    @required this.pelicula,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class CrearCastingWidget extends StatelessWidget {
  final PeliculasProvider peliculasProvider;
  final Pelicula pelicula;

  const CrearCastingWidget({
    Key key,
    @required this.peliculasProvider,
    @required this.pelicula,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: peliculasProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CrearActoresPageView(
            actores: snapshot.data,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CrearActoresPageView extends StatelessWidget {
  final List<Actor> actores;
  const CrearActoresPageView({
    Key key,
    @required this.actores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        itemCount: actores.length,
        itemBuilder: (context, i) {
          return ActorCardWidget(
            actor: actores[i],
          );
        },
      ),
    );
  }
}

class ActorCardWidget extends StatelessWidget {
  final Actor actor;
  const ActorCardWidget({
    Key key,
    @required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(
                actor.getFoto(),
              ),
              height: 150.0,
              placeholder: AssetImage('assets/images/not-found.png'),
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
