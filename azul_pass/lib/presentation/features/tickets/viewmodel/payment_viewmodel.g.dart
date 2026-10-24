// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaymentNotifier)
final paymentProvider = PaymentNotifierProvider._();

final class PaymentNotifierProvider
    extends $NotifierProvider<PaymentNotifier, PaymentStatus> {
  PaymentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentNotifierHash();

  @$internal
  @override
  PaymentNotifier create() => PaymentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentStatus>(value),
    );
  }
}

String _$paymentNotifierHash() => r'fc02cbaca87b2b48ff48facbcbf8a55a20ef91de';

abstract class _$PaymentNotifier extends $Notifier<PaymentStatus> {
  PaymentStatus build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PaymentStatus, PaymentStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaymentStatus, PaymentStatus>,
              PaymentStatus,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
