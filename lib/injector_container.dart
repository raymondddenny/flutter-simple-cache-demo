import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_caching_demo_app/core/services/api_services.dart';
import 'package:flutter_caching_demo_app/simple_cache/data/repositories/local_character_repository_impl.dart';
import 'package:flutter_caching_demo_app/simple_cache/data/repositories/remote_character_repository_impl.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/local_character_repository.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/repositories/remote_character_repository.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/usecases/get_local_character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/usecases/get_remote_character.dart';
import 'package:flutter_caching_demo_app/simple_cache/domain/usecases/update_local_character.dart';
import 'package:flutter_caching_demo_app/simple_cache/presentation/bloc/cubit/all_character_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // HTTP
  sl.registerSingleton<Client>(Client());

  // Connectivity
  sl.registerSingleton<Connectivity>(Connectivity());

  // Dependencies
  sl.registerSingleton<ApiServices>(ApiServices(sl()));

  sl.registerSingleton<RemoteCharacterRepository>(RemoteCharacterRepositoryImpl(sl()));
  sl.registerSingleton<LocalCharacterRepository>(LocalCharacterRepositoryImpl());

  // Use Cases
  sl.registerSingleton<GetLocalAllCharacterUseCase>(GetLocalAllCharacterUseCase(sl()));
  sl.registerSingleton<GetRemoteAllCharacterUseCase>(GetRemoteAllCharacterUseCase(sl()));
  sl.registerSingleton<UpdateLocalAllCharacterUseCase>(UpdateLocalAllCharacterUseCase(sl()));

  // Blocs
  sl.registerFactory<AllCharacterCubit>(() => AllCharacterCubit(sl(), sl(), sl(), sl()));
}
