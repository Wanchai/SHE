package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("img/space-back.png", nme.NME_img_space_back_png);
			type.set ("img/space-back.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/space-ball.png", nme.NME_img_space_ball_png);
			type.set ("img/space-ball.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/space-obs1.png", nme.NME_img_space_obs1_png);
			type.set ("img/space-obs1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/space-obs2.png", nme.NME_img_space_obs2_png);
			type.set ("img/space-obs2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/space-obs3.png", nme.NME_img_space_obs3_png);
			type.set ("img/space-obs3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/space-set.png", nme.NME_img_space_set_png);
			type.set ("img/space-set.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/lib.swf", nme.NME_assets_lib_swf);
			type.set ("assets/lib.swf", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("audio/clap.mp3", nme.NME_audio_clap_mp3);
			type.set ("audio/clap.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("audio/jump.mp3", nme.NME_audio_jump_mp3);
			type.set ("audio/jump.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("audio/lol.mp3", nme.NME_audio_lol_mp3);
			type.set ("audio/lol.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("audio/music.mp3", nme.NME_audio_music_mp3);
			type.set ("audio/music.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("audio/wack.mp3", nme.NME_audio_wack_mp3);
			type.set ("audio/wack.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("libraries/lib.swf", nme.NME_libraries_lib_swf);
			type.set ("libraries/lib.swf", Reflect.field (AssetType, "binary".toUpperCase ()));
			
			library.set ("lib", Reflect.field (LibraryType, "swf".toUpperCase ()));
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_img_space_back_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_space_ball_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_space_obs1_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_space_obs2_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_space_obs3_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_space_set_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lib_swf extends flash.utils.ByteArray { }
class NME_audio_clap_mp3 extends flash.media.Sound { }
class NME_audio_jump_mp3 extends flash.media.Sound { }
class NME_audio_lol_mp3 extends flash.media.Sound { }
class NME_audio_music_mp3 extends flash.media.Sound { }
class NME_audio_wack_mp3 extends flash.media.Sound { }
class NME_libraries_lib_swf extends flash.utils.ByteArray { }
