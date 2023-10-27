import 'package:energy_dashboard/domain/services/webview_service.dart';
import 'package:energy_dashboard/presentation/components/web_view/web_view_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';


class BfeWebview extends StatefulWidget {
  final String url;
  const BfeWebview({Key? key, required this.url}) : super(key: key);

  @override
  State<BfeWebview> createState() => _BfeWebviewState();
}

class _BfeWebviewState extends State<BfeWebview> {

  late final WebviewService _webviewService;

  @override
  void initState() {
    super.initState();
    _webviewService = context.read<WebviewService>()
      ..loadRequest(widget.url)
      ..loading = ValueNotifier(0);
  }


  @override
  void dispose() {
    if(!mounted) _webviewService.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _webviewService.loading!,
      builder: (context, loading, _) {
        return Stack(
          children: [
            loading < 10
              ? WebViewLoading(loading: loading)
              : WebViewWidget(controller: _webviewService.controller),
          ],
        );
      }
    );
  }

}