

extension UriExtension on Uri{

  String toUrl() => Uri.decodeFull(toString());

}