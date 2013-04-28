package grailgm 
{
	import CiF.CiFSingleton;
	import CiF.GameObject;
	import CiF.Item;
	import CiF.Status;
	import CiF.Trait;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GrailItem 
	{
		internal var cifItem:Item = new Item();
		// location
		public var curLocation:Number;
		
		// (April)
		// Placeholders to reserve XML information for mismanor on load/save state
		public var curLocationString:String;
		public var imgLocationString:String;
		public var xString:String = "";
		public var yString:String = "";
				
		public function GrailItem() 
		{
			super();
			// Do it automatically
			cifItem.traits.push(Trait.ITEM);			
		}

		public function clean(): void {
			if (cifItem)
				cifItem.clean();
			cifItem = null;
			
			curLocationString = null;
			imgLocationString = null;
			xString = null;
			yString = null;
		}
		
		public function get name(): String
		{
			return cifItem.name;
		}

		public function setItemName(name:String): void
		{
			cifItem.name = name;
		}
				
		public function setCurLocation(room:Number): void
		{
			curLocation = room;
		}
		
		/***** Getter Functions *****/
		public function isHidden():Boolean {
			for each (var status:Status in cifItem.statuses)
			{
				if (Status.getStatusNameByNumber(status.type) == "hidden") return true;
			}
			//trace("isHidden == false");
			return false;
		}
		
		public function isHeld():Boolean {
			for each (var status:Status in cifItem.statuses)
			{
				if (Status.getStatusNameByNumber(status.type) == "held by") return true;
			}
			//trace("isHeld == false");
			return false;
		}
		
		public function isHeldBy():GrailCharacter {
			var char:GrailCharacter = null;
			for each (var status:Status in cifItem.statuses)
			{
				if (Status.getStatusNameByNumber(status.type) == "held by")
				{
					char = GrailGM.getInstance().getCharacterByName(status.directedToward);
				}
			}
			return char;
		}
		
		public function toXML():XML {
			var cifXML:XML = cifItem.toXML();
			cifXML.appendChild(<Location room={this.curLocationString} x={this.xString} y={this.yString} />);
			cifXML.appendChild(<img src={this.imgLocationString}/>);
			return cifXML;
		}

		// Prints out all the info about the item!
		public function toString(): String {
			var totalString:String = cifItem.name + "\n";
			for each (var t:Number in cifItem.traits) {
				totalString += "\t";
				totalString += Trait.getNameByNumber(t);
				totalString += "\n";
			}
			for each (var status:Status in cifItem.statuses)
			{
				totalString += "\t";
				totalString += Status.getStatusNameByNumber(status.type);
				if (status.isDirected) totalString += " by " + status.directedToward;
				totalString += "\n";
			}
			return totalString;
		}
	}

}