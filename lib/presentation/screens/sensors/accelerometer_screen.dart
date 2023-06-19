import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';


class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final accelerometerGravity$ = ref.watch(accelerometerGravityProvider);
    final accelerometerUser$ = ref.watch(accelerometerUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerómetro'),
      ),
      body: Center(
        child: Column(
          children: [
            accelerometerGravity$.when(
              data: (value) => Column(
                children: [
                  const Text('Acelerometro con gravedad', style: TextStyle(fontSize:25) ),
                  Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
              error:(error, stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator()
            ),
            accelerometerUser$.when(
              data: (value) => Column(
                children: [
                  const Text('Acelerometro sin gravedad', style: TextStyle(fontSize:25) ),
                  Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
              error:(error, stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator()
            ),
          ],
        ),
    ));
  }
}