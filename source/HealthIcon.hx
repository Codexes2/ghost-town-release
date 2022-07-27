package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public var losingIndex:Int = -1;
	public var neutralIndex:Int = 0;
	public var winningIndex:Int = -1;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon()
	{
		if (isOldIcon = !isOldIcon)
			changeIcon('bf-old');
		else
			changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];

	public function changeIcon(char:String)
	{
		if (this.char != char)
		{
			var name:String = 'icons/' + char;
			if (!Paths.fileExists('images/' + name + '.png', IMAGE))
				name = 'icons/icon-' + char; // Older versions of psych engine's support
			if (!Paths.fileExists('images/' + name + '.png', IMAGE))
				name = 'icons/icon-face'; // Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);
			var frames:Array<Int> = [];

			loadGraphic(file); // Load stupidly first for getting the file size

			for (i in 0...Math.floor(width / 150))
				frames.push(i);

			loadGraphic(file, true, 150, 150);

			switch (frames.length)
			{
				case 2:
					neutralIndex = 0;
					losingIndex = 1;
				case 3:
					losingIndex = 1;
					neutralIndex = 0;
					winningIndex = 2;
			}

			antialiasing = ClientPrefs.globalAntialiasing;
			animation.add(char, frames, 0, isPlayer);
			animation.play(char, true);
			this.char = char;

			if (animation.curAnim != null)
				animation.curAnim.curFrame = 0;

			iconOffsets[0] = (width - 150) / 2;
			iconOffsets[1] = (width - 150) / 2;
			updateHitbox();

			/*
				animation.add(char, [0, 1], 0, false, isPlayer);
				animation.play(char);


				if (char.endsWith('-pixel'))
				{
					antialiasing = false;
				}
			 */
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String
	{
		return char;
	}
}
