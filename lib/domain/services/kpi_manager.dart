import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/entities/key_performance_index.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

/// Service for the KPIs (Editor mode)
///
/// Manages the KPIs for the specified route
/// when in editing mode
class KPIManager extends ChangeNotifier{

  late DatabaseRepository databaseRepository;

  late ScrollController scrollController;
  late bool editorMode;
  late NavigationRoute currentRoute;

  // flag to check if kpis are available (not in loading state)
  late bool isAvailable;

  // -
  late List<KeyPerformanceIndex> kpis;

  // backup of kpis, used when changes were discarded
  late List<KeyPerformanceIndex> backupKpis;

  KeyPerformanceIndex? activeKPI;

  KPIManager(){
    currentRoute = NavigationRoute.overview;
    editorMode = false;
    isAvailable = false;
    kpis = [];
    backupKpis = [];
    scrollController = ScrollController();
    databaseRepository = GetIt.I.get<DatabaseRepository>();
  }

  @override
  dispose(){
    kpis.clear();
    backupKpis.clear();
    scrollController.dispose();
    super.dispose();
  }

  updateRoute(NavigationRoute route){
    if(currentRoute != route){
      currentRoute = route;
    }
  }

  toggleEditorMode(){
    if(isAvailable){
      editorMode = !editorMode;
      if(editorMode){
        initKPIs();
      }
      notifyListeners();
    }
  }

  disableEditorMode(){
    if(editorMode){
      editorMode = false;
      notifyListeners();
    }
  }

  saveChanges(BuildContext context){
    databaseRepository.saveChanges(kpis, currentRoute, context);
    kpis.clear();
    backupKpis.clear();
    disableEditorMode();
    FlashMessageFactory.showFlashMessage(
      context: context,
      type: FlashMessageType.success,
      title: Translations.of(context)!.text('snackbar.saved-changes.success'),
    );
  }


  discardChanges(BuildContext context){
    // save backup kpis (unedited kpis)
    databaseRepository.saveChanges(backupKpis, currentRoute, context);
    kpis.clear();
    backupKpis.clear();
    notifyListeners();
    disableEditorMode();
  }

  initKPIs(){
    kpis = List.from(
      databaseRepository.getKPIsByRoute(currentRoute));
    kpis.sort((a,b) => a.position.compareTo(b.position));
    backupKpis = kpis.map((k) => k.copyWith()).toList(); // deep copy
    notifyListeners();
  }


  setAvailable(){
    if(!isAvailable){
      isAvailable = true;
    }
  }

  setUnavailable(){
    if(isAvailable){
      isAvailable = false;
    }
  }

  // re-order KPI list
  updatePosition(int oldIndex, int newIndex){

    // KPI with old index
    KeyPerformanceIndex movedKPI = kpis.firstWhere((k) => k.position == oldIndex && k.route == currentRoute);

    // update the position of the moved KPI to the newIndex
    movedKPI.position = newIndex;

    if(newIndex > oldIndex){
      // moving the KPIs down the list
      for(var kpi in kpis){
        if(kpi != movedKPI && kpi.position > oldIndex && kpi.position <= newIndex){
          kpi.position--;
        }
      }
    }else{
      // moving the KPI up the list
      for(var kpi in kpis){
        if(kpi != movedKPI && kpi.position >= newIndex && kpi.position < oldIndex){
          kpi.position++;
        }
      }
    }
    // sort KPIs again
    kpis.sort((a,b) => a.position.compareTo(b.position));
  }

  unsetFavorite(KeyPerformanceIndex kpi){
    kpis.removeWhere((k) => k.name == kpi.name && k.category == kpi.category && k.route == NavigationRoute.overview);
    for(var k in kpis){
      if(k.position > kpi.position){
        k.position--;
      }
    }
    notifyListeners();
  }

  toggleDisabled(KeyPerformanceIndex kpi){
    KeyPerformanceIndex updateKpi = kpis.firstWhere((k) => k.name == kpi.name && k.category == kpi.category && k.route == kpi.route);
    updateKpi.isDisabled = !updateKpi.isDisabled;

    // update positions
    int enabledKpis = kpis.where((k) => !k.isDisabled).length;
    if(updateKpi.isDisabled){
      updatePosition(updateKpi.position, enabledKpis);
    }else{
      updatePosition(updateKpi.position, enabledKpis-1);
    }

    notifyListeners();
  }


}