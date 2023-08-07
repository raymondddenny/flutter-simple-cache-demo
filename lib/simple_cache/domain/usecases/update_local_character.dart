import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/local_character_repository.dart';

class UpdateLocalAllCharacterUseCase {
  final LocalCharacterRepository _localCharacterRepository;

  UpdateLocalAllCharacterUseCase(this._localCharacterRepository);

  void call({required CharacterModel data}) async {
    _localCharacterRepository.updateLocalCharacter(data);
  }
}
