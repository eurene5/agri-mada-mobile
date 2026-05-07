// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'9b38b0605ab233f33b0ff939edd1100331a746fa';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
String _$journalLocalDatasourceHash() =>
    r'd15d6c6884a9ce8d58c0c871b419489a1744310b';

/// See also [journalLocalDatasource].
@ProviderFor(journalLocalDatasource)
final journalLocalDatasourceProvider =
    AutoDisposeFutureProvider<JournalLocalDatasource>.internal(
  journalLocalDatasource,
  name: r'journalLocalDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalLocalDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JournalLocalDatasourceRef
    = AutoDisposeFutureProviderRef<JournalLocalDatasource>;
String _$journalRepositoryHash() => r'20171e7845fac8a4a7fd1b1bc6867c971f9b217b';

/// See also [journalRepository].
@ProviderFor(journalRepository)
final journalRepositoryProvider =
    AutoDisposeFutureProvider<JournalRepository>.internal(
  journalRepository,
  name: r'journalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JournalRepositoryRef = AutoDisposeFutureProviderRef<JournalRepository>;
String _$getJournalEntriesUseCaseHash() =>
    r'8ca6d1c63395869a19f741cc9c5e7fbe078d5a6b';

/// See also [getJournalEntriesUseCase].
@ProviderFor(getJournalEntriesUseCase)
final getJournalEntriesUseCaseProvider =
    AutoDisposeFutureProvider<GetJournalEntriesUseCase>.internal(
  getJournalEntriesUseCase,
  name: r'getJournalEntriesUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getJournalEntriesUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetJournalEntriesUseCaseRef
    = AutoDisposeFutureProviderRef<GetJournalEntriesUseCase>;
String _$saveJournalEntryUseCaseHash() =>
    r'733909144ac862860d85e8d3b41820079aa598f4';

/// See also [saveJournalEntryUseCase].
@ProviderFor(saveJournalEntryUseCase)
final saveJournalEntryUseCaseProvider =
    AutoDisposeFutureProvider<SaveJournalEntryUseCase>.internal(
  saveJournalEntryUseCase,
  name: r'saveJournalEntryUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveJournalEntryUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SaveJournalEntryUseCaseRef
    = AutoDisposeFutureProviderRef<SaveJournalEntryUseCase>;
String _$journalNotifierHash() => r'b9ab0ef9a25e4d30a2ad6308cd6428462c65c93a';

/// See also [JournalNotifier].
@ProviderFor(JournalNotifier)
final journalNotifierProvider =
    AutoDisposeNotifierProvider<JournalNotifier, JournalState>.internal(
  JournalNotifier.new,
  name: r'journalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalNotifier = AutoDisposeNotifier<JournalState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
