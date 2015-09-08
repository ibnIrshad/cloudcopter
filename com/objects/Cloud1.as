package com.objects {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.objects.Helpers
	
	public class Cloud1 extends MovieClip {
		
		
		public function Cloud1(place:String) {
			//Displays a random cloud shape from Cloud1 timeline
			this.gotoAndStop(Helpers.randomNumber(0,2));
			
			// place: a custom type with string values such as "random" to indicate where the
			switch (place){
				case "random": 
					Helpers.placeRandom(this);
					break;
					
				case "start":
					//Place cloud at starting point of screen scroll
					x=600;
					y=Helpers.randomNumber(-10,100);
					this.name="cloud"+Helpers.randomNumber(0,1000);
					break;
				
				default:
					Helpers.placeRandom(this);
			}
		}
	}
	
}
