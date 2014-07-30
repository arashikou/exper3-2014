package;

import haxe.ds.Vector;

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

class Event
{
  public var action(default, null):SimulationStatus -> String;
  public var options(default, null):Vector<Option>;

  public function new(vAction:SimulationStatus -> String, ?vOptions:Array<Option>)
  {
    action = vAction;
    if (vOptions == null)
      options = new Vector<Option>(0);
    else
      options = Vector.fromArrayCopy(vOptions);
  }
}