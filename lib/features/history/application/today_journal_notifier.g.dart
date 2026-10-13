// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_journal_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayJournalNotifierHash() =>
    r'cc0d4f0701f2eae5123170b6b626ad69129f4c6a';

/// Lo de hoy para la tarjeta de Inicio, con estado propio y sin cargar el
/// Diario: una pagina por tipo desde el inicio del dia local.
///
/// Copied from [TodayJournalNotifier].
@ProviderFor(TodayJournalNotifier)
final todayJournalNotifierProvider = AutoDisposeNotifierProvider<
    TodayJournalNotifier, TodayJournalState>.internal(
  TodayJournalNotifier.new,
  name: r'todayJournalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayJournalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodayJournalNotifier = AutoDisposeNotifier<TodayJournalState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
