package mismanor 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import grailgm.GrailItem;
	
	/**
	 * ...
	 * @author April
	 */
	public class GameItem extends GrailItem
	{
		// graphics/interface
		public var graphic:Bitmap;
		public var graphicLoader:Loader;
		public var graphicFileName:String;
		public var itemContainer:Sprite = new Sprite();
		public var x:Number = 0;
		public var y:Number = 0;
		
		// Make one of these for every room?
		// Holds the position of the item in the world when it's in the player's inventory
		private var posInRoom:Shape = new Shape;
		
		public function GameItem() 
		{
			super();
		}
	
		/***** Setter Functions *****/
		// Saves the item's position in the room when not in an inventory
		// Should be called once on initialization of item (possibly once for each room that exists?)
		public function setPosition(x:Number, y:Number, width:Number, height:Number):void {
			posInRoom.x = x;
			posInRoom.y = y;
			posInRoom.scaleX = width;
			posInRoom.scaleY = height;
			//trace("values sent in: " + x + ", " + y + ", " + width + ", " + height);
			//trace("saving values: " + posInRoom.x + ", " + posInRoom.y + ", " + posInRoom.width + ", " + posInRoom.height);
		}
		
		// Moves the graphic to the position on the screen when not in an inventory
		// Should not be called if setPosition has not been called yet
		// Should be called whenever an item is removed from an inventory
		public function moveToPositionInRoom():void {
			graphic.x = posInRoom.x;
			graphic.y = posInRoom.y;
			graphic.width = posInRoom.scaleX;
			graphic.height = posInRoom.scaleY;
			//trace("image moved to: " + graphic.x + ", " + graphic.y + ", " + graphic.width + ", " + graphic.height);
		}
	}

}