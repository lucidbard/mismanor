package grailgm 
{
	import CiF.GameObject;
	import CiF.Status;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class Inventory 
	{
		public var items:Vector.<GrailItem>;
		protected var ownedBy:String;
		
		public function Inventory(name:String) 
		{
			ownedBy = name;
			items = new Vector.<GrailItem>();
		}
		
		public function clean(): void {
			if (items)
			{
				for each (var item:GrailItem in this.items)
				{
					item.clean();
					item = null;
				}
				items = null;
			}
			ownedBy = null;
		}

		/***** Utility Functions *****/
		
		public function hasItem(item:GrailItem):Boolean {
			return hasItemByName(item.name);
		}
		
		public function hasItemByName(item:String):Boolean {
			for each (var it:GrailItem in items) {
				if (item == it.name) return true;
			}
			return false;
		}

		/***** Inventory Management *****/
		
		public function addItem(char:GrailCharacter, item:GrailItem):void {
			// Check if item already is there [or not?]
			if (item != null && !hasItem(item)) {
				item.cifItem.addStatus(Status.HELD_BY, char.cifCharacter as GameObject);
				char.cifCharacter.addStatus(Status.IS_HOLDING, item.cifItem as GameObject);
				items.push(item);
			}
		}
		
		public function removeItem(char:GrailCharacter, item:GrailItem):void {
			if (items.indexOf(item) >= 0)
			{
				item.cifItem.removeStatus(Status.HELD_BY, char.cifCharacter as GameObject);
				char.cifCharacter.removeStatus(Status.IS_HOLDING, item.cifItem as GameObject);
				items.splice(items.indexOf(item), 1);
			}
		}
		
		public function toString():String {
			var totalString:String = "Items in Inventory: \n";
			for each (var it:GrailItem in items) {
				totalString += it.toString();
			}
			if (totalString == "Items in Inventory: \n") totalString += "None\n";
			return totalString;
		}
				

	}

}