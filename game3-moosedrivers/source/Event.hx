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
      options = [];
    else
      options = vOptions;
  }
}

class Option
{
  public var text(default, null):String;
  public var next(default, null):Event;

  public function new(vText:String, vNext:Event)
  {
    text = vText;
    next = vNext;
  }
}
