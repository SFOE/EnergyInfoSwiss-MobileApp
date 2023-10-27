import 'package:energy_dashboard/core/mixins/kpi_card_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/kpi_category.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/details_parameter.dart';
import 'package:energy_dashboard/core/utils/kpi_utils.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card_category.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card_chart.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card_editor_row.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card_title.dart';
import 'package:energy_dashboard/presentation/components/kpi_card/kpi_card_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class KpiCard extends StatefulWidget {
  final KeyPerformanceIndex kpi;
  final NavigationRoute currentRoute;
  final bool editorMode;
  const KpiCard({super.key, required this.kpi, required this.currentRoute, this.editorMode=false});

  @override
  State<KpiCard> createState() => _KpiCardState();
}

class _KpiCardState extends State<KpiCard> with SingleTickerProviderStateMixin, KPICardMixin {

  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 340));
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        child: Container(
          width: getCardSize(screenWidth, widget.kpi.isExpanded),
          height: getCardSize(screenWidth, widget.kpi.isExpanded),
          decoration: BoxDecoration(
            color: widget.kpi.isDisabled
              ? ColorPalette.grey100
              : ColorPalette.white,
            borderRadius: BorderRadius.circular(KPICardMixin.kKpiCardBorderRadius),
            border: Border.all(width: widget.editorMode ? KPICardMixin.kKpiCardBorderWidthEditorMode : KPICardMixin.kKpiCardBorderWidth, color: ColorPalette.kpiCardBorderColor),
          ),
          padding: EdgeInsets.all(widget.editorMode ? Paddings.paddingKpiCard-KPICardMixin.kKpiCardBorderWidthEditorMode : Paddings.paddingKpiCard),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // editor widgets
              if(widget.editorMode)
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: KpiCardEditorRow(
                    kpi: widget.kpi,
                    route: widget.currentRoute,
                    fadeCallback: (){
                      // unstar
                      if(widget.kpi.route == NavigationRoute.overview){
                        _animationController.forward().whenComplete(() =>
                          context.read<KPIManager>().unsetFavorite(widget.kpi)
                        );
                      }
                      // hide/disable
                      else{
                        _animationController.forward().whenComplete(() =>
                          context.read<KPIManager>().toggleDisabled(widget.kpi)
                        );
                      }
                    },
                  ),
                ),

              // category
              if(widget.currentRoute == NavigationRoute.overview && !widget.editorMode)
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: KpiCardCategory(kpi: widget.kpi),
                ),

              // title
              Flexible(
                fit: FlexFit.loose,
                flex: 5,
                child: KpiCardTitle(kpi: widget.kpi, editorMode: widget.editorMode, route: widget.currentRoute),
              ),

              // chart and value
              Flexible(
                fit: FlexFit.loose,
                flex: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KpiCardChart(kpi: widget.kpi),
                    const Spacer(flex: 2),
                    KpiCardValue(kpi: widget.kpi),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: (){
          if(!widget.editorMode){
            Navigation.goToDetails(
              widget.currentRoute,
              DetailsParameter(
                kpi: widget.kpi,
                title: widget.kpi.category == KPICategory.price
                  ? '${Translations.of(context)!.text("dashboard.preise.context-name.lang")}: ${KPIUtils().getTitleByJsonKey(widget.kpi.name, widget.kpi.category, context)}'
                  : KPIUtils().getTitleByJsonKey(widget.kpi.name, widget.kpi.category, context),
                url: KPIUtils().getDetailsUrlByJsonKey(widget.kpi.name, widget.kpi.category, context)
              ),
            );
            context.read<KPIManager>().activeKPI = widget.kpi;
          }
        },
      ),
    );
  }
}
