/*Here we used the interface to which force the class to use its methods
* */
class HttpException implements Exception{
  final String message;
  HttpException(this.message);

  @override
  String toString() {
  return message;
  }
}