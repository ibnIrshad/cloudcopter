package com.asgamer.helicopter
{

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import com.objects.Cloud1;
	import com.objects.Obstacles;
	import com.objects.Helpers;
	import com.objects.GameOverPopup;
	import flash.display.DisplayObject;
	import com.objects.StartGamePopup;

	public class Engine extends MovieClip
	{
		private var hi:int = 0;//counter
		private var counter:uint = 0;

		//Sounds
		private var bgm:Sound = new bgMusic();
		private var bgmChannel:SoundChannel;
		private var heliSound:heliLoop_sound;
		private var heliChannel:SoundChannel;
		private var explosionSound:exp_sound;


		//Objects
		private var heli:Helicopter;
		public var obstacles:Obstacles;
		private var gameOverPopup:GameOverPopup;
		private var startGamePopup:StartGamePopup;

		public function Engine():void
		{
			bgmChannel = bgm.play();
			startGamePopup = new StartGamePopup  ;
			addChild(startGamePopup);
			startGamePopup.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			addEventListener(Event.ENTER_FRAME, shakeScreen, false, 0, true);
		}

		public function shakeScreen(e:Event)
		{
			shakeObject(startGamePopup);

			//Reset the position once in a while
			if (Helpers.randomNumber(0,10) > 8)
			{
				startGamePopup.x = 14.55;
				startGamePopup.y = 17;
				startGamePopup.rotation = 0;
			}
		}

		public function startGame(e:Event):void
		{
			bgmChannel.stop();
			startGamePopup.removeEventListener(MouseEvent.CLICK, startGame, false);
			removeEventListener(Event.ENTER_FRAME, shakeScreen, false);
			removeChild(startGamePopup);

			//Starts the game by constructing the functionality
			Helpers.engineRef = this;
			heli = new Helicopter(stage);
			obstacles = new Obstacles();
			addChild(heli);
			addChild(obstacles);

			heliSound = new heliLoop_sound();
			explosionSound = new exp_sound();
			playSound();

			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}

		public function loop(e:Event):void
		{
			counter++;
			//Adds to the score every 5 loops
			if (counter % 7 == 0)
			{
				Helpers.score++;
			}
			ui.score_txt.text = String(Helpers.score);

			//Cycles through all the obstacles in the obstacle course (children of the Obstacles class)
			for (var i:uint=0; i<obstacles.numChildren; i++)
			{
				var hitObject = obstacles.getChildAt(i);
				var hitBox;

				//Checks if the object has a hitBox, if not, then uses the object as the hitBox
				if (hitObject.hitBox == null)
				{
					hitBox = hitObject;
				}
				else
				{
					hitBox = hitObject.hitBox;
				}
				//Checks if the heli hit an object's hit box
				if (heli.hitBox.hitTestObject(hitBox))
				{
					hi++;
					trace("hit "+hitObject.name+" "+hi+" times");
					if (hi == 1)
					{
						endGame();
					}
				}
			}

			//Keeps user UI at the top
			setChildIndex(ui, this.numChildren-1);
		}

		public function playSound():void
		{
			heliChannel = heliSound.play();
			heliChannel.addEventListener(Event.SOUND_COMPLETE, loopSound);
		}

		public function loopSound(e:Event):void
		{
			trace("looped heli sound");
			if (heliChannel != null)
			{
				heliChannel.removeEventListener(Event.SOUND_COMPLETE, loopSound);
				playSound();
			}
		}

		public function endGame():void
		{
			Helpers.gameEnded = true;
			removeEventListener(Event.ENTER_FRAME, loop, false);
			obstacles.removeEventListener(Event.ENTER_FRAME, obstacles.loop, false);
			setChildIndex(heli, this.numChildren-1);
			heli.blowUp();
			//Explode the helicopter.;

			explosionSound.play();
			heliChannel.stop();

			gameOverPopup = new GameOverPopup  ;
			addChild(gameOverPopup);
		}

		public function handleRestartBtn(e:Event):void
		{
			restartGame();
		}

		public function restartGame():void
		{
			Helpers.gameEnded = false;

			//Remove old objects
			removeChild(heli);
			removeChild(obstacles);

			removeChild(gameOverPopup);

			bgmChannel = bgm.play();
			startGamePopup = new StartGamePopup  ;
			addChild(startGamePopup);
			startGamePopup.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			addEventListener(Event.ENTER_FRAME, shakeScreen, false, 0, true);

			hi = 0;
			counter = 0;
			Helpers.score = 0;
		}

		public function shakeObject(o:DisplayObject, times:uint = 1, doRotation:Boolean = false):void
		{
			//Rotate the rectangle a random amount  (from -4 to 4) 
			//as many "times" as specified
			for (var i=0; i<=times; i++)
			{
				if (doRotation)
				{
					o.rotation +=  Helpers.randomNumber(-1,1);
				}

				//Assign a new random position
				o.x +=  Helpers.randomNumber(-1,1);
				o.y +=  Helpers.randomNumber(-1,1);
			}
		}

		public function checkHittingObstacle(object:DisplayObject):Boolean
		{
			var hitObject;
			for (var i=0; i<obstacles.numChildren; i++)
			{
				hitObject = obstacles.getChildAt(i);
				if (object.hitTestObject(hitObject))
				{
					return true;
					//numObjectsHit++;
					//trace("cloud is touching "+hitObject.name+" #:"+numObjectsHit);
					break;
				}
			}
			return false;
		}
	}
}