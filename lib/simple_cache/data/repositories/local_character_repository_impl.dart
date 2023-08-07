import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/local_character_repository.dart';
import 'package:path_provider/path_provider.dart';

class LocalCharacterRepositoryImpl extends LocalCharacterRepository {
  LocalCharacterRepositoryImpl();

  @override
  Future<CharacterModel> getAllCharacters() async {
    try {
      String fileName = "localdb.json";

      final dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName");

      // if (file.existsSync()) {
      debugPrint("Reading from local device cache");

      //read from the cache
      final dataCached = file.readAsStringSync();
      final Map<String, dynamic> jsonData = jsonDecode(dataCached);

      // Use the factory constructor to create CharacterModel from the JSON data
      final response = CharacterModel.fromJson(jsonData);
      return response;
      // }
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

  @override
  Future<void> updateLocalCharacter(CharacterModel characterModel) async {
    String fileName = "localdb.json";

    final dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$fileName");

    final jsonData = characterModel.toJson();
    final jsonString = jsonEncode(jsonData);

    // save to local
    file.writeAsStringSync(jsonString, flush: true, mode: FileMode.write);

    debugPrint("Saved to local device cache");

    // read

    if (file.existsSync()) {
      final dataCached = file.readAsStringSync();
      final Map<String, dynamic> jsonData = jsonDecode(dataCached);

      // Use the factory constructor to create CharacterModel from the JSON data
      final decode = CharacterModel.fromJson(jsonData);

      debugPrint("decode data -> $decode");
      debugPrint("Data available in local cache");
    }
  }
}
