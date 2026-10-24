// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(catalog)
final catalogProvider = CatalogProvider._();

final class CatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductEntity>>,
          List<ProductEntity>,
          FutureOr<List<ProductEntity>>
        >
    with
        $FutureModifier<List<ProductEntity>>,
        $FutureProvider<List<ProductEntity>> {
  CatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductEntity>> create(Ref ref) {
    return catalog(ref);
  }
}

String _$catalogHash() => r'c119e6053f2a0684edf2ff5ec1bab7394289e934';
