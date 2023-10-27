import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';


class StarButton extends StatefulWidget {
  const StarButton({super.key});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> with SingleTickerProviderStateMixin{
  
  late DatabaseRepository _databaseRepository;
  late KeyPerformanceIndex _activeKPI;
  late ValueNotifier<bool> _isFavorite;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _activeKPI = context.read<KPIManager>().activeKPI!;
    _databaseRepository = GetIt.I.get<DatabaseRepository>();
    _isFavorite = ValueNotifier(_databaseRepository.isFavorite(_activeKPI));
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween<double>(begin: Constants.kStarIconSize, end: Constants.kStarIconAnimationSize).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut)
    );
  }

  @override
  void dispose() {
    _isFavorite.dispose();
    _animationController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          height: Constants.kStarIconSize,
          width: Constants.kStarIconSize,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: ValueListenableBuilder(
              valueListenable: _isFavorite,
              builder: (context, isFavorite, _) {
                return SvgPicture.asset(
                  isFavorite
                    ? 'assets/icons/kpi_card/star-fill.svg'
                    : 'assets/icons/kpi_card/star-outline.svg',
                  width: _animation.value,
                  height: _animation.value,
                  colorFilter: const ColorFilter.mode(ColorPalette.kpiCardStarColor, BlendMode.srcIn),
                );
              }
            ),
            onPressed: (){
              _animationController.forward().then((_) => _animationController.reverse().then((_) => _isFavorite.value = !_isFavorite.value));
              if(_isFavorite.value){
                _databaseRepository.removeFavorite(_activeKPI, context);
              }else{
                _databaseRepository.addFavorite(_activeKPI, context);
              }
            },
          ),
        );
      }
    );
  }
}
