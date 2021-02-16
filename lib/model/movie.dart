class MovieModel {
  final String id;
  final String slug;
  final String title;
  final String overview;
  final String tagline;
  final String classification;
  final int duration;
  final String realeaseDate;
  final double imdRate;

  MovieModel(
      {this.id,
      this.slug,
      this.title,
      this.overview,
      this.tagline,
      this.classification,
      this.duration,
      this.imdRate,
      this.realeaseDate});

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        slug = json['slug'],
        title = json['title'],
        overview = json['overview'] == null ? "" : json['overview'],
        tagline = json['tagline'] == null ? "" : json['tagline'],
        classification =
            json['classification'] == null ? "" : json['classification'],
        duration = json['runtime'] == null ? 0 : json['runtime'],
        realeaseDate = json['released_on'] == null ? "" : json['released_on'],
        imdRate = json['imdb_rating'] == null
            ? 0.0
            : double.parse(json['imdb_rating'].toString());
}
