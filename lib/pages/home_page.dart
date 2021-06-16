import 'package:flutter/material.dart';
import 'package:pokedex/controllers/home_controller.dart';
import 'package:pokedex/pages/detail_page.dart';
import 'package:pokedex/repositories/poke_repository_impl.dart';
import 'package:pokedex/widget/infinite_grid_view.dart';
import 'package:pokedex/widget/pokemon_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(PokeRepositoryImpl());

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    await _controller.fetch();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: InfiniteGridView(
        crossAxisCount: 2,
        itemBuilder: _buildPokemonCard,
        itemCount: _controller.length,
        hasNext: _controller.length < 1118,
        nextData: _onNextData,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Pokedex',
        style: TextStyle(
            fontFamily: 'PokemonSolid', color: Colors.black, fontSize: 30),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {},
        ),
      ],
    );
  }

  void _onNextData() async {
    await _controller.next();
    setState(() {});
  }

  Widget _buildPokemonCard(BuildContext context, int index) {
    final pokemon = _controller.pokemons[index];
    return PokemonCard(
      pokemon: pokemon,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailPage(
              pokemon: pokemon,
            ),
          ),
        );
      },
    );
  }
}
