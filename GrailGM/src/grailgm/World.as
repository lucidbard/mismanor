package grailgm 
{
	import CiF.Status;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class World 
	{
		public var locationList:Vector.<Location>;
		public var curRoom:Number = -1;
		
		public function World() 
		{
			locationList = new Vector.<Location>();
		}
		
		public function clean(): void {
			if (locationList)
			{
				for each (var loc:Location in this.locationList)
				{
					loc.clean();
					loc = null;
				}
				locationList = null;
			}
		}
		
		public function addCharToRoom(char:GrailCharacter, room:Number): void
		{
			locationList[room].charactersInLocation.push(char);
			char.curLocation = room;
		}
		
		public function addItemToRoom(item:GrailItem, room:Number): void
		{
			locationList[room].itemsInLocation.push(item);
			item.curLocation = room;
		}
		
		public function removeCharFromRoom(char:GrailCharacter, room:Number): void
		{
			var roomCharList:Vector.<GrailCharacter> = locationList[room].charactersInLocation;
			var charIndex:Number = roomCharList.indexOf(char);
			
			if (charIndex >= 0)
			{
				roomCharList.splice(charIndex, 1);
				char.curLocation = -1;
			}
		}
		
		public function removeItemFromRoom(item:GrailItem, room:Number): void
		{
			var roomItemList:Vector.<GrailItem> = locationList[room].itemsInLocation;
			var itemIndex:Number = roomItemList.indexOf(item);
			
			if (itemIndex >= 0)
			{
				roomItemList.splice(itemIndex, 1);
				item.curLocation = -1;
			}
		}
		
		public function getLocationByName(locationName:String) : Location
		{
			var lowerName:String = locationName.toLowerCase();
			
			for each (var location:Location in locationList)
			{
				if (location.name.toLowerCase() == lowerName)
					return location;
			}
			
			trace ("Location " + locationName + " was not found\n");
			return null;
		}
		
		/**
		 * (April) 
		 * Lets all visible objects and characters be known by everyone in the room
		 * Note: addStatus() now handles the reflection of directed paired statues (KNOWS / KNOWN BY)
		 */
		public function shareKnowsInRoom(player:GrailCharacter):void {
			var charsInRoom:Vector.<GrailCharacter> = new Vector.<GrailCharacter>();
			for each (var char:GrailCharacter in locationList[curRoom].charactersInLocation) { 
				charsInRoom.push(char);
			}
			charsInRoom.push(player);
			for each (var char1:GrailCharacter in charsInRoom) {
				for each (var char2:GrailCharacter in charsInRoom) {
					char1.addDirectCharStatus(Status.KNOWS, char2);
					for each (var charItem:GrailItem in char2.inventory.items) {
						if (!charItem.isHidden()) char1.addDirectItemStatus(Status.KNOWS, charItem);
					}
				}
				for each (var roomItem:GrailItem in locationList[curRoom].itemsInLocation) {
					if (!roomItem.isHidden()) char1.addDirectItemStatus(Status.KNOWS, roomItem);
				}
			}
		}


	}

}