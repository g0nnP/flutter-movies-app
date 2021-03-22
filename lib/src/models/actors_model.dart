class Cast {
  List<Actor> actors = [];

  Cast.fromJsonList( List<dynamic> jsonList ) {
    if( jsonList == null ) return;

    jsonList.forEach( ( item ) {
      final actor = Actor.fromJsonMap( item );

      actors.add( actor );
    } );
  }


}

class Actor {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ) {  
    adult        = json['adult'];
    gender       = json['gender'];
    id           = json['id'];
    name         = json['name'];
    originalName = json['original_name'];
    popularity   = json['popularity'];
    profilePath  = json['profile_path'];
    castId       = json['cast_id'];
    character    = json['character'];
    creditId     = json['creditId'];
    order        = json['order'];
    job          = json['job'];
  }

  getProfilePath() {
    if( profilePath == null ) {
      return 'http://proanglet.bythewave.training/app-assets/images/logo/no_avatar.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}
