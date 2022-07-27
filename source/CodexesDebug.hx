package;

/**
 * My personal debugging class.
 * Before you ask any questions, let me answer a few obvious ones here for you:
 * 1) No, I don't know how this works, and
 * 2) No, you're not allowed to touch it. ~Codexes
 */
class CodexesDebug
{
	public static function turnToFloat():Array<Float>
	{
		var debugShit:Array<String> = CoolUtil.coolTextFile(Paths.txt("debug"));
		var floatArray:Array<Float> = [];
		for (shit in debugShit)
			floatArray.push(Std.parseFloat(shit));

		return floatArray;
	}

	public static function turnToInt():Array<Int>
	{
		var debugShit:Array<String> = CoolUtil.coolTextFile(Paths.txt("debug"));
		var intArray:Array<Int> = [];
		for (shit in debugShit)
			intArray.push(Std.parseInt(shit));

		return intArray;
	}
}
