import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  PolemonsView(),
    );
  }
}

class PolemonsView extends ConsumerStatefulWidget {

  const PolemonsView({super.key});

  @override
  PolemonsViewState createState() => PolemonsViewState();
}

class PolemonsViewState extends ConsumerState<PolemonsView> {

  final scrollController = ScrollController();

  void infiniteScroll(){
    final currentsPokemons = ref.read(pokemonIdsProvider);
    if(currentsPokemons.length > 400){
      scrollController.removeListener(infiniteScroll);
      return ;
    }

    if( (scrollController.position.pixels + 200) > scrollController.position.maxScrollExtent){
      ref.read(pokemonIdsProvider.notifier).update((state) => [
        ...state, 
        ...List.generate(30, (index) => state.length + index + 1)
      ]);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(infiniteScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),

        const _PolemonGrid()
      ],
    );
  }
}

class _PolemonGrid extends ConsumerWidget {

  const _PolemonGrid();

  @override
  Widget build(BuildContext contex, WidgetRef ref) {

    final pokemonIds = ref.watch(pokemonIdsProvider);

    return SliverGrid.builder(
      itemCount: pokemonIds.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index){
         return GestureDetector(
           onTap: () => context.push('/pokemons/${index +1}'),
           child: Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
            fit: BoxFit.contain,
           ),
         );
      },
    );
  }
}