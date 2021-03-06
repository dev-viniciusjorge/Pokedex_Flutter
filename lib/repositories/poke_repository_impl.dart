import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokedex/core/app_api.dart';
import 'package:pokedex/core/erros.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/poke_repository.dart';

class PokeRepositoryImpl implements PokeRepository {
  @override
  Future<Either<Failure, List<PokemonModel>>> fetch(
      {int offset = 0, int limit = 20}) async {
    try {
      final dio = Dio();
      final response =
          await dio.get("$kBaseURL/pokemon?offset=$offset&limit=$limit");
      final list = response.data['results'] as List;
      final urls = list.map((data) => data['url']).toList();
      final pokemons = <PokemonModel>[];
      for (var url in urls) {
        final pokemon = await fetchByUrl(url);
        pokemons.add(pokemon);
      }

      return Right(pokemons);
    } on DioError catch (error) {
      return Left(ApiError(error.message));
    } catch (error) {
      return Left(UnknownError(error.toString()));
    }
  }

  Future<PokemonModel> fetchByUrl(String url) async {
    final dio = Dio();
    final response = await dio.get(url);
    return PokemonModel.fromMap(response.data);
  }
}
