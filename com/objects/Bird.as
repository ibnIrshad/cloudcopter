package com.objects
{

	import flash.display.MovieClip;


	public class Bird extends MovieClip
	{


		public function Bird(place:String)
		{
			//Displays a random bird color

			// place: a custom type with string values such as "random" to indicate where the
			// movie should be placed
			switch (place)
			{
				case "random" :
					Helpers.placeRandom(this);
					break;

				case "start" :
					//Place cloud at starting point of screen scroll
					x = 600;
					y = Helpers.randomNumber(0,400);
					this.name = "bird";
					width = 52;
					height = 44;
					scaleX = -0.6;
					break;

				default :
					Helpers.placeRandom(this);
			}
		}
	}
}