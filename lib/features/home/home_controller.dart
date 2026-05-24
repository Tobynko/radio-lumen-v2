import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'models/home_state.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    return const HomeState();
  }

  void setMessage(String message) {
    state = state.copyWith(message: message);
  }
}
