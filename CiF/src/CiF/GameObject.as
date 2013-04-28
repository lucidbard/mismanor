package CiF 
{
	
	import flash.utils.Dictionary;
	/**
	 * Parent Class for Character, Knowledge, and Item trimmed down
	 * from the original Character class.
	 * @author April
	 */
	
	 /**
	 * Game Objects have a set of traits, statuses, a name, a network ID
	 * 
	 * @see CiF.Character
	 * @see CiF.SocialNetwork
	 * @see CiF.ProspectiveMemory
	 * 
	 * TODO: if a trait is already assigned to a character, make sure it doesn't appear twice.
	 */
	 
	public class GameObject 
	{
		/**
		 * The name of the object.
		 */
		public var name:String;
		public var description:String; // author notes for the object
		/**
		 * The traits associated with a character.
		 */
		public var traits:Vector.<Number>;
		/**
		 * The statuses associated with a character.
		 */
		public var statuses:Vector.<Status>;
		/**
		 * The Object's unique ID wrt social networks.
		 */
		public var networkID:Number;
		/**
		 * The Object's type when implemented -- should be set by child constructors
		 */
		public var type:int;
		
		// Strings that are used to hold general information about the game object that is then mixed into instantiations
		// These are initialized by the design tool, stored in a state XML file, and read in at the beginning of the game
		public var examineLine:String; // used for the examine social move
		
		// used to discuss this object in discuss/tell secret/etc social moves
		public var discussNeutral:String; 
		public var discussLike:String;
		public var discussLove:String;
		public var discussHate:String;
		
		// Types
		public static const TYPE_CHARACTER:int = 0;
		public static const TYPE_ITEM:int = 1;
		public static const TYPE_KNOWLEDGE:int = 2;
		
		public static const NUM_TYPES:int = 3;
		
		public function GameObject() {
			this.traits = new Vector.<Number>();
			this.name = "";
			this.networkID = -1;
			this.statuses = new Vector.<Status>();
			this.type = -1;
		}
		
		public function clean(): void {
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
		
		public static function getNameByNumber(type:Number):String {
			switch (type) {
				case GameObject.TYPE_CHARACTER:
					return "character";
				case GameObject.TYPE_ITEM:
					return "item";
				case GameObject.TYPE_KNOWLEDGE:
					return "knowledge";
				
				default:
					return "gameObject not found";				
			}
		}
		
		public static function getNumberByName(name:String):Number {
			switch (name.toLowerCase()) {
				case "character":
					return GameObject.TYPE_CHARACTER;
				case "item":
					return GameObject.TYPE_ITEM;
				case "knowledge":
					return GameObject.TYPE_KNOWLEDGE;
					
				default:
					return -1;
			}
		}
		
		
		/**
		 * Assigns a trait to the character.
		 * @param t
		 */
		public function setTrait(t:Number):void {
			this.traits.push(t);
		}
		
		/**
		 * Returns true if the character has the specified trait. It matches 
		 * the number in traits vector with the const indentifiers in the Trait
		 * class.
		 * 
		 * @param t
		 * @return 
		 */
		public function hasTrait(t:Number):Boolean {
			   var i:Number = 0;
			  /* if (t <= Trait.LAST_CATEGORY_COUNT)
			   {
				for each (var cat_trait:Number in CiF.Trait.CATEGORIES[t])
				{
				 for (i = 0; i < this.traits.length; ++i) {
				  if (this.traits[i] == cat_trait) return true;
				 }
				}
			   }
			   else*/
			   {
				for (i = 0; i < this.traits.length; ++i) {
				 if (this.traits[i] == t) 
				 {
				  return true;
				 }
				}
			   }
			   return false
		}
		
		/**
		 * 
		 * @param	nid
		 */
		public function setNetworkID(nid:Number):void {
			this.networkID = nid;
		}
		
		/*******
		 * Sets a name for the character
		 * @param newName
		 ******* */
		public function setName(newName:String):void {
			this.name = newName;
		}
		
		/**********************************************************************
		 * Status Functions
		 *********************************************************************/

		 /**
		 * Determines if the character has a status with a type with a character 
		 * status target if the status is directed.
		 * @param	statusType		The type of the status.
		 * @param	towardCharacter	The character the status is directed to.
		 * @return	True if the character has the status, false if he does not.
		 */
		public function hasStatus(statusID:int = 0, towardChar:GameObject = null):Boolean 
		{
			var i:Number = 0;
			for each (var status:Status in this.statuses)
			{
				if (statusID <= Status.LAST_CATEGORY_COUNT)
			   {
					for each (var cat_status:Number in Status.CATEGORIES[statusID])
					{
						if (status.type == cat_status) return true;
					}
			   } else if (statusID == status.type)
				{
					if (statusID >= Status.FIRST_DIRECTED_STATUS)
					{
						if (towardChar)
						{
							if (status.directedToward.toLocaleLowerCase() == towardChar.name.toLowerCase())
							{
								return true;	
							}
						}
					}
					else
					{
						return true;
					}
				}
			}
			
			//Debug.debug(this,"getStatus() "+this.name+" does not have the status "+Status.getStatusNameByNumber(statusID));
			
			return false;
		}
		
		/**
		 * Give the character a status with a type and a character status target
		 * if the status is directed.
		 * @param	statusType		The type of the status.
		 * @param	towardCharacter	The character the status is directed to.
		 */
		public function addStatus(statusType:int = 0, towardCharacter:GameObject = null, statusDuration:Number = 0):void 
		{
			var status:Status;
			var directedStatus:Status;
			var type:int;

			//if the type is a status category
			if (statusType < Status.FIRST_NOT_DIRECTED_STATUS)
			{
				//apply all statuses in that category
				for each (type in Status.CATEGORIES[statusType])
				{
					var haveStatus:Boolean = false;
					// Check to see if the character already has this status
					for each (status in this.statuses)
					{
						if (statusType == status.type && towardCharacter.name.toLowerCase() == status.directedToward.toLowerCase())
						{
							haveStatus = true;
							break;
						}
					}
					if (haveStatus) break;
					
					if (!this.getStatus(type, towardCharacter))
					{
						Debug.debug(this,"addStatus() HEY! Don't do this! Don't add category statuses, it's just weird.");
						status = new Status();
						status.type = type;
						if (statusDuration > 0)
						{
							status.hasDuration = true;
							status.initialDuration = statusDuration;
						}
						else
						{
							status.hasDuration = false;
						}
						
						// Setup status partner
						status.partnerType = status.getStatusPartner();
						if (status.partnerType != -1) {
							status.hasPartner = true;
						}
						
						if (status.type >= Status.FIRST_DIRECTED_STATUS)
						{
							if (!towardCharacter) Debug.debug(this, "addStatus(): Tried to add a directed status without providing a target GameObject.");
							else status.directedToward = towardCharacter.name;							
						}
						//Debug.debug(this, "addStatus(): status added to " + this.name + " - " + Status.getStatusNameByNumber(statusType) + " " + statusType ); 
						//this.statuses[statusType] = status;

						this.statuses.push(status);

						// Add the partner
						// Must happen after the status is pushed so that we don't get into an infinite loop
						if (status.hasPartner) { // Only directed statuses have partners
							CiFSingleton.getInstance().getGameObjByName(status.directedToward).addStatus(status.partnerType, this, statusDuration);
						}
					}
				}
			}
			else
			{	
				// Make sure the character does not already have this status
				for each (status in this.statuses)
				{
					if (statusType == status.type)
					{
						if (statusType >= Status.FIRST_DIRECTED_STATUS && towardCharacter.name.toLowerCase() == status.directedToward.toLowerCase())
							return;
						if (statusType < Status.FIRST_DIRECTED_STATUS)
							return;
					}
				}
				status = new Status();
				status.type = statusType;
				
				// if the person already has this status, update the duration
				if (this.getStatus(statusType, towardCharacter))
				{
					var statusD:Status = this.getStatus(statusType, towardCharacter);
					if (statusD.hasDuration && statusDuration > 0)
					{
						statusD.hasDuration = true;
						statusD.remainingDuration = statusDuration;
					}
					return;
				}
				
				// Initialize Duration if it has one
				if (statusDuration > 0)
				{
					status.hasDuration = true;
					status.initialDuration = statusDuration;
					status.remainingDuration = status.initialDuration;
				} else if (Status.CATEGORIES[Status.CAT_HAS_DURATION].indexOf(status.type) >= 0) { 
					status.hasDuration = true;
					status.initialDuration = 5; //(April) Arbitrary
					status.remainingDuration = status.initialDuration;
				}
				
				// Setup status partner
				status.partnerType = status.getStatusPartner();
				if (status.partnerType != -1) {
					status.hasPartner = true;
				}
					
				//if (status.isDirected)
				if (status.type >= Status.FIRST_DIRECTED_STATUS)
				{
					if (!towardCharacter) Debug.debug(this, "addStatus(): Tried to add a directed status without providing a target GameObject.");
					else status.directedToward = towardCharacter.name;
					
				}
				//Debug.debug(this, "addStatus(): status added to " + this.name + " - " + Status.getStatusNameByNumber(statusType) + " " + statusType ); 
				//this.statuses[statusType] = status;
				this.statuses.push(status);
				
				// Add the partner
				// Must happen after the status is pushed so that we don't get into an infinite loop
				if (status.hasPartner) { // Only directed statuses have partners
					CiFSingleton.getInstance().getGameObjByName(status.directedToward).addStatus(status.partnerType, this, statusDuration);
				}
			}
		}
		
		/**
		 * Removes a status from the character according to status type.
		 * @param	statusType	The type of status to remove.
		 */
		public function removeStatus(statusType:int = 0, towardCharacter:GameObject = null):void {
			//if the type is a status category
			var i:int = 0;
			var j:int = 0;
			var status:Status;
			if (statusType <= Status.LAST_CATEGORY_COUNT)
			{
				//delete all statuses in that category
				for each (var type:int in Status.CATEGORIES[statusType])
				{
					for (i = 0; i < this.statuses.length; i++ )
					{
						status = new Status();
						//status.directedToward //??????
						if (this.statuses[i].type == statusType)
						{
							if (statusType >= Status.FIRST_DIRECTED_STATUS)
							{
								if (this.statuses[i].directedToward.toLowerCase() == towardCharacter.name.toLowerCase())
								{
									this.statuses.splice(i, 1);
									if (status.type >= 	Status.FIRST_RELATIONSHIP_STATUS && status.type < (Status.FIRST_RELATIONSHIP_STATUS + Status.RELATIONSHIP_STATUS_COUNT))
									{
										// Relationship status, remove it from the directed person too
										for (j = 0; j < towardCharacter.statuses.length; j++)
										{
											if (towardCharacter.statuses[j].type == statusType)
											{
												towardCharacter.statuses.splice(j, 1);
												break;
											}
										}
									}
								}
							}
							else
							{
								//not directed
								this.statuses.splice(i, 1);
							}
							break;
						}
					}
				}
			}
			else
			{
				for (i = 0; i < this.statuses.length; i++ )
				{
					//status.directedToward //??????
					if (this.statuses[i].type == statusType)
					{
						if (statusType >= Status.FIRST_DIRECTED_STATUS)
						{
							if (this.statuses[i].directedToward.toLowerCase() == towardCharacter.name.toLowerCase())
							{
								this.statuses.splice(i, 1);
								if (statusType >= Status.FIRST_RELATIONSHIP_STATUS && statusType < (Status.FIRST_RELATIONSHIP_STATUS + Status.RELATIONSHIP_STATUS_COUNT))
								{
									// Relationship status, remove it from the directed person too
									for (j = 0; j < towardCharacter.statuses.length; j++)
									{
										if (towardCharacter.statuses[j].type == statusType)
										{
											trace(towardCharacter.name + " removing status " + Status.getStatusNameByNumber(statusType) + " from " + this.name);
											towardCharacter.statuses.splice(j, 1);
											break;
										}
									}
								}
							}
						}
						else
						{
							//not directed
							this.statuses.splice(i, 1);
						}
						break;
					}
				}
			}
		}
		
		/**
		 * Returns the status if the character has it
		 * 
		 */
		public function getStatus(statusID:int, towardChar:GameObject=null):Status
		{
			for each (var status:Status in this.statuses)
			{
				if (statusID == status.type)
				{
					if (statusID >= Status.FIRST_DIRECTED_STATUS)
					{
						if (towardChar)
						{
							if (status.directedToward.toLocaleLowerCase() == towardChar.name.toLowerCase())
							{
								return status;	
							}
						}
					}
					else
					{
						return status;
					}
				}
			}
			
			//Debug.debug(this,"getStatus() "+this.name+" does not have the status "+Status.getStatusNameByNumber(statusID));
			
			return null;
		}
		 
		/**
		 * Updates the duration of all statuses held by the character. Removes
		 * statuses that have 0 or less remaining duration.
		 * 
		 * TODO: add the status removal to the SFDB.
		 * 
		 * @param	timeElapsed	The amount of time to remove from the statuses.
		 */
		public function updateStatusDurations(timeElapsed:int = 1):void 
		{
			for each (var status:Status in this.statuses) 
			{
				// Check if the status has a duration to update
				if (status.hasDuration)
				{
					status.remainingDuration -= timeElapsed;
					if (status.remainingDuration <= 0) 
					{
						removeStatus(status.type,CiFSingleton.getInstance().cast.getCharByName(status.directedToward));
					}
				}
				// (April) Increment urge strength if the tick duration is complete
				if (status.isUrge) {
					status.remainingUrgeTickDuration -= timeElapsed;
					if (status.remainingUrgeTickDuration <= 0) {
						status.urgeStrength++;
						trace(name + "'s " + Status.getStatusNameByNumber(status.type) + " increased; is now " + status.urgeStrength);
						status.remainingUrgeTickDuration = status.totalUrgeTickDuration;
					}
				}
			}
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		public function toString(): String{
			var returnstr:String = new String();
			var switchType:Number = this.type;
			
			switch(switchType) {
				case GameObject.TYPE_CHARACTER: 
					returnstr = new String();
					returnstr += "Charater";
					break;
				case GameObject.TYPE_ITEM:
					returnstr = new String();
					returnstr += "Item";
					break;
				case GameObject.TYPE_KNOWLEDGE:
					returnstr = new String();
					returnstr += "Knowledge";
					break;
				
				default:
					Debug.debug(this, "tried to make a GameObject of unknown type a String.");
					return "";
			}
			return returnstr;

		}
		
		public function toXML():XML {
			var returnXML:XML;
			var status:Status;
			returnXML = <GameObject name={this.name} networkID={this.networkID} type={this.type}/>;
			for each (var traitType:Number in this.traits) {
				returnXML.appendChild(<Trait type={Trait.getNameByNumber(traitType)} />);
			}
			for each(status in this.statuses) {
				//status = this.statuses[key] as Status;
				returnXML.appendChild(<Status type={Status.getStatusNameByNumber(status.type)} from={this.name} to={status.directedToward} />);
			}
			return returnXML;
		}
		 
		public function toXMLString():String {
			return this.toXML().toXMLString();
		}
		
		public function cloneGameObject():GameObject {
			var GO:GameObject = new GameObject();
			GO.name = this.name;
			GO.traits = new Vector.<Number>();
			for each(var l:Trait in this.traits) {
				GO.traits.push(l.cloneTraits());
			}
			
			for each(var r:Status in this.statuses) {
				GO.statuses.push(r.cloneStatus());
			}
			GO.networkID = this.networkID;
			GO.type = this.type;
			GO.examineLine = this.examineLine;
			GO.discussNeutral = this.discussNeutral;
			GO.discussLike = this.discussLike;
			GO.discussLove = this.discussLove;
			GO.discussHate = this.discussHate;
			return GO;
		}
		
		public static function equals(x:GameObject, y:GameObject): Boolean {
			if (x.traits.length !=y.traits.length) return false;
			for (var i:Number = 0; i < x.traits.length; ++i) {
				if ((x.traits[i] != y.traits[i])) return false;
			}
			if (x.name != y.name) return false;
			if (x.networkID != y.networkID) return false;
			if (x.type != y.type) return false;
			return true;
		}
		
	}
	
}