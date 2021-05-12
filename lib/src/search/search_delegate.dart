import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final List<String> peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
    'Soul',
  ];

  final List<String> peliculasRecientes = [
    'Spiderman',
    'Capitan America',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.purple),
      primaryColorBrightness: Brightness.dark,
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appbar limpiar o cancelar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print('ICON PRESED');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('ICON animated PRESED');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder la instriuccion que crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/images/not-found.png'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(pelicula.title),
              subtitle: Text(pelicula.originalTitle),
              onTap: () {
                close(context, null);
                pelicula.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: pelicula);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
/*

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando la persona escribe
    final List<String> listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.movie),
                title: Text(listaSugerida[i]),
                onTap: () {
                  seleccion = listaSugerida[i];
                  showResults(context);
                },
              ),
              Divider(),
            ],
          );
        });
  }*/
}
