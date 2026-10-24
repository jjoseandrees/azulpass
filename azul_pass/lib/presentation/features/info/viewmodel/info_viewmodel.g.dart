// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stadiumInfo)
final stadiumInfoProvider = StadiumInfoProvider._();

final class StadiumInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<StadiumInfoEntity>,
          StadiumInfoEntity,
          FutureOr<StadiumInfoEntity>
        >
    with
        $FutureModifier<StadiumInfoEntity>,
        $FutureProvider<StadiumInfoEntity> {
  StadiumInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stadiumInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stadiumInfoHash();

  @$internal
  @override
  $FutureProviderElement<StadiumInfoEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StadiumInfoEntity> create(Ref ref) {
    return stadiumInfo(ref);
  }
}

String _$stadiumInfoHash() => r'ba5a83f826f9d95188a9b700f3e05ef9c050224d';

@ProviderFor(faqs)
final faqsProvider = FaqsProvider._();

final class FaqsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FaqEntity>>,
          List<FaqEntity>,
          FutureOr<List<FaqEntity>>
        >
    with $FutureModifier<List<FaqEntity>>, $FutureProvider<List<FaqEntity>> {
  FaqsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faqsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faqsHash();

  @$internal
  @override
  $FutureProviderElement<List<FaqEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FaqEntity>> create(Ref ref) {
    return faqs(ref);
  }
}

String _$faqsHash() => r'3f37b54d9fd33d983c141a90cf5daf27a67803a7';
