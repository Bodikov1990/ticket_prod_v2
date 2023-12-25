import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'repertoire_event.dart';
part 'repertoire_state.dart';

class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  RepertoireBloc() : super(RepertoireInitial()) {
    on<RepertoireEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
