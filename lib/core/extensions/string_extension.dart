



extension StringExtension on String{
  String removeHtmlTags(){
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  String removePunctuation(){
    return replaceAll(RegExp(r'[^\s\w]'), '');
  }

}