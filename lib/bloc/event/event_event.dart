part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class OnSelectEvent extends EventEvent {

  final EventModel event;

  OnSelectEvent(this.event);

}
