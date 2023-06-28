


import 'package:miscelaneos/infrasctructure/datasources/pokemons_datasource_impl.dart';

import '../../domain/domain.dart';

class PokemonsRepositoryImpl implements PokemonsRepository{

  final PokemonsDatasource datasource;

  PokemonsRepositoryImpl( PokemonsDatasource? datasource): datasource = datasource ?? PokemonDatasoruceImpl();
  
  @override
  Future<(Pokemon?, String)> getPokemon(String id) {
    return datasource.getPokemon(id);
  }
  
}