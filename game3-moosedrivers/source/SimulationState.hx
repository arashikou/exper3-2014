package;

import flixel.FlxState;

class SimulationState extends FlxState
{
  private var _status:SimulationStatus;

  public function new(status:SimulationStatus)
  {
    super();
    _status = status;
  }
}
