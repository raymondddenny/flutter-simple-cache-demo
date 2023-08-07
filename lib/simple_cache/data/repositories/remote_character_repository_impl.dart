import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_caching_demo_app/core/services/api_services.dart';
import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/remote_character_repository.dart';

class RemoteCharacterRepositoryImpl extends RemoteCharacterRepository {
  final ApiServices _apiServices;

  RemoteCharacterRepositoryImpl(this._apiServices);

  @override
  Future<CharacterModel> getAllCharacters() async {
    try {
      final response = await _apiServices.getMethod<CharacterModel>(
        queryParams: '/character',
        parser: (json) => CharacterModel.fromJson(json),
      );
      return response;
    } on SocketException {
      debugPrint("Error: No internet connection");
      throw Exception("No internet connection");
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Failed to fetch data");
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) {
    // TODO: implement getCharacterById
    throw UnimplementedError();
  }

  @override
  Future<List<CharacterModel>> getCharactersByPage(int page) {
    // TODO: implement getCharactersByPage
    throw UnimplementedError();
  }

  @override
  Future<List<CharacterModel>> getCharactersByQuery(String query) {
    // TODO: implement getCharactersByQuery
    throw UnimplementedError();
  }
}
