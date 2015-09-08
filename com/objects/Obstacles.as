package com.objects
{

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.*;
	import com.objects.*;
	import com.objects.Helpers;

	public class Obstacles extends MovieClip
	{
		private var cloud:Cloud1;
		private var brick:Brick;
		private var bird:Bird;
		private var numObjectsHit:int = 0;

		public function Obstacles()
		{
			// Center the obstacle course on stage
			x = 0;
			y = 0;

			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}

		public function loop(e:Event)
		{
			//Add cloud with a random 10% chance of being added on each loop
			if (Helpers.randomNumber(0,100) > 90)
			{
				addCloud();
				
				//A bird only has 1% chance of being added in a loop
				if (Helpers.randomNumber(0,100) > 90){
					if(this.getChildByName("bird") == null){
						//Add a bird if there are no current ones flying about
						addBird();
					}
				}
			}
			
			addBuilding();

			//Loop through each of our child obstacles and make them scroll
			for (var i=0; i<this.numChildren; i++)
			{
				var mc:DisplayObject = this.getChildAt(i);

				if (mc.name != "border")
				{//Dont move the border
					if (mc.x < -200)
					{
						this.removeChild(mc);
						//If gone of out of sight, remove it;
						//trace("removed "+mc.name);
					}
					else
					{
						mc.x -=  3;//move to left
						
						//birds move faster.
						if(mc.name == "bird"){
							mc.x -= 3;
						}
					}
				}
			}
		}//End loop

		public function addCloud()
		{
			cloud = new Cloud1("start");

			if (!Helpers.engineRef.checkHittingObstacle(cloud))
			{
				this.addChild(cloud);
			}
		}

		public function addBuilding()
		{
			brick = new Brick("start");

			//Checks if the building is touching any current obstacle before adding
			if (!Helpers.engineRef.checkHittingObstacle(brick))
			{
				this.addChild(brick);
			}
		}

		public function addBird()
		{
			bird = new Bird("start");
			
			if(!Helpers.engineRef.checkHittingObstacle(bird)){
				this.addChild(bird);
			}
		}
	}

}