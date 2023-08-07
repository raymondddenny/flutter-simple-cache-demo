import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/local_character_repository.dart';

class GetLocalAllCharacterUseCase {
  final LocalCharacterRepository _localCharacterRepository;

  GetLocalAllCharacterUseCase(this._localCharacterRepository);

  Future<CharacterModel> call() async {
    return await _localCharacterRepository.getAllCharacters();
  }
}
