package com.objects
{

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.xml.*;
	import com.asgamer.helicopter.Engine;

	public class Helpers extends MovieClip
	{
		public static var engineRef:Engine; //References the main Engine class
		public static const STAGE_WIDTH:uint = 500;
		public static const STAGE_HEIGHT:uint = 400;
		public static var score:uint = 0;
		public static var gameEnded:Boolean = false;
		
		public static var xmlScores:XML;
		
		public function Helpers(stage)
		{

		}

		public static function placeRandom(o:DisplayObject)
		{
			o.x = randomNumber(0,STAGE_WIDTH);
			o.y = randomNumber(0,STAGE_HEIGHT);
		}

		public static function randomNumber(low:Number=0, high:Number=1, increment:Number=1):Number
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		public static function sortXMLByAttribute($xml:XML,$attribute:String,$options:Object=null,$copy:Boolean=false):XML
		{
			//$xml : The XML that needs to be sorted
			//$attribute : The attribute string to sort on
			//$options : The sorting options, see sortOn()
			//$copy : If false, original XML is modified.
			
			//store in array to sort on			
			var xmlArray:Array= new Array();
			var item:XML;
			for each (item in $xml.children())
			{
				var object:Object = {
				data: item, 
				order: item.attribute($attribute)
				};
				xmlArray.push(object);
			}

			//sort using the power of Array.sortOn()
			xmlArray.sortOn('order', $options);

			//create a new XMLList with sorted XML;
			var sortedXmlList:XMLList = new XMLList();
			var xmlObject:Object;
			for each (xmlObject in xmlArray)
			{
				sortedXmlList +=  xmlObject.data;
			}

			if ($copy)
			{
				//don't modify original
				return $xml.copy().setChildren(sortedXmlList);
			}
			else
			{
				//original modified
				return $xml.setChildren(sortedXmlList);
			}
		}

	}

}