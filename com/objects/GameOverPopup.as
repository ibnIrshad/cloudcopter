package com.objects
{

	import flash.display.MovieClip;
	import flash.events.*;
	import com.objects.Helpers;
	import flash.net.URLLoader;
	import flash.xml.*;
	import flash.net.SharedObject;


	public class GameOverPopup extends MovieClip
	{
		public var xmlScores:XML;
		private var so:SharedObject;

		public function GameOverPopup()
		{
			x = 69.55;
			y = 51.55;
			addEventListener(Event.ENTER_FRAME, construct);
		}

		private function construct(e:Event)
		{
			if (this.currentLabel == "construct" && score_txt != null)
			{
				score_txt.text = String(Helpers.score);
				restart_btn.addEventListener(MouseEvent.CLICK, Helpers.engineRef.handleRestartBtn);
				removeEventListener(Event.ENTER_FRAME, construct);

				//Do the XML stuff
				loadXML();
			}
		}

		public function loadXML()
		{
			so = SharedObject.getLocal("CloudCopterData");

			if (so.size == 0)
			{
				Helpers.xmlScores = new XML(<scores><score Name="Default" num="1" /></scores>);
			}
			else
			{
				Helpers.xmlScores = new XML(so.data.scores);
			}
			
			if (isHighestScore(Helpers.score))
			{
				var hs:HighestScoreIndicator = new HighestScoreIndicator();
				addChild(hs);
			}

			displayScores();

			nameform.submit_btn.addEventListener(MouseEvent.CLICK, handleAddScoreToXML);
		}

		public function handleAddScoreToXML(e:Event)
		{
			addScoreToXML(nameform.name_input.text, Helpers.score);
			removeChild(nameform);
			saveScores();
			displayScores();
		}

		public function addScoreToXML(nam:String, num:uint)
		{
			Helpers.xmlScores.appendChild = XML("<score Name=\"" + nam + "\" num=\"" + num + "\" />");
		}

		public function isHighestScore(s:uint):Boolean
		{
			Helpers.sortXMLByAttribute(Helpers.xmlScores,"num", Array.NUMERIC | Array.DESCENDING);
			if (s > Helpers.xmlScores.score[0])
			{
				return true;
			}
			return false;
		}

		private function displayScores()
		{
			hiScore_output.text = "High Scores";
			Helpers.sortXMLByAttribute(Helpers.xmlScores,"num", Array.NUMERIC | Array.DESCENDING);
			trace(Helpers.xmlScores);
			for (var i=0; i<Helpers.xmlScores.score.length(); i++)
			{
				var n = i + 1;
				hiScore_output.appendText("\n"+ n +". ");
				hiScore_output.appendText(Helpers.xmlScores.score[i].attribute("Name") + "  --  ");
				hiScore_output.appendText(Helpers.xmlScores.score[i].attribute("num"));
				
				if (i >= 5)
				{
					break;
				}
			}
		}

		public function saveScores()
		{
			so.data.scores = Helpers.xmlScores;
			so.flush();
		}
	}

}