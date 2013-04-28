package CiF 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author April
	 */
	public class ItemList 
	{
		private static var _instance:ItemList = new ItemList();
		
		/**
		 * The items in the game.
		 */
		public var items:Vector.<Item> = new Vector.<Item>();
		
		private var itemsByName:Dictionary;
		
		public static function getInstance():ItemList {
			return _instance;
		}
		
		public function ItemList() 
		{
			if (_instance != null) {
				throw new Error("ItemList (Constructor): " + "ItemList can only be accessed through ItemList.getInstance()");
			}
			this.items = new Vector.<Item>();
			this.itemsByName = new Dictionary();
		}
		
		public function reset():void
		{
			if (this.items)
			{
				for each (var item:Item in this.items)
				{
					item.clean();
					item = null;
				}
				this.items = null;
			}
			
			this.itemsByName = null;
			
			this.items = new Vector.<Item>();
			this.itemsByName = new Dictionary();
		}
		
		/**
		 * Accessor to the number of characters currently in the class.
		 */
		public function get length():Number {return this.items.length;}
		
		public function getItemByName(name:String):Item {
			for each (var item:Item in this.items) {
				if (item.name.toLowerCase() == name.toLowerCase())
					return item;
			}
			Debug.debug(this, "getItemByName() item with name " + name + " is not in the ItemList",2);		
			return null;
		}

		public function getItemByID(id:int):Item {
			for each (var item:Item in this.items) {
				if (item.networkID == id)
					return item;
			}
			Debug.debug(this, "getItemByID() item with id " + id + " is not in the ItemList",2);		
			return null;
		}
		
		public function addItem(i:Item):void {
			this.items.push(i);
			this.itemsByName[i.name] = i;
			this.itemsByName[i.name.toLowerCase()] = i;
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
	
		 
		public function clone(): ItemList {
			var i:ItemList = new ItemList();
			i.items = new Vector.<Item>();
			for each(var item:Item in this.items) {
				i.addItem(item.clone());
			}
			return i;
		}
		
		public function toXML():XML {
			var outXML:XML = <ItemList />;
			for each(var item:Item in this.items) {
				outXML.appendChild(item.toXML());
			}
			return outXML;
		}
		
		/*
		 * Returns a String in properly formatted XML representing the ItemList.
		 * */
		public function toXMLString():String {
			return this.toXML().toXMLString();
			//var output:String = new String();
			//output = "<ItemList>\n";
			//for (var i:int = 0; i < this.characters.length; i++) {
				//output += this.characters[i].toXMLString();
				//output += "\n";
			//}
			//output += "</ItemList>\n";
			//return output;
		}
		
		public static function equals(x:ItemList, y:ItemList): Boolean {
			if (x.items.length != y.items.length) return false;
			var i:Number;
			for (i = 0; i < x.items.length; ++i) {
				if (!Item.equals(x.items[i], y.items[i])) return false;
			}
			return true;
		}
		
	}

}