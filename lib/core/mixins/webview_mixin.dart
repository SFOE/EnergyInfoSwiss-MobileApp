import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


mixin WebviewMixin{

  final List<String> allowedPaths = [
    '/dashboard',
    '/strom/',
    '/gas/',
    '/preise/',
    '/wetter/',
    'ax-statement',
    'data-protection'
  ];


  void printWebError(WebResourceError error){
    debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
  }

}