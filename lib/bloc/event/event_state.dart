part of 'event_bloc.dart';

class EventState {
  final EventModel? selectEvent;

  const EventState({
    this.selectEvent
  });
  
  EventState copyWith({
    EventModel? selectEvent

  }) => EventState(
    selectEvent: selectEvent ?? this.selectEvent
  );

  @override
  List<Object?> get props => [ selectEvent ];
}