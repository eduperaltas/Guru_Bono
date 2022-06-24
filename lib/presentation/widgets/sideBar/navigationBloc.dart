import 'package:guru_bono/presentation/views/bonos/bonosScreen.dart';
import 'package:guru_bono/presentation/views/home/homeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvents {
  homeScreenClickedEvent,
  pedidosScreenClickedEvent,
}

class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(HomeScreen()) {
    on<NavigationEvents>((event, emit) {
      switch (event) {
        case NavigationEvents.homeScreenClickedEvent:
          emit(HomeScreen());
          break;
        case NavigationEvents.pedidosScreenClickedEvent:
          emit(BonosScreen());
          break;
      }
    });
  }
}
