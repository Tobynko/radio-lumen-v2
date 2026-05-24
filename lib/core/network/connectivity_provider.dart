// Path: lib/core/network/connectivity_provider.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
Stream<List<ConnectivityResult>> connectivity(Ref ref) async* {
  final connectivity = Connectivity();

  // 1. Initial state
  yield await connectivity.checkConnectivity();

  // 2. Combine the system stream with a polling fallback
  final controller = StreamController<List<ConnectivityResult>>();

  final subscription = connectivity.onConnectivityChanged.listen((results) {
    controller.add(results);
  });

  final timer = Timer.periodic(const Duration(seconds: 3), (_) async {
    final current = await connectivity.checkConnectivity();
    controller.add(current);
  });

  ref.onDispose(() {
    subscription.cancel();
    timer.cancel();
    controller.close();
  });

  yield* controller.stream;
}

@riverpod
bool isOffline(Ref ref) {
  final connectivityAsync = ref.watch(connectivityProvider);

  return connectivityAsync.maybeWhen(
    data: (results) {
      if (results.isEmpty) return true;
      return !results.any(
        (r) =>
            r != ConnectivityResult.none && r != ConnectivityResult.bluetooth,
      );
    },
    orElse: () => false,
  );
}
