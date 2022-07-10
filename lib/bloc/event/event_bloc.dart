import 'package:bloc/bloc.dart';
import 'package:controlador/bloc/user/user_bloc.dart';
import 'package:controlador/models/detailsTicket.dart';
import 'package:controlador/models/eventModel.dart';
import 'package:controlador/models/models.dart';
import 'package:controlador/services/event_service.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {

  final UserBloc userBloc;
  List<EventModel>? eventModel;
  DetailsTicketModel? detailsTicketModel;
  ErrorResponse? error;

  bool isResult = false;

  final eventService = EventService();


  EventBloc({required this.userBloc}) : super(const EventState()) {
    on<EventEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnSelectEvent>((event, emit){
      print(event.event);
      emit(state.copyWith(selectEvent: event.event));
    });
  }

  Future getEvent() async{

    final _storage = userBloc.storage;
    final token = await _storage.read(key: 'token') ?? '';

    Response resp = await eventService.getEvent(token);

    if (resp.statusCode == 200){
      final eventData = eventModelFromJson(resp.body);
      eventModel = eventData;

      return true;
    }else{
      final errorResponse = errorResponseFromJson(resp.body);
      error = errorResponse;
      return false;
    }

  }

  Future scanQR(String codeTicket) async{

    final _storage = userBloc.storage;
    final token = await _storage.read(key: 'token') ?? '';

    if (state.selectEvent != null){
      Response resp = await eventService.scanQR(token, codeTicket, state.selectEvent!.idubicacion, state.selectEvent!.idhorario);

      if (resp.statusCode == 200){

        final detailsTicketModel = detailsTicketModelFromJson(resp.body);

        this.detailsTicketModel = detailsTicketModel;

        return true;
      }else{
      
        if (resp.statusCode != 500){
          final errorResponse = errorResponseFromJson(resp.body);
          error = errorResponse;
        }
        return false;
      }
    
    }else{
      return false;
    }


  }
  
  Future registerTicket() async{

    final _storage = userBloc.storage;
    final token = await _storage.read(key: 'token') ?? '';

    if (state.selectEvent != null){
      Response resp = await eventService.registerTicket(token, detailsTicketModel!.ticket, state.selectEvent!.idubicacion, state.selectEvent!.idhorario);

      if (resp.statusCode == 200){
        return true;
      }else{

          print(resp.body);
        if (resp.statusCode != 500){
          final errorResponse = errorResponseFromJson(resp.body);
          error = errorResponse;
        }
        
             
        
        return false;
      }
    
    }else{

      error = ErrorResponse(message: 'No se a seleccionado un evento', status: 404);
      return false;
    }


  }

}
