// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tickets_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyTicketsNotifier)
final myTicketsProvider = MyTicketsNotifierProvider._();

final class MyTicketsNotifierProvider
    extends $AsyncNotifierProvider<MyTicketsNotifier, List<TicketEntity>> {
  MyTicketsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myTicketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myTicketsNotifierHash();

  @$internal
  @override
  MyTicketsNotifier create() => MyTicketsNotifier();
}

String _$myTicketsNotifierHash() => r'4a974a8e063652c604b42abdc3de6f3de907c605';

abstract class _$MyTicketsNotifier extends $AsyncNotifier<List<TicketEntity>> {
  FutureOr<List<TicketEntity>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TicketEntity>>, List<TicketEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TicketEntity>>, List<TicketEntity>>,
              AsyncValue<List<TicketEntity>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
