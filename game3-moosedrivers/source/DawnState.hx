package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;

class DawnState extends SimulationState
{
  override public function create():Void
  {
    var saveData = new FlxSave();
    saveData.bind(Constants.saveName);
    _status.save(saveData);
    saveData.close();

    var night = new FlxSprite("assets/images/Night.png");
    night.x = (FlxG.width - night.width) / 2;
    night.y = (FlxG.height - night.height) / 2;
    add(night);

    var dawn = new FlxSprite("assets/images/Dawn.png");
    dawn.x = night.x;
    dawn.y = night.y;
    dawn.alpha = 0;
    add(dawn);

    var tween = FlxTween.tween(dawn, {alpha: 1}, 6, {complete:tweenDone});
  }

  private function tweenDone(Tween:FlxTween):Void
  {
    FlxG.switchState(new HubState(_status));
  }
}
