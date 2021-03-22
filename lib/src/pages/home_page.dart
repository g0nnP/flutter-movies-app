import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Scaffold build(BuildContext context) {
    moviesProvider.getPopularMovies();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( 'Películas en cines' ),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () => showSearch(
              context: context,
              delegate: DataSearch()
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cardSwiper(),
            _footer( context )
          ]
        )
      ),
    );
  }

  Widget _cardSwiper() => FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if( snapshot.hasData ) {
          return CardSwiper( movies: snapshot.data, );
        } else {
          return Container(
            height: 350,
            child: Center( child: CircularProgressIndicator() )
          );
        }

      },
    );


  Container _footer( BuildContext context ) => Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only( left: 20.0 ),
            child: Text( 'Populares', style: Theme.of( context ).textTheme.subtitle1 )
          ),
          SizedBox( height: 1.0, ),
          StreamBuilder(
            stream: moviesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if( snapshot.hasData ) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopularMovies,
                  );
              } else {
                return Center(child: CircularProgressIndicator());
              }

            },
          ),
        ]
      ),
      width: double.infinity
    );


}