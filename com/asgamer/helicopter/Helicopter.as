package com.asgamer.helicopter
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import com.senocular.utils.KeyObject;
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import com.objects.Helpers;

	public class Helicopter extends MovieClip
	{
		private var isMouseDown:Boolean = false;

		private var gravity:Number = .3;
		private var vy:Number = 0;
		private var vx:Number = 0;
		private var key:KeyObject;
		private var stageRef:Stage;

		private var maxspeedG:Number = 9;
		private var maxspeed:Number = 6;

		private var friction:Number = .9;

		public function Helicopter(stageRef:Stage):void
		{
			stop();
			this.stageRef = stageRef;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			key = new KeyObject(stageRef);

			x = 200;
			y = 200;

			stageRef.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			stageRef.addEventListener(MouseEvent.MOUSE_UP, mRelease);
		}

		public function loop(e:Event):void
		{
			vy +=  gravity;
			y +=  vy;
			x +=  vx;

			if (vy > maxspeedG)
			{
				vy = maxspeedG;
			}
			else if (vy < -maxspeed)
			{
				vy =  -  maxspeed;
			}
			if (vx > maxspeed)
			{
				vx = maxspeed;
			}
			else if (vx < -maxspeed)
			{
				vx =  -  maxspeed;

			}
			if (vx > 0)
			{
				scaleX = 1;
			}
			else if (vx < 0)
			{
				scaleX = -1;

			}
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -2;
			}

			rotation = vx * 2;

			if (key.isDown(Keyboard.RIGHT))
			{
				vx +=  .3;
				Helpers.score +=  3;
			}
			else if (key.isDown(Keyboard.LEFT))
			{
				vx -=  .3;
			}
			else
			{
				vx *=  friction;
			}
			
			if (key.isDown(Keyboard.UP))
			{
				vy -=  0.8;
			}
			else if (isMouseDown)
			{
				vy -=  0.8;
			}
			else if (key.isDown(Keyboard.DOWN))
			{
				vy +=  0.5;

			}
		}

		public function blowUp()
		{
			removeEventListener(Event.ENTER_FRAME, loop, false);
			gotoAndStop(2);
		}

		private function mDown(e:Event)
		{
			isMouseDown = true;
		}

		private function mRelease(e:Event)
		{
			isMouseDown = false;
		}


	}

}