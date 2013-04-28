package mismanor 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import grailgm.Diagnostics;
	import grailgm.GrailCharacter;
	import grailgm.GrailGM;
	import grailgm.GrailItem;
	import grailgm.Location;
	import grailgm.World;
	
	import mx.states.OverrideBase;

	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class Map extends World
	{		
		public static const LIVING_ROOM:Number = 0;
		public static const DINING_ROOM:Number = 1;
		public static const GARDENS:Number = 2;
		public static const INVENTORY:Number = 3;
		public static const ROOM_COUNT:Number = 4;

		public var miniMap:Array = new Array();
		private var mapShowing:Boolean = true;
	//	public var roomList:Vector.<Room> = new Vector.<Room>();
		
		// mini-map
		[Embed(source = '../img/topleft.png')]
		private var room1Class:Class;
		[Embed(source = '../img/topright.png')]
		private var room2Class:Class;
		[Embed(source = '../img/bottomright.png')]
		private var room3Class:Class;
		
		[Embed(source = '../img/playermarker.png')]
		private var playerMarkerClass:Class;
		private var playerMarker:Bitmap = new playerMarkerClass;

		// (April) made these public to add in room-changing events
		public var room1Container:Sprite = new Sprite(); 
		public var room2Container:Sprite = new Sprite(); 
		public var room3Container:Sprite = new Sprite();
		
		public var changedRooms:Boolean = false;

		public function Map() 
		{
		}
		
		public function initMap():void
		{
			// initialize the mini-map
			miniMap.push(new room1Class);
			miniMap.push(new room2Class);
			miniMap.push(new room3Class);
			
			curRoom = Map.LIVING_ROOM;
			
			for each (var location:Location in this.locationList)
			{
				var room:Room = location as Room; // have to do this to make the casting stuff work correctly
				room.graphic.visible = false;
			}
		}
		
		public function initMapGraphics(stage:DisplayObjectContainer):void 
		{
			miniMap[1].x = stage.width - miniMap[1].width - 50;
			miniMap[1].y = 25;
			miniMap[1].alpha = 0.5;
			room2Container.addEventListener(MouseEvent.CLICK, updateMap);
			room2Container.buttonMode = true;
			room2Container.addChild(miniMap[1]);
			stage.addChild(room2Container);
			
			miniMap[0].x = miniMap[1].x - miniMap[0].width;
			miniMap[0].y = miniMap[1].y;
			miniMap[0].alpha = 0.75;
			room1Container.addEventListener(MouseEvent.CLICK, updateMap);
			room1Container.buttonMode = true;
			room1Container.addChild(miniMap[0]);
			stage.addChild(room1Container);
			
			miniMap[2].x = miniMap[1].x;
			miniMap[2].y = miniMap[1].y + miniMap[2].height;
			miniMap[2].alpha = 0.5;
		
			room3Container.addEventListener(MouseEvent.CLICK, updateMap);
			room3Container.buttonMode = true;
			room3Container.addChild(miniMap[2]);
			stage.addChild(room3Container);
			
			// player starts in room1
			playerMarker.x = miniMap[0].x;
			playerMarker.y = miniMap[0].y;
			stage.addChild(playerMarker);
			
			for each (var room:Room in locationList as Room)
			{
				if (room.id != curRoom)	
					room.graphic.visible = false;
				
				else
					room.graphic.visible = true;
			}
		}
		
		public function toggleMap(): void
		{
			if (mapShowing)
				hideMap();
			else
				showMap();
			
		}
		
		public function hideMap(): void
		{
			for (var i:Number = 0; i < miniMap.length; i++)
			{
				miniMap[i].visible = false;
			}
			playerMarker.visible = false;
			mapShowing = false;
		}
		
		public function showMap(): void
		{
			for (var i:Number = 0; i < miniMap.length; i++)
			{
				miniMap[i].visible = true;
			}
			playerMarker.visible = true;
			mapShowing = true;
		}
		
		public function disableMap(): void {
			room2Container.removeEventListener(MouseEvent.CLICK, updateMap);
			room2Container.buttonMode = false;
			room1Container.removeEventListener(MouseEvent.CLICK, updateMap);
			room1Container.buttonMode = false;
			room3Container.removeEventListener(MouseEvent.CLICK, updateMap);
			room3Container.buttonMode = false;
		}
		
		public function enableMap(): void {
			room2Container.addEventListener(MouseEvent.CLICK, updateMap);
			if (curRoom != DINING_ROOM) room2Container.buttonMode = true;
			room1Container.addEventListener(MouseEvent.CLICK, updateMap);
			if (curRoom != LIVING_ROOM) room1Container.buttonMode = true;
			room3Container.addEventListener(MouseEvent.CLICK, updateMap);
			if (curRoom != GARDENS) room3Container.buttonMode = true;
		}
		
		// Removes the player from their current room and adds them to the target room
		public function setCurrentRoom(roomNum:Number):void {
			var grail:GrailGM = GrailGM.getInstance();
			var player:GameCharacter = grail.getCharacterByName("player") as GameCharacter;
			var locNum:Number = this.locationList[curRoom].charactersInLocation.indexOf(player);
			
			this.locationList[curRoom].charactersInLocation.splice(locNum, 1)
			curRoom = roomNum;
			this.locationList[curRoom].charactersInLocation.push(player);
			
			var room:Room = locationList[curRoom] as Room;
			room.graphic.visible = true;
		}
		
		public function updateMap(e:Event):void
		{
			switch (e.currentTarget)
			{
				case room1Container:
					if (curRoom != LIVING_ROOM) changedRooms = true;
					setCurrentRoom(LIVING_ROOM);
					break;
				case room2Container:
					if (curRoom != DINING_ROOM) changedRooms = true;
					setCurrentRoom(DINING_ROOM);
					break;
				case room3Container:
					if (curRoom != GARDENS) changedRooms = true;
					setCurrentRoom(GARDENS);
					break;
				default:
					trace("Need to support room in updateMap function");
					break;
			}
			
			for (var i:Number = 0; i < miniMap.length; i++)
			{
				var room:Room = locationList[i] as Room;
				if (i != curRoom)
				{
					miniMap[i].alpha = 0.5;
					room.graphic.visible = false;
				}
				else
				{
					miniMap[i].alpha = 0.75;
					playerMarker.x = miniMap[i].x;
					playerMarker.y = miniMap[i].y;
					room.graphic.visible = true;
				}
				for (var j:Number = 0; j < room.charactersInLocation.length; j++)
				{
					var gameCharacter:GameCharacter = this.locationList[i].charactersInLocation[j] as GameCharacter;
					if (gameCharacter && gameCharacter.name.toLowerCase() != "player"){
						if (i != curRoom)
						{						
							gameCharacter.graphic.visible = false;
							gameCharacter.characterContainer.buttonMode = false;
						}
						else
						{
							gameCharacter.graphic.visible = true;
							gameCharacter.characterContainer.buttonMode = true;
						}
					}
				}	
				for (var k:Number = 0; k < room.itemsInLocation.length; k++)
				{
					var gameItem:GameItem = this.locationList[i].itemsInLocation[k] as GameItem;
					if (i != curRoom)
					{						
						gameItem.graphic.visible = false;
						//gameCharacter.characterContainer.buttonMode = false;
					}
					else if (!gameItem.isHidden())
					{
						gameItem.graphic.visible = true;
						//gameCharacter.characterContainer.buttonMode = true;
					}
				}	
			}
		}
		
		// Removes an item from the gameworld (when the item goes into an inventory)
		public function removeItemFromMap(item:GameItem):void {
			var atRoom:Room = null;
			var atIndex:int = -1;
			for (var i:Number = 0; i < miniMap.length; i++)
			{
				var room:Room = locationList[i] as Room;
				for (var k:Number = 0; k < room.itemsInLocation.length; k++)
				{
					var gameItem:GameItem = this.locationList[i].itemsInLocation[k] as GameItem;
					if (gameItem.name == item.name) {
						atRoom = room;
						atIndex = k;
					}
				}	
			}
			if (atRoom != null && atIndex != -1) {
				atRoom.itemsInLocation.splice(atIndex, 1);
			} else {
				trace("Map.removeItemFromMap: Failed to find item " + item.name + " in map");
			}
		}
		
		
		public override function addItemToRoom(item:GrailItem, roomNum:Number):void {
			super.addItemToRoom(item,roomNum);
			locationList[roomNum].itemsInLocation.push(item);
//			item.graphic.visible = true;
			trace(item.name + " should be visible in room " + roomNum);
		}
		
		public function getRoomByName(roomName:String): Room
		{
			var lowerName:String = roomName.toLowerCase();
			
			for each (var room:Room in locationList)
			{
				if (lowerName == room.name.toLowerCase())
					return room;
			}
			
			trace ("room " + roomName + " was not found\n");	
			return null;
		}
		
		public static function getRoomTypeByName(name:String):Number {
			switch(name.toLowerCase())
			{
				case "living room":
					return Map.LIVING_ROOM;
				case "gardens":
					return Map.GARDENS;
				case "dining room":
					return Map.DINING_ROOM;
				case "inventory":
					return Map.INVENTORY;
				default:
					return -1;
			}
		}
		
		public static function getRoomNameByType(type:Number):String {
			switch (type)
			{
				case Map.LIVING_ROOM:
					return "living room";
				case Map.GARDENS:
					return "gardens";
				case Map.DINING_ROOM:
					return "dining room";
				case Map.INVENTORY:
					return "inventory";
				default:
					return "Room type not defined";
			}
		}
	}

}