package;


import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import motion.Actuate;
import openfl.Assets;


class Main extends Sprite {
	
	
	private var Fill:Sprite;
	
	private var channel:SoundChannel;
	private var position:Float;
	private var sound:Sound;
	
	
	public function new () {
		
		super ();
		
		sound = Assets.getSound ("assets/stars.ogg");
		position = 0;
		
		Fill = new Sprite ();
		Fill.graphics.beginFill (0x3CB878);
		Fill.graphics.drawRect (0, 0, stage.stageWidth, stage.stageHeight);
		Fill.alpha = 0.1;
		Fill.buttonMode = true;
		Fill.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
		addChild (Fill);
		
		play ();
		
	}
	
	
	private function pause ():Void {
		
		if (channel != null) {
			
			position = channel.position;
			channel.removeEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);
			channel.stop ();
			channel = null;
			
		}
		
		Actuate.tween (Fill, 3, { alpha: 0.1 } );
		
	}
	
	
	private function play ():Void {
		
		channel = sound.play (position);
		channel.addEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);
		
		Actuate.tween (Fill, 3, { alpha: 1 } );
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function channel_onSoundComplete (event:Event):Void {
		
		pause ();
		
		position = 0;
		
	}
	
	
	private function this_onMouseDown (event:MouseEvent):Void {
		
		if (channel == null) {
			
			play ();
			
		} else {
			
			pause ();
			
		}
		
	}
	
	
}