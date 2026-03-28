import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'daily_reminder_event.dart';
part 'daily_reminder_state.dart';

class DailyReminderBloc extends Bloc<DailyReminderEvent, DailyReminderState> {
  DailyReminderBloc() : super(DailyReminderInitial()) {
    on<DailyReminderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
