import 'package:flutter_atm/features/atm/data/providers/atm_fake_provider_impl.dart';
import 'package:flutter_atm/features/atm/data/repositories/atm_repository_impl.dart';
import 'package:flutter_atm/features/atm/domain/providers/atm_fake_provider.dart';
import 'package:get_it/get_it.dart';

import 'features/atm/data/models/bank_cell.dart';
import 'features/atm/domain/repositories/atm_repository.dart';
import 'features/atm/presentation/bloc/atm_bloc.dart';

// Global variable for use
final sl = GetIt.I;

/// DI container
Future<void> init() async {
  // Blocs
  sl.registerLazySingleton(() => AtmBloc(
    atmRepository: sl()
  ));

  // Providers
  sl.registerLazySingleton<AtmFakeProvider>(() => AtmFakeProviderImpl(
      balance: [
        BankCell(count: 50, denomination: 100),
        BankCell(count: 100, denomination: 200),
        BankCell(count: 5, denomination: 500),
        BankCell(count: 10, denomination: 1000),
        BankCell(count: 100, denomination: 2000),
        BankCell(count: 10, denomination: 5000),
      ]));

  // Repositories
  sl.registerLazySingleton<AtmRepository>(
      () => AtmRepositoryImpl(atmProvider: sl()));
}
