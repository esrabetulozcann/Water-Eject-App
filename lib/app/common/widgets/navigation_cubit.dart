import 'package:flutter_bloc/flutter_bloc.dart';

enum AppTab { eject, tone, meter, stereo }

class NavigationState {
  final AppTab tab;
  const NavigationState(this.tab);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(AppTab.eject));
  void setTab(AppTab tab) => emit(NavigationState(tab));
  int get index => AppTab.values.indexOf(state.tab);
  void setIndex(int i) => setTab(AppTab.values[i]);
}
