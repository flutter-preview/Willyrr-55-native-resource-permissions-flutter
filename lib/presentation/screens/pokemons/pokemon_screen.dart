import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

import '../../../domain/entities/pokemon.dart';

class PokemonScreen extends ConsumerWidget {

  final String pokemonId;

  const PokemonScreen({
    super.key, 
    required this.pokemonId
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
      data: (Pokemon data) => _PokemonView(pokemon: data), 
      error: (Object error, StackTrace stackTrace) => _ErrorWidget(message: error.toString()), 
      loading: () => const Center( child: CircularProgressIndicator() )
    );
  }
}

class _PokemonView extends StatelessWidget {

  final Pokemon pokemon;
  
  const _PokemonView({
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(pokemon.name), 
        actions: [
          IconButton(
            onPressed: (){
                // Link = DeepLink
               SharePlugin.shareLink(pokemon.spriteFront, 'Mira este pókemon');
            }, 
            icon: const Icon( Icons.share_outlined )
          )
        ],
      ),
      body: Center(
        child: Image.network(
          pokemon.spriteFront,
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {

  final String message;
  
  const _ErrorWidget({
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ), 
    );
  }
}