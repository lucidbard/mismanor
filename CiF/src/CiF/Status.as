package CiF 
{
	/**
	 * 
	 */
	public class Status
	{
		/**
		 * The default initial duration of a status.
		 */
		public static const DEFAULT_INITIAL_DURATION:int = 999999999;
		
		
		//The first ones (through FIRST_NOT_DIRECTED_STATUS are status categories)
		public static const CAT_FEELING_GOOD:int = 0;
		public static const CAT_FEELING_GOOD_ABOUT_SOMEONE:int = 1;
		public static const LAST_POS_CAT_STATUS: int = 1;
		
		public static const CAT_FEELING_BAD:int = 2;
		public static const CAT_FEELING_BAD_ABOUT_SOMEONE:int = 3;
		public static const CAT_REPUTATION_BAD:int = 4;
		public static const LAST_NEG_CAT_STATUS: int = 4;
		
		public static const CAT_USABLE_ITEM_STATUS:int = 5;
		public static const CAT_HAS_DURATION:int = 6;
		public static const CAT_URGE_STATUSES:int = 7;
		
		public static const LAST_CATEGORY_COUNT:int = 7;
		public static const FIRST_NOT_DIRECTED_STATUS:int = 8;
		
		public static const EXCITED:int = 8;
		public static const CHEERFUL:int = 9;
		public static const TIPSY:int = 10;
		public static const VIRGIN:int = 11;
		public static const LAST_GOOD_STATUS:int = 11;
		
		public static const EMBARRASSED:int = 12;
		public static const SHAKEN:int = 13;
		public static const SAD:int = 14;
		public static const ANXIOUS:int = 15;
		public static const GUILTY:int = 16;
		public static const HEARTBROKEN:int = 17;
		public static const CONFUSED:int = 18;
		public static const DRUNK:int = 19;
		public static const VULNERABLE:int = 20;
		public static const OFFENDED:int = 21;
		public static const DISTRACTED:int = 22;
		public static const BUSY:int = 23;
		public static const LAST_BAD_STATUS: int = 23;
		
		// Item statuses
		public static const FIRST_ITEM_STATUS:int = 24;
		public static const DRINKABLE:int = 24;
		public static const EATABLE:int = 25;
		public static const WEARABLE:int = 26;
		public static const OPEN:int = 27;
		public static const CLOSED:int = 28;
		public static const LOCKED:int = 29;
		public static const UNLOCKED:int = 30;
		public static const HIDDEN:int = 31;
		public static const ITEM_STATUS_COUNT:int = 8;
		
		// Knowledge statuses
		public static const FIRST_KNOWLEDGE_STATUS:int = 32;
		public static const ACTIVE:int = 32;
		public static const TRUE:int = 33;
		public static const FALSE:int = 34;
		
		public static const FIRST_URGE_STATUS:int = 35;
		public static const QUEST_TYPE_URGE:int = 35;
		public static const CHARACTER_TYPE_URGE:int = 36;
		public static const ITEM_TYPE_URGE:int = 37;
		public static const KNOWLEDGE_TYPE_URGE:int = 38;
		public static const URGE_STATUS_COUNT:int = 4;
		
		public static const FIRST_DIRECTED_STATUS:int = 39;

		public static const GRATEFUL_TOWARD:int = 39; //bright green		
		public static const LAST_DIRECTED_POS:int = 39;
		
		public static const ANGRY_AT:int = 40; //dark red
		public static const PITIES:int = 41; //light blue
		public static const ENVIES:int = 42; //green
		public static const AFRAID_OF:int = 43;
		public static const RESENTFUL_TOWARD:int = 44;
		public static const ESTRANGED_FROM:int = 45;
		public static const LAST_DIRECTED_NEG:int = 45;
		
		// LIKES is in item bit below
		public static const LOVES:int = 46;
		public static const HATES:int = 47;
		public static const MANIPULATING:int = 48;
		public static const RESPECT_TOWARD:int = 49;
		
		// People statuses concerning items (all directional)
		public static const WANTS:int = 50;
		public static const LIKES:int = 51;
		public static const DISLIKES:int = 52;
		public static const IS_HOLDING:int = 53;
		public static const IS_WEARING:int = 54;
		
		// Directed statuses concerning Knowledge
		public static const KNOWS:int = 55; 
		public static const KNOWN_BY:int = 56;

		public static const FIRST_ITEM_DIRECTED_STATUS:int = 57;
		
		// Directed
		public static const HELD_BY:int = 57;
		public static const WORN_BY:int = 58;
		public static const ITEM_DIRECTED_STATUS_COUNT:int = 2;
		
		// New Relationships
		public static const FIRST_RELATIONSHIP_STATUS:int = 59;
		public static const IS_DATING:int = 59;
		public static const IS_RELATED_TO:int = 60;
		public static const ELOPED_WITH:int = 61;
		public static const IS_FRIENDS_WITH:int = 62;
		public static const LAST_POS_REL_STATUS:int = 62;
		
		public static const IS_ENEMIES_WITH:int = 63;
		public static const LAST_NEG_REL_STATUS:int = 63;
		public static const RELATIONSHIP_STATUS_COUNT:int = 5;
		
		public static const STATUS_COUNT:int = 64;
	
        public static const CATEGORIES:Object = new Object()
        // This block is run once when the class is first accessed
        {
            CATEGORIES[Status.CAT_FEELING_BAD] = new Array(Status.EMBARRASSED, Status.SHAKEN, Status.SAD, Status.ANXIOUS, Status.GUILTY, Status.CONFUSED);
            CATEGORIES[Status.CAT_FEELING_GOOD] = new Array(Status.EXCITED, Status.CHEERFUL);
            CATEGORIES[Status.CAT_FEELING_BAD_ABOUT_SOMEONE] = new Array(Status.ANGRY_AT, Status.ENVIES, Status.AFRAID_OF);
            CATEGORIES[Status.CAT_FEELING_GOOD_ABOUT_SOMEONE] = new Array(Status.GRATEFUL_TOWARD);
			CATEGORIES[Status.CAT_REPUTATION_BAD] = new Array();
			CATEGORIES[Status.CAT_HAS_DURATION] = new Array(Status.SHAKEN, Status.HEARTBROKEN, Status.DRUNK, Status.TIPSY, Status.OFFENDED);
			CATEGORIES[Status.CAT_USABLE_ITEM_STATUS] = new Array(Status.DRINKABLE, Status.EATABLE, Status.WEARABLE, Status.OPEN, Status.CLOSED, Status.LOCKED, Status.UNLOCKED);
			CATEGORIES[Status.CAT_URGE_STATUSES] = new Array(Status.QUEST_TYPE_URGE, Status.CHARACTER_TYPE_URGE, Status.ITEM_TYPE_URGE, Status.KNOWLEDGE_TYPE_URGE);
		}
		
		/**
		 * The type of this instance of Status.
		 */
		public var type:int;
		/**
		 * The name of the character the status is directed toward.
		 */
		public var directedToward:String;
		/** (April)
		 * If true, this status has a partner that should be on the directed toward object
		 */
		public var hasPartner:Boolean;
		/** (April)
		 * If the trait has a partner, reference it through this variable (saves time?) 
		 */
		public var partnerType:int = -1;
		/**
		 * If the status has a duration to decrement
		 */
		public var hasDuration:Boolean = false;
		/**
		 * The how long the status will be in effect after it is placed.
		 */
		public var initialDuration:int;
		/**
		 * How long the status has before it is removed.
		 */
		public var remainingDuration:int;
		/** (April)
		 * Urge strength (the higher it is, the more the character wants to perform an action of that type)
		 */
		public var urgeStrength:int = 0;
		/** (April)
		 * The total amount of time it takes for the urge strength to increment by one
		 */
		public var totalUrgeTickDuration:int = 3;
		/** (April)
		 * How long the urge has before it is incremented
		 */
		public var remainingUrgeTickDuration:int = 3;
		
		public function Status() {
			this.type = EMBARRASSED;
			this.directedToward = "";
			this.initialDuration = DEFAULT_INITIAL_DURATION;
			this.remainingDuration = this.initialDuration;
			// (April) Realized this won't ever work -- gotta be in add status
			/*if (CATEGORIES[Status.CAT_HAS_DURATION].indexOf(this.type) >= 0) { 
				this.hasDuration = true;
				this.initialDuration = 5; //(April) Arbitrary
			}*/
		}
		
		public function clean(): void
		{
			this.directedToward = null;		
		}
		/** April
		 * Checks if the status is an urge
		 */
		public function get isUrge():Boolean {
			if (CATEGORIES[Status.CAT_URGE_STATUSES].indexOf(this.type) >= 0) return true;
			return false;
		}
		
		public function get isDirected():Boolean {
			if (FIRST_DIRECTED_STATUS <= this.type || this.type == Status.CAT_FEELING_BAD_ABOUT_SOMEONE || this.type == Status.CAT_FEELING_GOOD_ABOUT_SOMEONE) return true;
			return false;
		}
		
		public function cloneStatus():Status {
			var p:Status = new Status();
			p.type = this.type;
			p.directedToward = this.directedToward;
			p.hasPartner = this.hasPartner;
			p.partnerType = this.partnerType;
			p.hasDuration = this.hasDuration;
			p.initialDuration = this.initialDuration;
			p.remainingDuration = this.remainingDuration;
			p.urgeStrength = this.urgeStrength;
			p.totalUrgeTickDuration = this.totalUrgeTickDuration;
			p.remainingUrgeTickDuration = this.remainingUrgeTickDuration;
			return p;
		}
			
		public function getStatusPartner(n:int = -1):Number {
			var statusID:Number;
			
			if (n != -1) statusID = n;
			else statusID = type;
			
			switch(statusID) {
				case Status.IS_HOLDING:
					return Status.HELD_BY;
				case Status.HELD_BY:
					return Status.IS_HOLDING;
				
				case Status.IS_WEARING:
					return Status.WORN_BY;
				case Status.WORN_BY:
					return Status.IS_WEARING;
					
				case Status.KNOWS:
					return Status.KNOWN_BY;
				case Status.KNOWN_BY:
					return Status.KNOWS;
					
				// relationships
				case Status.IS_DATING:
					return Status.IS_DATING;
				case Status.IS_FRIENDS_WITH:
					return Status.IS_FRIENDS_WITH;
				case Status.IS_ENEMIES_WITH:
					return Status.IS_ENEMIES_WITH;
				case Status.IS_RELATED_TO:
					return Status.IS_RELATED_TO;
				case Status.ELOPED_WITH:
					return Status.ELOPED_WITH;
					
				default:
					return -1;
			}
		}
		
		/**
		 * 
		 * @param	n A status numeric representation
		 * @return Returns true if the status is designated as a "positive" status, false if it is
		 * considered a "negative" status
		 * 
		 */
		public static function isStatusPositive(n:int):Boolean {
			var posStatus:Boolean = false;
			
			// is it a positive category
			if (n <= Status.LAST_POS_CAT_STATUS)
				return true;
			
			// is it a positive non-directed status
			if (n >= Status.FIRST_NOT_DIRECTED_STATUS && n <= Status.LAST_GOOD_STATUS)
				return true;
				
			// is it a positive directed status
			if (n >= Status.FIRST_DIRECTED_STATUS && n <= Status.LAST_DIRECTED_POS)
				return true;
				
			// is it a positive relationship status
			if (n >= Status.FIRST_RELATIONSHIP_STATUS && n <= Status.LAST_POS_REL_STATUS)
				return true;
				
			// not any positive status, so return false
			// NOTE: This is a bit misleading as there are some statuses which are neither good nor bad
			return false;
		}
		
		/**
		 * Returns a status name when called with a status constant.
		 * 
		 * @param	n	A status numeric representation.
		 * @return The String representation of the status denoted by the first
		 * parameter or an empty string if the number did not match a status.
		 */
		public static function getStatusNameByNumber(n:int):String {
			
			switch(n) {
				case Status.CAT_FEELING_BAD:
					return "cat: feeling bad";
				case Status.CAT_FEELING_GOOD:
					return "cat: feeling good";
				case Status.CAT_FEELING_BAD_ABOUT_SOMEONE:
					return "cat: feeling bad about someone";
				case Status.CAT_FEELING_GOOD_ABOUT_SOMEONE:
					return "cat: feeling good about someone";
				case Status.CAT_REPUTATION_BAD:
					return "cat: reputation bad";
				case Status.CAT_HAS_DURATION:
					return "cat: reputation good";
				case Status.CAT_USABLE_ITEM_STATUS:
					return "cat: usable item";
				case Status.CAT_URGE_STATUSES:
					return "cat: urge";
				
				case Status.EMBARRASSED:
					return "embarrassed";
				case Status.SHAKEN:
					return "shaken";
				case Status.EXCITED:
					return "excited";
				case Status.SAD:
					return "sad";
				case Status.ANXIOUS:
					return "anxious";
				case Status.GUILTY:
					return "guilty";
				case Status.HEARTBROKEN:
					return "heartbroken";
				case Status.CHEERFUL:
					return "cheerful";
				case Status.CONFUSED:
					return "confused";
				case Status.TIPSY:
					return "tipsy";
				case Status.DRUNK:
					return "drunk";
				case Status.VIRGIN:
					return "virgin";
				case Status.VULNERABLE:
					return "vulnerable";
				case Status.OFFENDED:
					return "offended";
				case Status.DISTRACTED:
					return "distracted";
				case Status.BUSY:
					return "busy";
					
				case Status.QUEST_TYPE_URGE:
					return "quest type urge";
				case Status.CHARACTER_TYPE_URGE:
					return "character type urge";
				case Status.ITEM_TYPE_URGE:
					return "item type urge";
				case Status.KNOWLEDGE_TYPE_URGE:
					return "knowledge type urge";
					
				case Status.ANGRY_AT:
					return "angry at";
				case Status.PITIES:
					return "pities";
				case Status.ENVIES:
					return "envies";
				case Status.GRATEFUL_TOWARD:
					return "grateful toward";
				case Status.AFRAID_OF:
					return "afraid of";
				case Status.RESENTFUL_TOWARD:
					return "resentful toward";
				case Status.ESTRANGED_FROM:
					return "estranged from";
				case Status.LOVES:
					return "loves";
				case Status.HATES:
					return "hates";
				case Status.MANIPULATING:
					return "manipulating";
				case Status.RESPECT_TOWARD:
					return "respect toward";
				
				case Status.WANTS:
					return "wants";
				case Status.LIKES:
					return "likes";
				case Status.DISLIKES:
					return "dislikes";
				case Status.IS_HOLDING:
					return "is holding";
				case Status.IS_WEARING:
					return "is wearing";
					
				case Status.KNOWS:
					return "knows";
				case Status.KNOWN_BY:
					return "known by";
					
				case Status.HIDDEN:
					return "hidden";
				case Status.DRINKABLE:
					return "drinkable";
				case Status.EATABLE:
					return "eatable";
				case Status.WEARABLE:
					return "wearable";
				case Status.OPEN:
					return "open";
				case Status.CLOSED:
					return "closed";
				case Status.LOCKED:
					return "locked";
				case Status.UNLOCKED:
					return "unlocked";
				case Status.HELD_BY:
					return "held by";
				case Status.WORN_BY:
					return "worn by";
					
				case Status.ACTIVE:
					return "active";
				case Status.TRUE:
					return "true";
				case Status.FALSE:
					return "false";
					
				case Status.IS_DATING:
					return "is dating";
				case Status.IS_FRIENDS_WITH:
					return "is friends with";
				case Status.IS_ENEMIES_WITH:
					return "is enemies with";
				case Status.IS_RELATED_TO:
					return "is related to";
				case Status.ELOPED_WITH:
					return "eloped with";
				default:
					return "";
			}
		}
		
		/**
		 * Returns the string name of a status given the number representation
		 * of that status.
		 *  
		 * @param	name	The name of the status.
		 * @return The number that corresponds to the name of the status or -1
		 * if the name did not correspond to a status.
		 */
		public static function getStatusNumberByName(name:String):int {
			switch(name.toLowerCase()) {
			//switch(name) {
				case "cat: feeling bad":
					return Status.CAT_FEELING_BAD;
				case "cat: feeling good":
					return Status.CAT_FEELING_GOOD;
				case "cat: feeling bad about someone":
					return Status.CAT_FEELING_BAD_ABOUT_SOMEONE;
				case "cat: feeling good about someone":
					return Status.CAT_FEELING_GOOD_ABOUT_SOMEONE;
				case "cat: reputation bad":
					return Status.CAT_REPUTATION_BAD;
				case "cat: reputation good":
					return Status.CAT_HAS_DURATION;
				case "cat: usable item":
					return Status.CAT_USABLE_ITEM_STATUS;
				case "cat: urge":
					return Status.CAT_URGE_STATUSES;
					
				case "embarrassed":
					return Status.EMBARRASSED;
				case "shaken":	
					return Status.SHAKEN;
				case "excited":	
					return Status.EXCITED;
				case "sad":
					return Status.SAD;
				case "anxious":	
					return Status.ANXIOUS;
				case "guilty":	
					return Status.GUILTY;
				case "heartbroken":	
					return Status.HEARTBROKEN;
				case "cheerful":	
					return Status.CHEERFUL;						
				case "confused":	
					return Status.CONFUSED;
				case "tipsy":
					return Status.TIPSY;
				case "drunk":
					return Status.DRUNK;
				case "virgin":
					return Status.VIRGIN;
				case "vulnerable":
					return Status.VULNERABLE;
				case "offended":
					return Status.OFFENDED;
				case "distracted":
					return Status.DISTRACTED;
				case "busy":
					return Status.BUSY;
					
				case "quest type urge":
					return Status.QUEST_TYPE_URGE;
				case "character type urge":
					return Status.CHARACTER_TYPE_URGE;
				case "item type urge":
					return Status.ITEM_TYPE_URGE;
				case "knowledge type urge":
					return Status.KNOWLEDGE_TYPE_URGE;
					
				case "angry at":	
					return Status.ANGRY_AT;
				case "pities":
					return Status.PITIES;
				case "envies":
					return Status.ENVIES;
				case "grateful toward":
					return Status.GRATEFUL_TOWARD;
				case "afraid of":
					return Status.AFRAID_OF;
				case "resentful toward":
					return Status.RESENTFUL_TOWARD;
				case "estranged from":
					return Status.ESTRANGED_FROM;
				case "loves":
					return Status.LOVES;
				case "hates":
					return Status.HATES;
				case "manipulating":
					return Status.MANIPULATING;
				case "respect toward":
					Status.RESPECT_TOWARD;
					
				case "wants":
					return Status.WANTS;
				case "likes":
					return Status.LIKES;
				case "dislikes":
					return Status.DISLIKES;
				case "is holding":
					return Status.IS_HOLDING;
				case "is wearing":
					return IS_WEARING;
					
				case "knows":
					return Status.KNOWS;
				case "known by":
					return Status.KNOWN_BY;
					
				case "hidden":
					return Status.HIDDEN;
				case "drinkable":
					return Status.DRINKABLE;
				case "eatable":
					return Status.EATABLE;
				case "wearable":
					return Status.WEARABLE;
				case "open":
					return Status.OPEN;
				case "closed":
					return Status.CLOSED;
				case "locked":
					return Status.LOCKED;
				case "unlocked":
					return Status.UNLOCKED;
				case "held by":
					return Status.HELD_BY;
				case "worn by":
					return Status.WORN_BY;
					
				case "active":
					return Status.ACTIVE;
				case "true":
					return Status.TRUE;
				case "false":
					return Status.FALSE;
					
				case "is dating":
					return Status.IS_DATING;
				case "is friends with":
					return Status.IS_FRIENDS_WITH;
				case "is enemies with":
					return Status.IS_ENEMIES_WITH;
				case "is related to":
					return Status.IS_RELATED_TO;
				case "eloped with":
					return Status.ELOPED_WITH;
					
				default:
					return -1;
			}
			

		}
	}
}