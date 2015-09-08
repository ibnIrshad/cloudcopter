package com.objects {
	
	import flash.display.MovieClip;
	import com.objects.Helpers
	
	public class Brick extends MovieClip {
		
		
		public function Brick(place:String) {
			//Displays a random building texture from Brick timeline
			this.gotoAndStop(Helpers.randomNumber(0,5));
			
			// place: a custom type with string values such as "random" to indicate where the
			switch (place){
				case "random": 
					Helpers.placeRandom(this);
					break;
					
				case "start":
					//Place cloud at starting point of screen scroll
					x=600;
					y=400;
					this.name="brick"+Helpers.randomNumber(0,1000);
					this.width=Helpers.randomNumber(30,150);
					this.height=Helpers.randomNumber(1,220);
					break;
				
				default:
					Helpers.placeRandom(this);
			}
		}
	}
	
}
