import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/remote_character_repository.dart';

class GetRemoteAllCharacterUseCase {
  final RemoteCharacterRepository _remoteCharacterRepository;

  GetRemoteAllCharacterUseCase(this._remoteCharacterRepository);

  Future<CharacterModel> call() async {
    return await _remoteCharacterRepository.getAllCharacters();
  }
}
