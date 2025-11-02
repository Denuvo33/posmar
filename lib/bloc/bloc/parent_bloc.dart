import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'parent_event.dart';
part 'parent_state.dart';

class ParentBloc extends Bloc<ParentEvent, ParentState> {
  ParentBloc() : super(ParentInitial()) {
    on<ParentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
