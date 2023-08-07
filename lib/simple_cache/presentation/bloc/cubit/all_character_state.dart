part of 'all_character_cubit.dart';

@immutable
class AllCharacterState extends Equatable {
  final CharacterModel characterModel;
  final String errorMessage;
  const AllCharacterState({
    this.characterModel = const CharacterModel(results: []),
    this.errorMessage = '',
  });
  @override
  List<Object?> get props => [characterModel, errorMessage];
}

class AllCharacterLoading extends AllCharacterState {
  const AllCharacterLoading();
}

class AllCharacterError extends AllCharacterState {
  const AllCharacterError(String errorMessage) : super(errorMessage: errorMessage);
}

class AllCharacterRemoteLoaded extends AllCharacterState {
  const AllCharacterRemoteLoaded(CharacterModel characterModel) : super(characterModel: characterModel);
}

class AllCharacterLocalLoaded extends AllCharacterState {
  const AllCharacterLocalLoaded(CharacterModel characterModel) : super(characterModel: characterModel);
}

class AllCharacterLocalSynced extends AllCharacterState {
  const AllCharacterLocalSynced();
}
