package mismanor 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import grailgm.Location;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class Room extends Location
	{
		// backgrounds for the rooms
		public var id:Number;
		public var graphic:Bitmap = new Bitmap();
		public var container:Sprite = new Sprite();
		
		public function Room() 
		{
			
		}
		
/*		public function room1Clicked(event:MouseEvent):void {
			// update the map
			// updateMap();
			room1Background.visible = true;
			room2Background.visible = false;
			room3Background.visible = false;
			// Tally & Mishka are present
			tally.visible = true;
			tallyContainer.buttonMode = true;
			mishka.visible = true;
			mishkaContainer.buttonMode = true;
			
			// Obi & Kita are not present
			kita.visible = false;
			kitaContainer.buttonMode = false;
			obi.visible = false;
			obiContainer.buttonMode = false;
		}
		
		private function room2Clicked(event:MouseEvent):void {
		// make room 2 the active room
			room1.alpha = 0.5;
			room2.alpha = 0.75;
			room3.alpha = 0.5;
			playerMarker.x = room2.x;
			playerMarker.y = room2.y;
			
			room1Container.buttonMode = true;
			room2Container.buttonMode = false;
			room3Container.buttonMode = true;
			
			room1Background.visible = false;
			room2Background.visible = true;
			room3Background.visible = false;

			// Kita is present
			kita.visible = true;
			kitaContainer.buttonMode = true;
			
			// Tally, Mishka & Obi are not present
			mishka.visible = false;
			mishkaContainer.buttonMode = false;
			obi.visible = false;
			obiContainer.buttonMode = false;
			tally.visible = false;
			tallyContainer.buttonMode = false;
		}

		private function room3Clicked(event:MouseEvent):void {
		// make room 3 the active room
			room1.alpha = 0.5;
			room2.alpha = 0.5;
			room3.alpha = 0.75;
			playerMarker.x = room3.x;
			playerMarker.y = room3.y;
			
			room1Container.buttonMode = true;
			room2Container.buttonMode = true;
			room3Container.buttonMode = false;
			
			room1Background.visible = false;
			room2Background.visible = false;
			room3Background.visible = true;

			// Obi is present
			obi.visible = true;
			obiContainer.buttonMode = true;
			
			// Tally, Mishka & Kita are not present
			mishka.visible = false;
			mishkaContainer.buttonMode = false;
			kita.visible = false;
			kitaContainer.buttonMode = false;
			tally.visible = false;
			tallyContainer.buttonMode = false;
		}		
*/
	}

}