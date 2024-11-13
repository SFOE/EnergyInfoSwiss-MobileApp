import 'package:energy_dashboard/core/mixins/webview_mixin.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';


/// Service for integrated WebView
///
/// Handles all webview functionalities,
/// used in the details pages
class WebviewService extends ChangeNotifier with WebviewMixin{

  BuildContext context;
  late final PlatformWebViewControllerCreationParams params;
  late final WebViewController controller;
  late final WebViewCookieManager cookieManager;
  late ValueNotifier<double>? loading;


  WebviewService({required this.context}){
    loading = ValueNotifier(0);
    _initWebViewParams();
    _initWebViewController(params);
  }


  @override
  dispose(){
    if(loading != null){
      loading!.dispose();
      loading = null;
    }
    super.dispose();
  }


  // Initializations

  _initWebViewParams(){
    // #docregion platform_features
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
  }

  _initWebViewController(PlatformWebViewControllerCreationParams params){
    controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => loading != null ? loading!.value = progress/10 : {},
          onPageStarted: (String url) => _onPageStarted(url),
          onPageFinished: (String url) => _onPageFinished(url),
          onWebResourceError: (WebResourceError error) => printWebError(error),
          onNavigationRequest: (NavigationRequest request) => _onNavigationRequest(request, context),
          onUrlChange: (UrlChange change) => _onUrlChange(change),
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('Toaster JS Channel: ${message.message}');
        },
      );
    cookieManager = WebViewCookieManager();

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }


  void _onUrlChange(UrlChange change){
    debugPrint('[WebView] Url change to ${change.url}');
    cookieManager.clearCookies();
    controller.clearCache();
  }
  
  void _onPageStarted(String url){
    debugPrint('[WebView] Page started loading: $url');
    cookieManager.clearCookies();
  }

  void _onPageFinished(String url){
    debugPrint('[WebView] Page finished loading: $url');
  }

  NavigationDecision _onNavigationRequest(NavigationRequest request, BuildContext context){
    if (!allowedPaths.any((path) => request.url.toLowerCase().contains(path))) {
      debugPrint('blocking navigation to ${request.url}');
      Utils().launchExternalUrl(request.url, context);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }


  void loadRequest(String url){
    controller.loadRequest(Uri.parse(url));
  }


}