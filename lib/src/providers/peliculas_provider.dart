import 'dart:async';
import 'dart:convert';

import 'package:flutter_peliculas/src/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '69eeb25628eefab542b1403baba6be3e';
  String _url = 'api.themoviedb.org';
  String _language = 'es-CO';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);

    final decodeData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return this._procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    print(_cargando);
    print(_popularesPage);

    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;

    //return this._procesarRespuesta(url);
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    return cast.actores;
  }
}
