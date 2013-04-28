package CiF 
{
	import flash.utils.Dictionary;
	/**
	 * The Character class stores the basic information a character needs to
	 * operate in CiF. Characters have a set of traits, a name, a network ID
	 * and a prospective memory to store their social game scores.
	 * 
	 * @see CiF.Character
	 * @see CiF.SocialNetwork
	 * @see CiF.ProspectiveMemory
	 * 
	 * TODO: if a trait is already assigned to a character, make sure it doesn't appear twice.
	 */
	public class Character extends GameObject
	{
		/**
		 * The knowledge known by the character.
		 */
		public var knowledgeList:Vector.<Knowledge>;
		// Who they learned the knowledge from
		public var knowledgeFromList:Vector.<Character>;
		
		// itemList
		public var itemList:Vector.<Item>;
		public var itemFromList:Vector.<Character>;
		
		/**
		 * The gender of the character.
		 */
		public var gender:String;
		
		/**
		 * The character's prospective memory used by intent formation and
		 * goal setting.
		 */
		public var prospectiveMemory:ProspectiveMemory;
		
		/**
		 * The character specific mix ins that are used in performance realizations
		 */
		public var locutions:Dictionary;
		
		public static var defaultLocutions:Dictionary = new Dictionary();
		defaultLocutions["greeting"] = "What's up";
		defaultLocutions["shocked"] = "Holy crap!!!";
		defaultLocutions["positiveadj"] = "cool";
		defaultLocutions["pejorative"] = "loser";
		defaultLocutions["sweetie"] = "sweetie";
		defaultLocutions["buddy"] = "dude";
		
		public function Character() {
			this.traits = new Vector.<Number>();
			this.name = "";
			this.networkID = -1;
			this.prospectiveMemory = new ProspectiveMemory();
			//this.statuses = new Dictionary();
			this.statuses = new Vector.<Status>();
			this.locutions = new Dictionary();
			this.knowledgeList = new Vector.<Knowledge>();
			this.knowledgeFromList = new Vector.<Character>();
			this.itemList = new Vector.<Item>();
			this.itemFromList = new Vector.<Character>();
			this.type = TYPE_CHARACTER;
		}
		
		override public function clean(): void 
		{
			var char:Character;
			
			this.gender = null;
			if (this.prospectiveMemory)
				this.prospectiveMemory.clean();				
			this.prospectiveMemory = null;
			this.locutions = null;
			
			if (this.knowledgeList)
			{
				for each (var know:Knowledge in this.knowledgeList)
				{
					know.clean();
					know = null;
				}
				this.knowledgeList = null;
			}
			
			if (this.knowledgeFromList)
			{
				for each (char in this.knowledgeFromList)
				{
					char.clean();
					char = null;
				}
				this.knowledgeFromList = null;
			}
			
			if (this.itemList)
			{
				for each (var item:Item in this.itemList)
				{
					item.clean();
					item = null;
				}
				this.itemList = null;
			}
			if (this.itemFromList)
			{
				for each (char in this.itemFromList)
				{
					char.clean();
					char = null;
				}
				this.itemFromList = null;
			}
			this.traits = null;
			this.name = null;
			
			if (this.statuses)
			{
				for each (var status:Status in this.statuses)
				{
					status.clean();
					status = null;
				}
				this.statuses = null;
			}

		}
		/**
		 * Returns true if the character knows the specific piece of knowledge. It matches 
		 * the number in knowledgeList vector with the const indentifiers in the Knowledge
		 * class.
		 * 
		 * @param knowledge
		 * @return 
		 */
		public function hasKnowledge(knowledge:Knowledge, otherCharacter:Character=null): Boolean {
			var i:Number = 0;
			
			for (i = 0; i < this.knowledgeList.length; ++i) {
				if (this.knowledgeList[i] == knowledge) 
				{
					if (otherCharacter)
					{
						if (this.knowledgeFromList[i] == otherCharacter)
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		/**
		 * Returns true if the character knows the specific piece of knowledge. It matches 
		 * the number in knowledgeList vector with the const indentifiers in the Knowledge
		 * class.
		 * 
		 * @param knowledge
		 * @return 
		 */
		public function hasKnowledgeType(knowledgeType:Number, otherCharacter:Character=null): Boolean {
			var i:Number = 0;
			
			/*for (i = 0; i < this.knowledgeList.length; ++i) {
				if (this.knowledgeList[i].knowledgeType == knowledgeType) 
				{
					if (otherCharacter)
					{
						if (this.knowledgeFromList[i] == otherCharacter)
							return true;
					}
					else
						return true;
				}
			}*/
			trace("OH GOD IT IS NOT WORKING YET --April");
			return false;
		}
		/**
		 * Returns true if the character knows the specific item. It matches 
		 * the number in itemList vector with the const indentifiers in the Item
		 * class.
		 * 
		 * @param item
		 * @return 
		 */
		/*public function hasItemType(itemType:Number, otherCharacter:Character=null): Boolean {
			var i:Number = 0;
			
			for (i = 0; i < this.itemList.length; ++i) {
				if (this.itemList[i].itemType == itemType) {
					if (otherCharacter)
					{
						if (this.itemFromList[i] == otherCharacter)
							return true;
					}
					else
						return true;
				}
			}
			
			return false;
		}*/

		/**
		 * Returns true if the character knows the specific item. It matches 
		 * the number in itemList vector with the const indentifiers in the Item
		 * class.
		 * 
		 * @param item
		 * @return 
		 */
		public function hasItem(item:Item, otherCharacter:Character=null): Boolean {
			var i:Number = 0;
			
			for (i = 0; i < this.itemList.length; ++i) {
				if (this.itemList[i] == item) {
					if (otherCharacter)
					{
						if (this.itemFromList[i] == otherCharacter)
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		/*******
		 * Sets a name for the character
		 * @param newName
		 ******* */
		override public function setName(newName:String):void {
			this.name = newName;
			this.name = newName;
		}
		
		
/*			
			//Debug.debug(this, "hasStatus() determining if " + this.characterName + " has status of " + Status.getStatusNameByNumber(statusType) + " " + statusType);
			//Debug.debug(this, "status: "+statusType+" is "+Status.getStatusNameByNumber(statusType));
			
			//if it is a status category loop through all ones of that category
			if (statusType <= Status.LAST_CATEGORY_COUNT)
			{
				//Debug.debug(this, "hasStatus(): "+Status.getStatusNameByNumber(statusType) + " is a category");
				for each (var type:int in Status.CATEGORIES[statusType])
				{
					if (this.statuses[type])
					{
						status = this.statuses[type] as Status;
						
						//Debug.debug(this, "hasStatus(): testing if " + Status.getStatusNameByNumber(type) + " is in " + Status.getStatusNameByNumber(statusType));
						if (status.type >= Status.FIRST_DIRECTED_STATUS)
						{
							if (status.directedToward.toLowerCase() == towardCharacter.characterName.toLowerCase())
								return true;
						}
						else
						{
							return true;
						}
					}
				}
			}
			else if (this.statuses[statusType])
			{
				//Debug.debug(this, "hasStatus() status is in dictionary; checking to see if second character is expected: " + status.directedToward);
				//Debug.debug(this, "hasStatus() status is in dictionary; checking to see if second character is expected: " + status.directedToward);
				//Debug.debug(this, "hasStatus() "+Status.getStatusNameByNumber(statusType)+" status is in dictionary;");
				
				var status:Status;
				//otherwise, just see that we have the status
				status = this.statuses[statusType] as Status;
				
						//Debug.debug(this, Status.getStatusNameByNumber(statusType) );
						//Debug.debug(this, towardCharacter.characterName.toLowerCase());
						//Debug.debug(this, status.directedToward.toLowerCase());
				
				if (status.type >= Status.FIRST_DIRECTED_STATUS)
				{
					if (!towardCharacter)
					{
						Debug.debug(this, "Malformed rule: " + this.characterName + " has status " + Status.getStatusNameByNumber(status.type) + " toward no one");
						return false;
					}
					
					
					if (status.directedToward.toLowerCase() == towardCharacter.characterName.toLowerCase())
					{
						return true;
					}
				}
				else
				{
					return true;
				}
			}
			return false;			
		}
		
		/**
		 * Give the character some knowledge
		 * @param	knowledge	The piece of knowledge the character will learn.
		 */
		public function addKnowledge(knowledgeType:Number, otherCharacter:Character = null):void {
			var newKnowledge:Knowledge = new Knowledge();
			//newKnowledge.knowledgeType = knowledgeType;
			//newKnowledge.name = Knowledge.getNameByNumber(knowledgeType);
			this.knowledgeList.push(newKnowledge);
			this.knowledgeFromList.push(otherCharacter);
		}
		
		/**
		 * Give the character some item
		 * @param	item	The item the character will get.
		 */
		public function addItem(itemType:Number, otherCharacter:Character = null):void {
			var newItem:Item = new Item();
			trace("OH GOD IT IS NOT WORKING YET --April");
			//newItem.itemType = itemType;
			//newItem.name = Item.getNameByNumber(itemType);
			//this.itemList.push(newItem);
			//this.itemFromList.push(otherCharacter);
		}
		
		/**
		 * Give the character an item for their desiredItems list
		 * @param	item	The item to add to the desiredItems list.
		 */
/*		public function addDesiredItem(item:Item):void {
			this.desiredItems.push(item);
		}
*/		
		/**
		 * Give the character an item for their pastItems list
		 * @param	item	The item to add to the pastItems list.
		 */
/*		public function addPastItem(item:Item):void {
			this.pastItems.push(item);
		}
*/		
		/** TODO: Is this ever going to be possible?
		 * Remove knowledge from the character's knowledgeList
		 * @param	knowledge	The knowledge to remove.
		 */
		public function removeKnowledge(knowledge:Number): void {
			var knowledgeIndex: Number=-1;
			/*for (var i:Number = 0; i < this.knowledgeList.length; i++)
			{
				if (this.knowledgeList[i].knowledgeType == knowledge)
				{
					knowledgeIndex = i;
					break;
				}
			}
//			trace("itemlist: " + items);
//			trace("itemIndex is " + itemIndex);
			if (knowledgeIndex >= 0)
			{
				this.knowledgeList.splice(knowledgeIndex, 1);
				this.knowledgeFromList.splice(knowledgeIndex, 1);
			}
			else
				trace ("Could not find knowledge type " + knowledge);*/
//			trace("itemlist: " + items);
			trace("OH GOD IT IS NOT WORKING YET --April");
		}
		
		/**
		 * Remove an item from the character's itemList
		 * @param	item	The item to remove.
		 */
		public function removeItem(item:Number): void {
			var itemIndex: Number=-1;
			for (var i:Number = 0; i < this.itemList.length; i++)
			{
				/*if (this.itemList[i].itemType == item)
				{
					itemIndex = i;
					break;
				}*/
			}
//			trace("itemlist: " + items);
//			trace("itemIndex is " + itemIndex);
			if (itemIndex >= 0)
			{
				this.itemList.splice(itemIndex, 1);
				this.itemFromList.splice(itemIndex, 1);
			}
			else
			{
				trace ("Could not find item type " + item);
			}
//			trace("itemlist: " + items);
		}

		/**
		 * Remove an item from the character's desiredItems list
		 * @param	item	The item to remove.
		 */
/*		public function removeDesiredItem(item:Item): void {
			var itemIndex: Number;
			itemIndex = this.desiredItems.indexOf(item);
			this.desiredItems.splice(itemIndex, 1);
		}
*/		
		/**
		 * Remove an item from the character's pastItem list
		 * TODO: Should this even be possible??
		 * @param	item	The item to remove.
		 */
/*		public function removePastItem(item:Item): void {
			var itemIndex: Number;
			itemIndex = this.pastItems.indexOf(item);
			this.pastItems.splice(itemIndex, 1);
		}
*/		
		/** (April)
		 * Resets an urge once the urge has been satisfied with a social move that includes the urge type (as responder or other)
		 * Also resets the urge's tick timer
		 */
		public function resetUrge(urgeID:Number):void {
			for each(var status:Status in statuses) {
				if (status.isUrge && status.type == urgeID) {
					trace("RESETING " + name + "'s URGE: " + Status.getStatusNameByNumber(status.type));
					status.urgeStrength = 0;
					status.remainingUrgeTickDuration = status.totalUrgeTickDuration;
				}
			}
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		override public function toXML():XML {
			var returnXML:XML;
			var status:Status;
			returnXML = <Character name={this.name} networkID={this.networkID} />;
			for each (var traitType:Number in this.traits) {
				returnXML.appendChild(<Trait type={Trait.getNameByNumber(traitType)} />);
			}
			for (var locutionKey:Object in this.locutions)
			{
				returnXML.appendChild(<Locution type={locutionKey as String} >{this.locutions[locutionKey]}</Locution>);
			}
			//for (var key:Object in this.statuses) {
				//status = this.statuses[key] as Status;
				//returnXML.appendChild(<Status type={Status.getStatusNameByNumber(key as int)} from={this.characterName} to={status.directedToward} />);
			//}
			for each(status in this.statuses) {
				//status = this.statuses[key] as Status;
				returnXML.appendChild(<Status type={Status.getStatusNameByNumber(status.type)} from={this.name} to={status.directedToward} />);
			}
			return returnXML;
		}
		
		public function clone(): Character {
			var ch:Character = new Character();
			var status:Status;
			var locution:String;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			ch.name = this.name;
			ch.name = this.name;
			ch.networkID = this.networkID;
			ch.prospectiveMemory = this.prospectiveMemory;
			ch.traits = new Vector.<Number>();
			ch.type = this.type;
			for each(var i:Number in this.traits) {
				ch.traits.push(i);
			}
			//for (var key:Object in this.statuses) {
				//status = this.statuses[key] as Status;
				//ch.addStatus(key as int, cif.cast.getCharByName(status.directedToward));
			//}
			for each (status in this.statuses) {
				//status = this.statuses[key] as Status;
				if (status.type != Status.IS_HOLDING && status.type != Status.HELD_BY)
					ch.addStatus(status.type, cif.cast.getCharByName(status.directedToward));
			}
			for (var key:Object in this.locutions) {
				locution = this.locutions[key] as String;
				ch.locutions[key] = locution;
			}
			return ch;
		}
		
		public static function equals(x:Character, y:Character): Boolean {
			if (x.traits.length !=y.traits.length) return false;
			for (var i:Number = 0; i < x.traits.length; ++i) {
				if ((x.traits[i] != y.traits[i])) return false;
			}
			if (x.name != y.name) return false;
			if (x.networkID != y.networkID) return false;
			if (x.prospectiveMemory != y.prospectiveMemory) return false;
			return true;
		}
	}
}