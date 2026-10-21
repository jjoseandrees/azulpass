// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Este Provider se encarga de pedir los datos al Caso de Uso.
/// Al ser un @riverpod que retorna un Future, Riverpod maneja
/// automáticamente los estados: loading, data y error.

@ProviderFor(matches)
final matchesProvider = MatchesProvider._();

/// Este Provider se encarga de pedir los datos al Caso de Uso.
/// Al ser un @riverpod que retorna un Future, Riverpod maneja
/// automáticamente los estados: loading, data y error.

final class MatchesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MatchEntity>>,
          List<MatchEntity>,
          FutureOr<List<MatchEntity>>
        >
    with
        $FutureModifier<List<MatchEntity>>,
        $FutureProvider<List<MatchEntity>> {
  /// Este Provider se encarga de pedir los datos al Caso de Uso.
  /// Al ser un @riverpod que retorna un Future, Riverpod maneja
  /// automáticamente los estados: loading, data y error.
  MatchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'matchesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$matchesHash();

  @$internal
  @override
  $FutureProviderElement<List<MatchEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MatchEntity>> create(Ref ref) {
    return matches(ref);
  }
}

String _$matchesHash() => r'60d9e1579272a7fbdde893f93e03e302704eb056';
