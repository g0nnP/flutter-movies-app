class Movies {
  List<Movie> items = [];

  Movies();

  Movies.fromJsonList( List<dynamic> jsonList ){
    if( jsonList == null ) return;
    for ( var item in jsonList ) {
      final movie = new Movie.fromJsonMap( item );
      items.add( movie );
    }
  }

}


class Movie {
  String uniqueId;
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.overview,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalTitle,
    this.releaseDate
  });
  
  Movie.fromJsonMap( Map<String, dynamic> json ) {
    voteCount        = json[ 'vote_count' ];
    id               = json[ 'id' ];
    video            = json[ 'video' ];
    voteAverage      = json[ 'vote_average' ] / 1;
    title            = json[ 'title' ];
    popularity       = json[ 'popularity' ]; 
    posterPath       = json[ 'poster_path' ];
    originalLanguage = json[ 'original_language' ];
    overview         = json[ 'overview' ];
    adult            = json[ 'adult' ];
    backdropPath     = json[ 'backdrop_path' ];
    genreIds         = json[ 'genre_ids' ].cast<int>();
    originalTitle    = json[ 'original_title' ];
    releaseDate      = json[ 'release_date' ];
  }

  getPosterImg() {

    if( posterPath == null ) {
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {

    if( backdropPath == null ) {
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }

}
