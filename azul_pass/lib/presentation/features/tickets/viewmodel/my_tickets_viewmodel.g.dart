// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tickets_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myTickets)
final myTicketsProvider = MyTicketsProvider._();

final class MyTicketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TicketEntity>>,
          List<TicketEntity>,
          FutureOr<List<TicketEntity>>
        >
    with
        $FutureModifier<List<TicketEntity>>,
        $FutureProvider<List<TicketEntity>> {
  MyTicketsProvider._()
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
  String debugGetCreateSourceHash() => _$myTicketsHash();

  @$internal
  @override
  $FutureProviderElement<List<TicketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TicketEntity>> create(Ref ref) {
    return myTickets(ref);
  }
}

String _$myTicketsHash() => r'f9cd6ba41078c640e2a62597b51386df37371a6e';
