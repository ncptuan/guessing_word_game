enum Method {
  get,
  post;

  String getMethodValue() {
    switch (this) {
      case get:
        return "GET";
      case post:
        return "POST";
      default:
        return "GET";
    }
  }
}
