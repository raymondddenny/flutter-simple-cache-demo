import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/usecases/get_local_character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/usecases/get_remote_character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/usecases/update_local_character.dart';

part 'all_character_state.dart';

class AllCharacterCubit extends Cubit<AllCharacterState> {
  final GetRemoteAllCharacterUseCase _remoteAllCharacterUseCase;
  final GetLocalAllCharacterUseCase _localAllCharacterUseCase;
  final UpdateLocalAllCharacterUseCase _updateLocalAllCharacterUseCase;
  final Connectivity _connectivity;
  AllCharacterCubit(
    this._remoteAllCharacterUseCase,
    this._localAllCharacterUseCase,
    this._updateLocalAllCharacterUseCase,
    this._connectivity,
  ) : super(const AllCharacterLoading());

  Future<void> getAllCharacters() async {
    final connectivityStatus = await _connectivity.checkConnectivity();

    if (connectivityStatus == ConnectivityResult.none) {
      await getLocalAllCharacters();
    } else {
      await getRemoteAllCharacters();
    }
  }

  Future<void> getRemoteAllCharacters() async {
    try {
      emit(const AllCharacterLoading());
      final result = await _remoteAllCharacterUseCase();
      emit(AllCharacterRemoteLoaded(result));
    } catch (e) {
      debugPrint("Error cubit -> $e");
      // get local data
      if (e.toString().contains("No")) {
        // NO internet connection
        debugPrint("called local data");
        Future.delayed(const Duration(milliseconds: 500), () async {
          final localData = await _localAllCharacterUseCase();
          emit(AllCharacterLocalLoaded(localData));
        });
      } else {
        emit(AllCharacterError(e.toString()));
      }
    }
  }

  Future<void> getLocalAllCharacters() async {
    try {
      emit(const AllCharacterLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final result = await _localAllCharacterUseCase();
      emit(AllCharacterLocalLoaded(result));
    } catch (e) {
      emit(AllCharacterError(e.toString()));
    }
  }

  Future<void> updateLocalAllCharacter({required CharacterModel characterData}) async {
    try {
      _updateLocalAllCharacterUseCase(data: characterData);
      emit(const AllCharacterLocalSynced());
    } catch (e) {
      emit(AllCharacterError(e.toString()));
    }
  }
}
