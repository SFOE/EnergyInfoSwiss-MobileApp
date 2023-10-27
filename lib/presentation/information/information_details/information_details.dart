import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/utils/information_details_parameter.dart';
import 'package:energy_dashboard/domain/services/webview_service.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/web_view/bfe_webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// This Widget is used for all information subpages (like Barrierefreiheit, ...)
class InformationDetails extends StatelessWidget {
  final InformationDetailsParameter detailsParameter;
  const InformationDetails({super.key, required this.detailsParameter});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WebviewService(context: context),
      child: Scaffold(
        backgroundColor: ColorPalette.websiteBgColor,
        appBar: Header(title: detailsParameter.title, showBackButton: true),
        body: SafeArea(
          child: BfeWebview(url: detailsParameter.url),
        ),
      ),
    );
  }
}
