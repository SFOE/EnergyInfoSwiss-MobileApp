import 'package:flutter/material.dart';


mixin ApiRepositoryMixin{

  // get ampel color for respective level
  Color getAmpelColorByLevel(int level){
    switch(level){
      case 1:
        return const Color(0xFF96cc91);
      case 2:
        return const Color(0xFFf1d129);
      case 3:
        return const Color(0xFFeb9f46);
      case 4:
        return const Color(0xFFed5f22);
      case 5:
        return const Color(0xFF7f1610);
      default:
        return const Color(0xFFEEEEEE);
    }
  }

}