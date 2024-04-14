class Movie {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String genre;
  final int durationInMinute;
  final String title;
  final String description;
  final String? deletedDate;
  final String? image;

  Movie({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.genre,
    required this.durationInMinute,
    required this.title,
    required this.description,
    this.deletedDate,
    this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      genre: json['genre'],
      durationInMinute: json['durationInMinute'],
      title: json['title'],
      description: json['description'],
      deletedDate: json['deletedDate'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'title' : title
    };
  }
}
