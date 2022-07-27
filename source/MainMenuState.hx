package;

import openfl.system.System;
import flixel.util.FlxTimer;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	var optionShit:Array<String> = [
		'start',
		'extra start',
		'freeplay',
		'music room',
		'credits',
		'shoutouts',
		'option',
		'quit'
	];

	var magenta:FlxSprite;
	var logo:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/menu_bg'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		logo = new FlxSprite(800, -20);
		logo.scale.set(0.55, 0.55);
		logo.frames = Paths.getSparrowAtlas('titlemenu/title_screen_eng');
		logo.animation.addByPrefix('logo', 'logo bumpin0000', 24);
		logo.animation.play('logo');
		logo.scrollFactor.set();
		logo.updateHitbox();
		logo.alpha = 1;
		logo.antialiasing = ClientPrefs.globalAntialiasing;
		add(logo);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set();
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		// add(magenta);

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		var tex = Paths.getSparrowAtlas('mainmenu/menu_items');
		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);

			switch (i)
			{
				case 0:
					FlxTween.tween(menuItem, {x: 835 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 1:
					FlxTween.tween(menuItem, {x: 885 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 2:
					FlxTween.tween(menuItem, {x: 855 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 3:
					FlxTween.tween(menuItem, {x: 825 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 4:
					FlxTween.tween(menuItem, {x: 795 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 5:
					FlxTween.tween(menuItem, {x: 855 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 6:
					FlxTween.tween(menuItem, {x: 935 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
					});
				case 7:
					FlxTween.tween(menuItem, {x: 885 + (i * 0.25), y: 280 + (i * 50)}, 1 + (i * 0.25), {
						ease: FlxEase.expoInOut
						/*
							onComplete: function(flxTween:FlxTween)
							{
								new FlxTimer().start(0.25, function(tmr:FlxTimer)
								{
									canMove = true;
									canClick = true;
									finishedFunnyMove = true;
									changeItem();
								});
							}
						 */
					});
			}

			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			// menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			// menuItem.scale.set(0.8, 0.8);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = FlxG.save.data.antialiasing;
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem(0, true);

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
		{
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
			{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement()
	{
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				switch (optionShit[curSelected])
				{
					default:
						trace('dont bother lol');
					case 'start' | 'freeplay' | 'credits' | 'option' | 'quit':
						acceptedSomethin(optionShit[curSelected]);
				}
			}

			if (FlxG.keys.justPressed.F7)
				MusicBeatState.switchState(new ThanksForPlaying());
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		/*
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.screenCenter(X);
			});
		 */
	}

	function acceptedSomethin(option:String)
	{
		selectedSomethin = true;
		FlxG.sound.play(Paths.sound('confirmMenu'));

		/*
			if (ClientPrefs.flashing)
				FlxFlicker.flicker(magenta, 1.1, 0.15, false);
		 */

		menuItems.forEach(function(spr:FlxSprite)
		{
			if (curSelected != spr.ID)
			{
				FlxTween.tween(spr, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						spr.kill();
					}
				});
			}
			else
			{
				FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					switch (option)
					{
						case 'start':
							MusicBeatState.switchState(new StoryMenuState());
						case 'freeplay':
							MusicBeatState.switchState(new FreeplayState());
						case 'credits':
							MusicBeatState.switchState(new CreditsState());
						case 'option':
							LoadingState.loadAndSwitchState(new options.OptionsState());
						case 'quit':
							System.exit(0);
					}
				});
			}
		});
	}

	function changeItem(huh:Int = 0, ?initialize:Bool = false)
	{
		if (!initialize)
		{
			var unBlocked:Array<String> = ['start', 'freeplay', 'credits', 'option', 'quit'];

			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

			if (unBlocked.contains(optionShit[curSelected]) == false && optionShit[curSelected] != null)
				curSelected += huh; // do it again to skip through items and make sure its not null to overskip
		}
		else
			curSelected = 0;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.alpha = 1;
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
				spr.centerOffsets();
			}
			else
				spr.alpha = 0.4;
		});
	}
}
