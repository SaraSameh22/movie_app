class watchListResponse {
  String? message;
  List<Data>? data;

  watchListResponse({this.message, this.data});

  watchListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
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
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movieId'] = this.movieId;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['imageURL'] = this.imageURL;
    data['year'] = this.year;
    return data;
  }
}