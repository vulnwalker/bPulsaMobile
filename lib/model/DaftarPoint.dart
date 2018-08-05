class Resp{
  int status;
  bool success;
  String reason,message;
  Result result;
  Resp({
    this.status,
    this.reason,
    this.success,
    this.message,
    this.result,
});

factory Resp.fromJson(Map<String, dynamic> parsedJson){
    return Resp(
      status: parsedJson['status'],
      reason: parsedJson['reason'],
      success: parsedJson['success'],
      message: parsedJson['message'],
      result: Result.fromJson(parsedJson['result'])
    );
  }
}

class Result{
  String cek;
  String err;
  Content content;
  Result({
    this.cek,
    this.err,
    this.content
});
//
factory Result.fromJson(List<dynamic> json){
    var parsedJson = new Map<String, dynamic>.from(json[0]);
    return Result(
      cek: parsedJson['cek'],
      err: parsedJson['err'],
      content: Content.fromJson(parsedJson['content'])
    );
  }
}

class Content{
   int id;
   String title;
   int price;
   String description;
   int stock;
  Content({
  this.id, this.title, this.price, this.description,this.stock
});

  factory Content.fromJson(Map<String, dynamic> json){
    return Content(
      id: json['id'] ,
      title: json['title'] ,
      price: json['price'],
      description: json['description'] ,
      stock: json['stock'] ,
    );
  }
}


// class Content {
//   final int id;
//   final String title;
//   final int price;
//   final String description;
//   final int stock;

//   Content({this.id, this.title, this.price, this.description,this.stock});
//   factory Content.fromJson(Map<String, dynamic> json) {
//     var parsedJson = new Map<String, dynamic>.from(json[0]);
//     return Content(
//       id: parsedJson['id'] ,
//       title: parsedJson['title'] ,
//       price: parsedJson['price'],
//       description: parsedJson['description'] ,
//       stock: parsedJson['stock'] ,
//     );
//   }
// }
