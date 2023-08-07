import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';

abstract class RemoteCharacterRepository {
  Future<CharacterModel> getAllCharacters();
  Future<List<CharacterModel>> getCharactersByPage(int page);
  Future<List<CharacterModel>> getCharactersByQuery(String query);
  Future<CharacterModel> getCharacterById(int id);
}
