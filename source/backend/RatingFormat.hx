package backend;

class RatingFormat 
{
    //Rating Format Shit...
	private static var fFormat = new FlxTextFormat(0xFFFF0000, false);
	private static var eFormat = new FlxTextFormat(0xFFFF7011, false);
	private static var dFormat = new FlxTextFormat(0xFFFFAF1B, false);
	private static var cFormat = new FlxTextFormat(0xFFFFDA38, false);
	private static var bFormat = new FlxTextFormat(0xFFFFFB00, false);
	private static var aFormat = new FlxTextFormat(0xFF6FFF1C, false);
	private static var sFormat = new FlxTextFormat(0xFF00FFF2, false);
	private static var ssFormat = new FlxTextFormat(0xFF47B5FF, false);
	private static var pFormat = new FlxTextFormat(0xFFDD35FF, false);

	public static var fForm = new FlxTextFormatMarkerPair(fFormat, "<");
	public static var eForm = new FlxTextFormatMarkerPair(eFormat, ">");
	public static var dForm = new FlxTextFormatMarkerPair(dFormat, "#");
	public static var cForm = new FlxTextFormatMarkerPair(cFormat, "&");
	public static var bForm = new FlxTextFormatMarkerPair(bFormat, "@");
	public static var aForm = new FlxTextFormatMarkerPair(aFormat, "?");
	public static var sForm = new FlxTextFormatMarkerPair(sFormat, "ł");
    public static var ssForm = new FlxTextFormatMarkerPair(ssFormat, "đ");
    public static var pForm = new FlxTextFormatMarkerPair(pFormat, "Đ");
}