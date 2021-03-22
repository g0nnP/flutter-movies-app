import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final Movie movie = ModalRoute.of( context ).settings.arguments;
  
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0 ),
                _titlePoster( context, movie ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
                _description( movie ),
                _createCasting( movie ),
              ]
            ),
          )
        ],
      )
    );
  }

  SliverAppBar _createAppBar( Movie movie ) => SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: Container(
            padding: EdgeInsets.all( 5.0 ),
            margin: EdgeInsets.symmetric( horizontal: 1.0 ),
            color: Colors.black.withOpacity( 0.5 ),
            child: Text(
              movie.title,
              style: TextStyle( color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(
            movie.getBackgroundImg()
          ),
          placeholder: AssetImage( 'assets/img/loading.gif' ),
          fadeInDuration: Duration( milliseconds: 150 ),
          fit: BoxFit.cover
        ),
      ),
    );

  Container _titlePoster( BuildContext context, Movie movie) => Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),
      child: Row(
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 20.0 ),
              child: Image(
                image: NetworkImage(movie.getPosterImg() ),
                height: 150.0,
              ),
            ),
          ),
          SizedBox( width: 20.0 ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( movie.title, style: Theme.of( context ).textTheme.headline5, overflow: TextOverflow.ellipsis,),
                Text( movie.originalTitle, style: Theme.of( context ).textTheme.subtitle2, overflow: TextOverflow.ellipsis ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text( movie.voteAverage.toString(), style: Theme.of( context ).textTheme.subtitle2 )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );

  Container _description(Movie movie) => Container(
      padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 20.0 ),
      child: Text( movie.overview, textAlign: TextAlign.justify, ),
    );


  Widget _createCasting( Movie movie ) {

    final movieProvider = MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast( movie.id.toString() ),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if ( snapshot.hasData ) {
          return _createActorPageview( snapshot.data );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

  }

  SizedBox _createActorPageview( List<Actor> actors ) => SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemBuilder: ( context, i ) => _actorCard( actors[i] ),
        itemCount: actors.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        )
      )
    );


  Container _actorCard( Actor actor ) => Container(
      margin: EdgeInsets.only( left: 10.0 ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular( 20.0 ),
            child: FadeInImage(
              image: NetworkImage( actor.getProfilePath() ),
              placeholder: AssetImage( 'assets/img/no-image.jpg' ),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text( actor.name, overflow: TextOverflow.ellipsis ),
        ]
      ),
    );

}