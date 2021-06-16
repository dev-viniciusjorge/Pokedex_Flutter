import 'package:flutter/material.dart';

import 'package:pokedex/helpers/pokemon_type_helper.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;

  const PokemonTypeChip({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Text(
        PokemonTypeHelper.getIcon(type),
        style: TextStyle(
            fontFamily: 'PokeGoTypes', color: Colors.white, fontSize: 15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      label: Text(
        type,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      backgroundColor: PokemonTypeHelper.getColor(type),
    );
  }
}
