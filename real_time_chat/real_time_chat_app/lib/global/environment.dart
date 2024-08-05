class Environment {
  final String _apiUrl = "http://192.168.100.3:3000/api/";
  final String _socketUrl = "http://10.0.2.2:3000/api/";
  String get login => '${_apiUrl}login';
  String get signIn => '${_apiUrl}signin/new';
}
