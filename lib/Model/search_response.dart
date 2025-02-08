class SearchResponse {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  SearchResponse({this.page, this.results, this.totalPages, this.totalResults});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  }


class Result {
  String? title;

  Result({this.title});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }


}