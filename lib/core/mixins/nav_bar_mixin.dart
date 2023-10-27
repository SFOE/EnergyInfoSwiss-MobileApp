import 'package:energy_dashboard/core/resources/paddings.dart';


mixin NavBarMixin{

  static const double horizontalPadding = Paddings.paddingS;
  static const double topPadding = 6;
  static const double sliderPadding = 12;
  static const int heightAnimationDuration = 220;
  static const int sliderAnimationDuration = 180;
  static const double labelFontSize = 12;

  double getSliderPosition(int index, double navBarItemWidth, double sliderPadding){
    return (index * navBarItemWidth) + (sliderPadding/2) + (Paddings.paddingS);
  }

}