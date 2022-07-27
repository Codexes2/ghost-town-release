package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class ThanksForPlaying extends MusicBeatState
{
	var bgSprite:FlxSprite = null;
	var funnySprite:FlxSprite = null;
	var grpText:FlxTypedGroup<Alphabet> = null;
	var thxStrings:Array<String> = ['Thanks for playing the demo!', 'See you at the full release!'];

	override function create()
	{
		bgSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
		bgSprite.setGraphicSize(1280, 720);
		bgSprite.screenCenter(XY);
		bgSprite.alpha = 0.5;
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(bgSprite);

		funnySprite = new FlxSprite(0, 10).loadGraphic(Paths.image('demo_over'));
		funnySprite.screenCenter(X);
		funnySprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(funnySprite);

		grpText = new FlxTypedGroup<Alphabet>();
		add(grpText);

		for (i in 0...thxStrings.length)
		{
			var daText = new Alphabet(0, 475 + (i * 75), thxStrings[i], true, false, 0.05, 0.8);
			daText.screenCenter(X);
			grpText.add(daText);
		}
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK || controls.ACCEPT)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
	}
}
