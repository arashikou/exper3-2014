package;

typedef Event = SimulationStatus -> EventResult;

class EventResult
{
  public var message(default, null):String;
  public var options(default, null):Array<Option>;

  public function new(vMessage:String, ?vOptions:Array<Option>)
  {
    message = vMessage;
    if (vOptions == null)
      options = defaultOptions;
    else
      options = vOptions;
  }

  static private var defaultOptions =
  [
    new Option("Continue", HubState)
  ];
}

class Option
{
  public var text(default, null):String;
  public var nextEvent(default, null):Event;
  public var nextState(default, null):Class<SimulationState>;

  public function new(vText:String, ?vNextEvent:Event, ?vNextState:Class<SimulationState>)
  {
    text = vText;
    nextEvent = vNextEvent;
    nextState = vNextState;
  }
}
