



abstract class ApiConsumer {
  Future <dynamic> get ({required String url , Map <String , dynamic> queryParam });
  Future <dynamic> post ({ required String url ,
   required dynamic body  });
}