class watchListResponse {
  String? message;
  List<Data>? data;

  watchListResponse({this.message, this.data});

  watchListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  Data({this.movieId, this.name, this.rating, this.imageURL, this.year});

  Data.fromJson(Map<String, dynamic> json) {
    movieId = int.parse(json['movieId']);
    name = json['name'];
    rating = (json['rating'] as num?)?.toDouble();
    imageURL = json['imageURL'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['movieId'] = movieId;
    data['name'] = name;
    data['rating'] = rating;
    data['imageURL'] = imageURL;
    data['year'] = year;
    return data;
  }
}
