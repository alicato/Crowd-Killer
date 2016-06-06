package
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.*;
	import Player;
	
	/**
	 * ...
	 * @author Jito
	 */
	[SWF(width = "512", height = "384", frameRate = '60')]
	public class Main extends Sprite
	{
		public static const RANGLEMAX:uint = 8;
		
		private var _p1:Player;
		private var _p2:Player;
		private var _rs:Number = 1.5;
		private var _crowdDisplay:Vector.<DisplayObject>;
		private var _crowdObject:Vector.<Personnage>;
		private var title:GameMenu;
		private var ambientSound:Sound;
		
		public function Main()
		{
			if (stage)
			{
				ambientSound = new Sound();
				ambientSound.addEventListener(Event.COMPLETE, onSoundLoaded);
				ambientSound.addEventListener(IOErrorEvent.IO_ERROR, onSoundLoadError);
				ambientSound.load(new URLRequest("sound/brouhaha.mp3"));
				init();
			}
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function playSound(s:Sound):void
		{
			var channel:SoundChannel = s.play();
			var transform:SoundTransform = new SoundTransform();
			transform.volume = .05;
			channel.soundTransform = transform;
			channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		
		private function onSoundLoaded(e:Event):void
		{
			playSound(Sound(e.target));
		}

		private function onComplete(e:Event):void
		{
			SoundChannel(e.target).removeEventListener(e.type, onComplete);
			playSound(ambientSound);
			addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		
		private function onSoundLoadError(e:IOErrorEvent):void
		{
			trace(e.text);
		}
		
		public function init(e:Event = null):void
		{
			removeListeners();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.removeChildren();
			title = new GameMenu(this);
			
			title.startButton.addEventListener(MouseEvent.CLICK, game);
		}
		
		public function removeListeners():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
			stage.removeEventListener(Event.ENTER_FRAME, evtStageEnterFrame);
		}
		
		private function game(e:MouseEvent):void
		{
			this.removeChildren();
			
			var p2configground:Shape = new Shape();
			
			p2configground.graphics.beginFill(0xd68947, 1);
			p2configground.graphics.drawRect(0, 0, 512, 384);
			p2configground.graphics.endFill();
			this.addChild(p2configground);
			
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0x404040, 1);
			border.graphics.drawRect(GameEntity.BORDERSIZE, 0, GameEntity.WINDOWWIDTH - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE);
			border.graphics.drawRect(GameEntity.WINDOWWIDTH - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE, GameEntity.BORDERSIZE, GameEntity.WINDOWHEIGHT - GameEntity.BORDERSIZE);
			border.graphics.drawRect(0, GameEntity.WINDOWHEIGHT - GameEntity.BORDERSIZE, GameEntity.WINDOWWIDTH - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE);
			border.graphics.drawRect(0, 0, GameEntity.BORDERSIZE, GameEntity.WINDOWHEIGHT - GameEntity.BORDERSIZE);
			border.graphics.endFill();
			addChild(border);
			
			_crowdObject = new Vector.<Personnage>();
			for (var i:int = 0; i < 30; ++i)
			{
				var tmp:PNJ = new PNJ(this);
				_crowdObject.push(tmp);
			}
			_p1 = new Player(this);
			_p2 = new Player(this, false);
			_crowdObject.push(_p1);
			_crowdObject.push(_p2);
			
			_crowdDisplay = new Vector.<DisplayObject>();
			for (i = 0; i < this.numChildren; i++)
				if (this.getChildAt(i) is DisplayObject)
					_crowdDisplay.push(this.getChildAt(i));
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
			stage.addEventListener(Event.ENTER_FRAME, evtStageEnterFrame);
		}
		
		private function onKeyboardDown(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
			case (Keyboard.ESCAPE): 
				init();
				break;
			default: 
				_p1.updateMoveDown(event);
				_p2.updateMoveDown(event);
				break;
			}
		}
		
		private function onKeyboardUp(event:KeyboardEvent):void
		{
			_p1.updateMoveUp(event);
			_p2.updateMoveUp(event);
		}
		
		private function evtStageEnterFrame(ev:Event):void
		{
			_crowdDisplay.sort(sorty);
			
			for (var i:int = 2; i < _crowdDisplay.length; i++)
			{ //USELESS FOR NOW
				this.setChildIndex(_crowdDisplay[i], i);
			}
			
			var currentShurikens:Vector.<Shuriken> = new Vector.<Shuriken>();
			var invert:Boolean = false;
			
			for (var n:int = 0; n < _crowdObject.length; ++n)
			{
				if (!invert && _crowdObject[n].alive && (_crowdObject[n].img.rotation >= Main.RANGLEMAX || _crowdObject[n].img.rotation <= -Main.RANGLEMAX))
				{
					invert = true;
					_rs = -_rs;
				}
				if (_crowdObject[n].alive)
				{
					_crowdObject[n].move();						// Déplacement des personnages
					if (_crowdObject[n].moveShuriken())			// Déplacement des éventuels shurikens
						currentShurikens.push(_crowdObject[n].shuriken);
					_crowdObject[n].img.rotation += _rs;		// Légère animation des personnages
				}
			}
			
			for each (var shuriken:Shuriken in currentShurikens)
			{
				var hitPers:Vector.<Personnage> = new Vector.<Personnage>();
				for each (var pers:Personnage in _crowdObject)
				{
					if (shuriken.owner == pers || !pers.alive)
						continue;
					if (shuriken.hitTestObject(pers.img))
						hitPers.push(pers);
				}
				
				var toKill:Personnage;
				for each (var canDie:Personnage in hitPers)
				{
					switch (shuriken.dir)
					{
					case (Shuriken.LEFTDIR): 
						if (!toKill || canDie.img.x > toKill.img.x)
							toKill = canDie;
						break;
					case (Shuriken.RIGHTDIR): 
						if (!toKill || canDie.img.x < toKill.img.x)
							toKill = canDie;
						break;
					}
				}
				if (toKill)
				{
					shuriken.owner.deleteShuriken();
					toKill.die();
					if (toKill is Player)
						title.endgame(toKill == _p1);
				}
			}
		}
		
		public function sorty(a:DisplayObject, b:DisplayObject):int
		{
			var ay:int = (a.name == "Alive") ? a.y : a.y - Personnage.PHEIGHT;
			var by:int = (b.name == "Alive") ? b.y : b.y - Personnage.PHEIGHT;
			if (ay > by) return 1;
			if (ay < by) return -1;
			return 0;
		}
	}

}