import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caching_demo_app/injector_container.dart';
import 'package:flutter_caching_demo_app/simple_cache/data/charatacter/character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/local_character_repository.dart';
import 'package:flutter_caching_demo_app/simple_cache/presentation/bloc/cubit/all_character_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Characters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AllCharactedPage(),
    );
  }
}

class AllCharactedPage extends StatelessWidget {
  const AllCharactedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Set a background color for the Scaffold
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://rickandmortyapi.com/api/character/avatar/99.jpeg', // Add the funky feature image URL
              fit: BoxFit.cover, // Make the image cover the full width
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 16), // Add some spacing between the image and the title
            const Text(
              'All Characters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: BlocConsumer<AllCharacterCubit, AllCharacterState>(
                listener: (context, state) {
                  if (state is AllCharacterRemoteLoaded) {
                    sl<LocalCharacterRepository>().updateLocalCharacter(state.characterModel);
                  }
                },
                builder: (context, state) {
                  if (state is AllCharacterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(), // Use a circular progress indicator
                    );
                  }

                  if (state is AllCharacterRemoteLoaded) {
                    return ListItems(data: state.characterModel);
                  }

                  if (state is AllCharacterLocalLoaded) {
                    return ListItems(data: state.characterModel);
                  }

                  if (state is AllCharacterError) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView ListItems({required CharacterModel data}) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemCount: data.results.length,
      itemBuilder: (context, index) {
        final dataToShow = data.results[index];
        return CharacterCard(
          imageUrl: dataToShow.image,
          name: dataToShow.name,
          status: dataToShow.status,
          species: dataToShow.species,
        );
      },
    );
  }
}

class CharacterCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String status;
  final String species;

  const CharacterCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 200,
                width: 200,
              )),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Status: $status',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
          Text(
            'Species: $species',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
