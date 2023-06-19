import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AskPermissionScreen extends ConsumerWidget {
  const AskPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso Requerido'),
      ),
      body: Center(
        child: FilledButton(
          child: const Text('Localicación necesaria'),
          onPressed: (){
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
      ),
    );
  }
}