// Path: lib/core/network/connectivity_provider.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
Stream<List<ConnectivityResult>> connectivity(Ref ref) async* {
  final connectivity = Connectivity();

  // 1. Initial state
  final initial = await connectivity.checkConnectivity();
  print('[connectivity] INITIAL: $initial');
  yield initial;

  final controller = StreamController<List<ConnectivityResult>>();
  
  // 2. System Stream
  final subscription = connectivity.onConnectivityChanged.listen((results) {
    print('[connectivity] SYSTEM EVENT: $results');
    controller.add(results);
  });

  // 3. Robust Polling
  final timer = Timer.periodic(const Duration(seconds: 2), (_) async {
    final current = await connectivity.checkConnectivity();
    // Log EVERY poll to see what the OS thinks
    print('[connectivity] POLL CHECK: $current');
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
      // Online if any result is NOT none
      final isReallyOnline = results.any((r) => 
        r != ConnectivityResult.none && r != ConnectivityResult.bluetooth
      );
      return !isReallyOnline;
    },
    orElse: () => false,
  );
}
