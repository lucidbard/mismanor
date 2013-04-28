package grailgm
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.net.*;
	
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class Main extends Sprite 
	{
		private var quest:Class = Quest; // here to force Quest to be loaded for the swc
		private var questLib:Class = QuestLib; // here to force QuestLib to be loaded for the swc
		private var plotPoint:Class = PlotPoint;
		private var plotPointPool:Class = PlotPointPool;
		private var grailInstantiation:Class = GrailInstantiation;
		private var location:Class = Location;
		private var world:Class = World;
		private var grailGM:Class = GrailGM;
		private var item:Class = GrailItem;
		private var char:Class = GrailCharacter;
		private var scene:Class = GrailScene;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			/*
			var text:TextField = new TextField();
			text.text = GrailInstantiation.getNameByID(0);
			addChild(text);*/
			
			//testWrite();
			//testRead();

		}
					
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
		private function testWrite(data:String = "blah"):void {
			var myData:URLRequest = new URLRequest("http://users.soe.ucsc.edu/~agrow/mismanor/savePlayTrace.php");
			myData.method = URLRequestMethod.POST;
			
			var variables:URLVariables = new URLVariables();
			variables.Name = "CharCreator.txt";
			variables.Data = data;
			myData.data = variables;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(myData);
			trace("Test write complete");
		}
		
		private function completeRead(evt:Event):void {
			var charName:String = evt.target.data.charname;
			var charLoc:String = evt.target.data.charloc;
 
			trace("Read: " + charName + " at " + charLoc);
			// Blah blah call functions
			var text:TextField = new TextField();
			text.text = "Read: " + charName + " at " + charLoc;
			text.width = 500;
			addChild(text);
			
		}
		
		private function testRead():void {
			var request:URLRequest = new URLRequest("http://users.soe.ucsc.edu/~agrow/mismanor/testRead.php");
			request.method = URLRequestMethod.GET;

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, completeRead);
			loader.load(request);
		}
		
	}
	
}