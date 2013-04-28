package grailgm 
{
	import CiF.Character;
	import CiF.GameObject;
	import CiF.SocialGame;
	import CiF.Status;
	import CiF.Trait;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GrailCharacter 
	{
		internal var cifCharacter:Character;
		// location
		public var curLocation:Number;
		public var inventory:Inventory;
		public var memory:Vector.<GrailKnowledge>;
		
		public var lastMoves:Vector.<String> = new Vector.<String>(); // List of the last N social moves this character has taken
		public var numMoves:Number = 3; // Number of moves before a move can be repeated
		// (April)
		// Placeholders to reserve XML information for mismanor on load/save state
		public var locationRoomSideString:String;
		public var locationYOffsetString:String;
		public var locationRoomString:String;
		public var imgString:String;
				
		public function GrailCharacter() 
		{
			cifCharacter = new Character();
			curLocation = -1;
			memory = new Vector.<GrailKnowledge>();
		}
		
		public function clean(): void {
			if (cifCharacter)
				cifCharacter.clean();
			cifCharacter = null;
			
			if (inventory)
				inventory.clean();
			inventory = null;
			
			if (memory)
			{
				for each (var know:GrailKnowledge in memory)
				{
					know.clean();
					know = null;
				}
				memory = null;
			}
			
			if (lastMoves)
			{
				for each (var str:String in lastMoves)
					str = null;
				lastMoves = null;
			}
			locationRoomSideString = null;
			locationYOffsetString = null;
			locationRoomString = null;
			imgString = null;
		}
		
		public function addMove(sgName:String): void
		{
			this.lastMoves.push(sgName);
			if (this.lastMoves.length > numMoves)
				this.lastMoves.splice(0, 1);
		}
		
		public function moveInHistory(sgName:String): Boolean
		{
			for each (var move:String in lastMoves)
			{
				if (sgName.toLowerCase() == move.toLowerCase())
					return true;
			}
			return false;
		}
		public function get name(): String
		{
			return cifCharacter.name;
		}
		
		public function initInventory(): void
		{
			inventory = new Inventory(cifCharacter.name);
		}
		public function setCharacterName(newName:String): Boolean
		{
			// If you're going to do any fun name checking tricks, do them here
			if (newName)
			{
				cifCharacter.name = newName;
				return true;
			}
			
			return false;
		}
		
		public function known(knowledge:GrailKnowledge):Boolean {
			for each (var know:GrailKnowledge in this.memory)
			{
				if (know.cifKnowledge.name.toLowerCase() == knowledge.cifKnowledge.name.toLowerCase())
					return true;
			}
			return false;
		}
		
		public function addKnowledge(knowledge:GrailKnowledge):void {
			// Check if knowledge already is there 
			if (knowledge != null && !known(knowledge)) {
				knowledge.cifKnowledge.addStatus(Status.KNOWN_BY, this.cifCharacter as GameObject);
				this.cifCharacter.addStatus(Status.KNOWS, knowledge.cifKnowledge as GameObject);
				memory.push(knowledge);
			}
		}
		
		public function hasWitnessed(obj:GameObject): Boolean {
			if (cifCharacter.hasStatus(Status.KNOWS, obj) || obj.hasStatus(Status.KNOWN_BY, cifCharacter)) return true;
			else return false;
		}

		public function setCurLocation(room:Number): void
		{
			var grail:GrailGM = GrailGM.getInstance();
			
			this.curLocation = room;
		}
		
		public function addDirectCharStatus(status:Number, other:GrailCharacter, duration:Number = 0): void
		{
			cifCharacter.addStatus(status, other.cifCharacter, duration);
		}
		
		public function addDirectItemStatus(status:Number, other:GrailItem, duration:Number = 0): void
		{
			cifCharacter.addStatus(status, other.cifItem, duration);
		}
		
		public function addDirectKnowStatus(status:Number, other:PlotPoint, duration:Number = 0): void
		{
			cifCharacter.addStatus(status, other.cifKnowledge, duration);
		}
		
		public function addStatus(status:Number, duration:Number = 0): void
		{
			cifCharacter.addStatus(status, null, duration);
		}
		
		public function getStatuses(): String
		{
			var resultStr:String = new String();
			
			for each (var stat:Status in this.cifCharacter.statuses)
			{
				resultStr += Status.getStatusNameByNumber(stat.type);
				if (stat.type > Status.FIRST_DIRECTED_STATUS)
					resultStr += " " + stat.directedToward;
					
				resultStr += "\n";
			}
			
			return resultStr;
		}
		
		public function addTrait(trait:Number): void
		{
			cifCharacter.traits.push(trait);
		}
		
		public function removeTrait(trait:Number): void
		{
			for (var i:Number = 0; i < cifCharacter.traits.length; i++)
			{
				if (cifCharacter.traits[i] == trait)
				{
					cifCharacter.traits.splice(i, 1);
					break;
				}
			}
		}
		
		public function toXML():XML {
			var cifXML:XML = cifCharacter.toXML();
			cifXML.appendChild(<img src={this.imgString}/>);
			cifXML.appendChild(<Location roomSide={this.locationRoomSideString} yOffset={this.locationYOffsetString} room={this.locationRoomString} />);
			var inventoryXML:XML = <Inventory/>;
			for each (var item:GrailItem in inventory.items) {
				inventoryXML.appendChild(<Item name={item.name} />);
			}
			cifXML.appendChild(inventoryXML);
			return cifXML;
		}
		
		public function toString(): String {
			var totalString:String = cifCharacter.name + "\n";
			for each (var t:Number in cifCharacter.traits) {
				totalString += "\t";
				totalString += Trait.getNameByNumber(t);
				totalString += "\n";
			}
			for each (var status:Status in cifCharacter.statuses)
			{
				totalString += "\t";
				totalString += Status.getStatusNameByNumber(status.type);
				if (status.isDirected) totalString += " " + status.directedToward;
				if (status.hasDuration) totalString += " for " + status.remainingDuration + " more turns";
				totalString += "\n";
			}
			totalString += "\n";
			return totalString;
		}
	}

}