import 'package:event_bus/event_bus.dart';


class EventBusUtil{

  static EventBus? _eventBus;

  static EventBus? getIntance(){
    _eventBus ??= EventBus();
    return _eventBus;
  }



}