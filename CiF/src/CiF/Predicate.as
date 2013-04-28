package CiF 
{
	/**
	 * The Predicate class is the terminal and functional end of the logic
	 * constructs in CiF. All rules, influence rules, rule sets, and social
	 * changes are composed of predicates.
	 * 
	 * <p>Predicates have two major functions: evaluation (to determine truth
	 * given the current social state) and valuation (to modify the current
	 * social state). Each type of predicate has its own valuation and evaluation
	 * functions to enact the logical statement within CiFs data structures.</p>
	 * 
	 * TODO: TESTING!!!!
	 * TODO: Finish evaluation for SFDBLABEL types.
	 */
	public class Predicate
	{
		public static var creationCount:Number = 0.0;
		public static var evaluationCount:Number = 0.0;
		public static var valuationCount:Number = 0.0;
		public static var evalutionComputationTime:Number = 0.0;
		
		/**
		 * The number of distinct predicate types.
		 */
		
		public static const TRAIT:Number = 0;
		public static const NETWORK:Number= 1;
		public static const STATUS:Number = 2;
		public static const CKBENTRY:Number = 3;
		public static const SFDBLABEL:Number = 4;
		//public static const RELATIONSHIP:Number = 5;
		
/*		public static const CURRENTSOCIALGAME:Number = 6;
		public static const KNOWLEDGE:Number = 7;
		public static const GIVEKNOWLEDGE: Number = 8;*/
		
		public static const TYPE_COUNT:Number = 5;
		
		public static const NEGATE:Boolean = true;
		
		/**
		 * The number of distinct social network comparators.
		 */
		public static const COMPARATOR_COUNT:Number = 6;
		//Network comparision operators (a.k.a. comparators).
		public static const LESSTHAN:Number = 0;
		public static const GREATERTHAN:Number = 1;
		public static const AVERAGEOPINION:Number = 2;
		public static const FRIENDSOPINION:Number = 3;
		public static const DATINGOPINION:Number = 4;
		public static const ENEMIESOPINION:Number = 5;
		
		/**
		 * The number of social change operators over social networks.
		 */
		public static const OPERATOR_COUNT:Number = 8;
		//network operators
		public static const ADD:Number = 0;
		public static const SUBTRACT:Number = 1;
		public static const MULTIPLY:Number = 2;
		public static const ASSIGN:Number = 3;
		public static const EVERYONEUP:Number = 4;
		public static const ALLFRIENDSUP:Number = 5;
		public static const ALLDATINGUP:Number = 6;
		public static const ALLENEMYUP:Number = 7;
		
		
		// The following numbers are for referenceing the twelve intent types
		// These are used for the design tool
		public static const INTENT_NETWORK_UP:Number = 0;
		public static const INTENT_NETWORK_DOWN:Number = 1;
		public static const INTENT_ADD_STATUS:Number = 2;
		public static const INTENT_REMOVE_STATUS:Number = 3;
		public static const NUM_INTENT_TYPES:Number = 4;
		
		// Not using these with Mismanor, so putting them at the end, out of reach
		public static const INTENT_BUDDY_UP:Number = 6;
		public static const INTENT_BUDDY_DOWN:Number = 8;
		public static const INTENT_ROMANCE_UP:Number = 9;
		public static const INTENT_ROMANCE_DOWN:Number = 10;
		public static const INTENT_TRUST_UP:Number = 11;
		public static const INTENT_TRUST_DOWN:Number = 12;
		public static const INTENT_FAMILYBOND_UP:Number = 13;
		public static const INTENT_FAMILYBOND_DOWN:Number = 14;
		public static const INTENT_FRIENDS:Number = 15;
		public static const INTENT_END_FRIENDS:Number = 16;
		public static const INTENT_DATING:Number = 17;
		public static const INTENT_END_DATING:Number = 18;
		public static const INTENT_ENEMIES:Number = 5;
		public static const INTENT_END_ENEMIES:Number = 7;
		
		public var name:String;
		public var description:String;
		public var intentType:Number;
		public var type:Number;
		public var trait:Number;
		public var primary:String;
		public var secondary:String;
		public var tertiary:String;
		public var networkValue:Number;
		public var comparator:String;
		public var operator:String;
		public var relationship:Number;
		public var status:Number;
		public var networkType:Number;
		public var firstSubjectiveLink:String;
		public var secondSubjectiveLink:String;
		public var truthLabel:String;
		public var sfdbOrder:int;
		public var statusDuration:Number;
		
		/**
		 * True if the truth value of the predicate should be negated.
		 */
		public var negated:Boolean;
		/**
		 * Flag marking the predicate as an SFDB lookup if true.
		 */
		public var isSFDB:Boolean;
		/**
		 * Size of the window in the SFDB 
		 */
		public var window:Number;
		/**
		 * The SFDB effect label to lookup.
		 */
		public var sfdbLabel:Number;
		/**
		 * If the predicate should be viewed as intent rather than literal.
		 */
		public var intent:Boolean;
		/**
		 * The name of the current social game to check for.
		 */
		public var currentGameName:String;
		
		/**
		 * Flag that specifies if this is a number of times this pred is uniquely true type pred
		 */
		public var numTimesUniquelyTrueFlag:Boolean;
		
		/**
		 * The number of times this pred needs to be uniquely true
		 */
		public var numTimesUniquelyTrue:int;
		
		/**
		 * What role slots we want to compare against for numTimesUniquely check
		 */
		public var numTimesRoleSlot:String;
		/**
		 * The specific item
		 */
		public var knowledge:Number;
		public var item:Number;
		
		public function Predicate() {
			this.name = "";
			this.description = "";
			this.intentType = -1;
			this.type = -1;
			this.trait = -1;
			this.primary = "";
			this.secondary = "";
			this.tertiary = "";
			this.networkValue = 0;
			this.comparator = "~";
			this.status = -1;
			this.statusDuration = -1;
			this.networkType = -1;
			this.firstSubjectiveLink = "";
			this.secondSubjectiveLink = "";
			this.truthLabel = "";
			this.negated = false;
			this.window = 0;
			this.isSFDB = false;
			this.sfdbLabel = -1;
			this.intent = false;
			this.currentGameName = "";
			this.numTimesUniquelyTrueFlag = false;
			this.numTimesUniquelyTrue = 0;
			this.numTimesRoleSlot = "";
			this.knowledge = -1;
			this.item = -1;
			this.sfdbOrder = 0;
			Predicate.creationCount++;
		}
		
		public function clean(): void {
			this.name = null;
			this.description = null;
			this.primary = null;
			this.secondary = null;
			this.tertiary = null;
			this.comparator = null;
			this.firstSubjectiveLink = null;
			this.secondSubjectiveLink = null;
			this.truthLabel = null;
			this.currentGameName = null;
			this.numTimesRoleSlot = null;
		}
		/**********************************************************************
		 * Predicate meta information.
		 *********************************************************************/
		
		/**
		 * Given the integer representation of a Predicate type, this function
		 * returns the String representation of that type. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * Predicate.getNameByType(Predicate.TRAIT); //returns "trait"
		 * </listing>
		 * @param	type The Predicate type as an integer.
		 * @return The string representation of the Predicate type.
		 */
		public static function getNameByType(t:Number):String {
			switch (t) {
				case Predicate.TRAIT:
					return "trait";
				case Predicate.NETWORK:
					return "network";
				case Predicate.STATUS:
					return "status";
				case Predicate.CKBENTRY:
					return "CKB";
				case Predicate.SFDBLABEL:
					return "SFDBLabel";
				//case Predicate.RELATIONSHIP:
					//return "relationship";
/*				case Predicate.CURRENTSOCIALGAME:
					return "currentSocialGame";
				case Predicate.KNOWLEDGE:
					return "knowledge";
				case Predicate.GIVEKNOWLEDGE:
					return "giveknowledge";*/
				default:
					return "type not declared";
			}
		}
		
		public static function getTypeByName(name:String):Number {
			switch (name.toLowerCase()) {
				case "trait":
					return Predicate.TRAIT;
				case "network":
					return Predicate.NETWORK;
				case "status":
					return Predicate.STATUS;
				case "ckb":
					return Predicate.CKBENTRY;
				case "sfdblabel":
					return Predicate.SFDBLABEL;
				//case "relationship":
					//return Predicate.RELATIONSHIP;
/*				case "currentSocialGame":
					return Predicate.CURRENTSOCIALGAME;
				case "knowledge":
					return Predicate.KNOWLEDGE;
				case "giveknowledge":
					return Predicate.GIVEKNOWLEDGE;*/
				default:
					return -1;
			}
		}
		
		public static function getCompatorByNumber(n:Number):String {
			switch (n) {
				case Predicate.LESSTHAN:
					return "lessthan";
				case Predicate.GREATERTHAN:
					return "greaterthan";
				case Predicate.AVERAGEOPINION:
					return "AverageOpinion";
				case Predicate.FRIENDSOPINION:
					return "FriendsOpinion";
				case Predicate.DATINGOPINION:
					return "DatingOpinion";
				case Predicate.ENEMIESOPINION:
					return "EnemiesOpinion";
				default:
					return "";
			}
		/*
		 * public static const LESSTHAN:Number = 0;
		public static const GREATERTHAN:Number = 1;
		public static const AVEROPINION:Number = 2;
		public static const FRIENDSOPINION:Number = 3;
		public static const DATINGOPINION:Number = 4;
		public static const ENEMIESOPINION:Number = 5;
		*/
		}
		
		public static function getNumberFromComparator(name:String):Number {
			switch (name.toLowerCase()) {
				case "<":
				case "lessthan":
				case "less than":
				case "less":
					return Predicate.LESSTHAN;
				case ">":
				case "greaterthan":
				case "greater than":
				case "greater":
					return Predicate.GREATERTHAN;
				case "average opinion":
				case "averageopinion":
					return Predicate.AVERAGEOPINION;
				case "friendsopinion":
				case "friends opinion":
				case "friends'opinion":
				case "friends' opinion":
					return Predicate.FRIENDSOPINION;
				case "datingopinion":
				case "dates opinion":
				case "Dates' opinion":
				case "Date's opinion":
					return Predicate.DATINGOPINION;
				case "enemiesopinion":
				case "enemies opinion":
				case "enemies'opinion":
				case "enemy's opinion":
					return Predicate.ENEMIESOPINION;

				default:
					return -1;
			}
		}
		
		public static function getOperatorByNumber(n:Number):String {
			switch (n) {
				case Predicate.ADD:
					return "+";
				case Predicate.SUBTRACT:
					return "-";
				case Predicate.MULTIPLY:
					return "*";
				case Predicate.ASSIGN:
					return "=";
				case Predicate.EVERYONEUP:
					return "EveryoneUp";
				case Predicate.ALLFRIENDSUP:
					return "AllFriendsUp";
				case Predicate.ALLDATINGUP:
					return "AllDatingUp";
				case Predicate.ALLENEMYUP:
					return "AllEnemyUp";
				default:
					return "";
			}
		}
		
		public static function getOperatorByName(name:String):Number {
			switch (name.toLowerCase()) {
				case "+":
					return Predicate.ADD;
				case "-":
					return Predicate.SUBTRACT;
				case "*":
					return Predicate.MULTIPLY;
				case "=":
					return Predicate.ASSIGN;
				case "everyoneup":
					return Predicate.EVERYONEUP;
				case "allfriendsup":
					return Predicate.ALLFRIENDSUP;
				case "alldatingup":
					return Predicate.ALLDATINGUP;
				case "allenemyup":
					return Predicate.ALLENEMYUP;
				default:
					return -1;
			}
		}
		
		/**********************************************************************
		 * Getters and Setters
		 *********************************************************************/
		public function get first():String {
			return this.primary;
		}
		
		public function set first(n:String):void {
			this.primary = n;
		}
		
		public function get second():String {
			return this.secondary;
		}
		
		public function set second(g:String):void {
			this.secondary = g;
		}
		 
		/**********************************************************************
		 * Predicate initializers
		 *********************************************************************/
		
		/**
		 * Initializes this instance of the Predciate class as a trait or ~trait
		 * predicate.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setTraitPredicate("x", Trait.SEX_MAGNET, Predicate.NOTTRAIT);
		 * </listing>
		 * @param	first The character variable to which this predicate applies.
		 * @param	trait The enumerated representation of a trait.
		 * @param	isNegated True if the predicate is to be negated.
		 */
		
		public function setTraitPredicate(first:String="initiator", trait:Number=0, isNegated:Boolean = false, isSFDB:Boolean = false):void {
			this.type = Predicate.TRAIT;
			this.trait = trait;
			this.primary = first;
			this.negated = isNegated;
			this.isSFDB = isSFDB;
		}
		
		/**
		 * Initializes this instance of the Predciate class as a itemTrait or ~itemTrait
		 * predicate.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setItemTraitPredicate("initiator", "weddingband", Trait.IMPORTANT);
		 * </listing>
		 * @param	first The character (TODO: Can we remove this as a requirement?)
		 * @param	item The item we're checking
		 * @param	trait The enumerated representation of a trait.
		 * @param	isNegated True if the predicate is to be negated.
		 */
		/*
		public function setItemTraitPredicate(first:String="initiator", item:Item=null, trait:Number=0, isNegated:Boolean = false, isSFDB:Boolean = false):void {
			this.type = Predicate.ITEMTRAIT;
			this.item = item;
			this.trait = trait;
			this.primary = first;
			this.negated = isNegated;
			this.isSFDB = isSFDB;
		}
		*/
		/**
		 * Initializes this instance of the Predciate class as a itemTrait or ~itemTrait
		 * predicate.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setItemTraitPredicate("initiator", "weddingband", Trait.IMPORTANT);
		 * </listing>
		 * @param	first The character (TODO: Can we remove this as a requirement?)
		 * @param	item The item we're checking
		 * @param	trait The enumerated representation of a trait.
		 * @param	isNegated True if the predicate is to be negated.
		 */
		/*
		public function setKnowledgeTraitPredicate(first:String="initiator", knowledge:Knowledge=null, trait:Number=0, isNegated:Boolean = false, isSFDB:Boolean = false):void {
			this.type = Predicate.KNOWLEDGETRAIT;
			this.knowledge = knowledge;
			this.trait = trait;
			this.primary = first;
			this.negated = isNegated;
			this.isSFDB = isSFDB;
		}
		*/
		
		/**
		 * Initializes this instance of the Predicate class as a has_knowledge or ~has_knowledge
		 * predicate.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setHasKnowledgePredicate("x", Knowledge.PHEONIX_WAND);
		 * </listing>
		 * @param	first The character variable to which this predicate applies.
		 * @param	The knowledge that the character has.
		 */
		
/*		public function setHasKnowledgePredicate(first:String="initiator", knowledge:Number=0, isNegated:Boolean = false):void {
			this.type = Predicate.KNOWLEDGE;
			this.knowledge = knowledge;
			this.primary = first;
			this.negated = isNegated;
		}*/
		/**
		 * Initializes this instance of the Predicate class as a gain_knowledge or ~gain_knowledge
		 * predicate. Primary is person receiving knowledge, Secondary is person knowledge is received from
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setGainKnowledgePredicate("x", "y", Knowledge.PHEONIX_WAND);
		 * </listing>
		 * @param	first The character receiving the knowledge.
		 * @param	second The character giving the knowledge
		 * @param	knowledge The knowledge that is being given.
		 */
/*		public function setGiveKnowledgePredicate(first:String="initiator", second: String="responder", knowledge:Number=0, isNegated:Boolean = false):void {
			this.type = Predicate.GIVEKNOWLEDGE;
			this.knowledge = knowledge;
			this.primary = first;
			this.secondary = second;
			this.negated = isNegated;
		}*/

		/**
		 * Initializes this instance of the Predciate class as a network
		 * predicate.
		 * 
		 * TODO: list the types of premissible network comparisions.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setNetworkPredicate("x", "y", "", 70, SocialNetwork.ROMANCE);
		 * </listing>
		 * @param	first The character variable of the first predicate parameter.
		 * @param	second The character variable of the second predciate parameter.
		 * @param	operator The comparision or valuation operation to perform the
		 * network predicate evaulation or valuation by.
		 * @param	networkValue The network value used in the comparison.
		 * @param	networkType The network on which the comparison is to be made.
		 */
		public function setNetworkPredicate(first:String="initiator", second:String="responder", op:String="lessthan", networkValue:Number=0, networkType:Number=0, isNegated:Boolean=false, isSFDB:Boolean = false):void {
			this.type = Predicate.NETWORK;
			this.networkValue = networkValue;
			this.primary = first;
			this.secondary = second;
			this.comparator = op;
			this.operator = op;
			this.networkType = networkType;
			this.negated = isNegated;
			this.isSFDB = isSFDB;
		}
		
		/**
		 * Initializes this instance of the Predicate class as a relationship 
		 * predicate.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setRelationshipPredciate("x", "y", 
		 * </listing>
		 * 
		 * @param	first The character variable of the first predicate parameter.
		 * @param	second The character variable of the second predciate parameter.
		 * @param	relationship The relationship of the predicate.
		 * @param	type The type of the predicate as either Predicate.RELATIONSHIP (default)
		 * or Predicate.NOTRELATIONSHIP (have to include as an argument).
		 */
/*		public function setRelationshipPredicate(first:String="initiator", second:String="responder", relationship:Number=0, isNegated:Boolean = false, isSFDB:Boolean = false ):void {
			this.type = Predicate.RELATIONSHIP;
			this.primary = first;
			this.secondary = second;
			this.relationship = relationship;
			this.negated = isNegated;
			this.isSFDB = isSFDB;
		}*/		
		
		/**
		 * Initializes this instance of the Predicate class as a status 
		 * predicate.
		 * 
		 * @example <listing version="3.0">
		 * var p:Predicate = new Predicate();
		 * p.setStatusPredciate("x", "y", Status.HAS_CRUSH);
		 * </listing>
		 * 
		 * @param	first The character variable of the first predicate parameter.
		 * @param	second The character variable of the second predciate parameter.
		 * @param	status The status of the predicate.
		 * @param	type The type of the predicate as either Predicate.STATUS (default)
		 * or Predicate.NOTSTATUS (have to include as an argument).
		 */
		public function setStatusPredicate(first:String="initiator", second:String="responder", status:Number=0, isNegated:Boolean = false, duration:Number=0, isSFDB:Boolean = false ):void {
			this.type = Predicate.STATUS;
			this.primary = first;
			this.secondary = second;
			this.status = status;
			this.statusDuration = duration;
			this.negated = isNegated;
			this.isSFDB = isSFDB;
		}
		
		/**
		 * Initializes the Predicate as a CKB predicate.
		 * 
		 * @example <listing version="3.0"> 
		 * var p:Predicate = new Predicate();
		 * p.setCKBPredciate("x", "y", "likes", "dislikes", "cool");
		 * </listing>
		 * @param	first Character variable of the first parameter.
		 * @param	second Character variable of the second parameter.
		 * @param	firstSub Subjective link to the item from the first character.
		 * @param	secondSub Subjective link to the item from the second character.
		 * @param	truth The truth label of the item.
		 * @param	negated true means that the predicate IS negated (i.e. these conditions must NOT exist for the predicate to be evaluated to true)
		 */
		public function setCKBPredicate(first:String="initiator", second:String="responder", firstSub:String="likes", secondSub:String="likes", truth:String="cool", isNegated:Boolean=false):void {
			this.type = Predicate.CKBENTRY;
			this.primary = first;
			this.secondary = second;
			this.firstSubjectiveLink = firstSub;
			this.secondSubjectiveLink = secondSub;
			this.truthLabel = truth;
			this.negated = isNegated;
		}
		
		/**
		 * Initializes the Predicate as a CURRENTSOCIALGAME predicate.
		 * 
		 * @example <listing version="3.0"> 
		 * var p:Predicate = new Predicate();
		 * p.setCurrentSocialGamePredciate("True Love's Kiss", true);
		 * </listing>
		 * @param	name	Name of to check the current social game's name against.
		 * @param	negated true means that the predicate IS negated (i.e. these conditions must NOT exist for the predicate to be evaluated to true)
		 */
/*		public function setCurrentSocialGamePredicate(name:String="brag", isNegated:Boolean=false):void {
			this.type = Predicate.CURRENTSOCIALGAME;
			this.currentGameName = name;
			this.negated = isNegated;
		}*/
		
		/**
		 * Modifies the type of the predicate to make it an SFDB entry or make
		 * it not a SFDB entry. The subType and the type are swapped or otherwise
		 * modified to mark the predicate as or not a SFDB entry.
		 */
		public function makeSFDB():void {
			this.isSFDB = true;
		}
		
		/**
		 * Makes the predicate not an SFDB entry. SFDBLABEL type Predicates
		 * cannot have their isSFDB property undone.
		 */
		public function undoSFDB():void {
			//SFDBLABEL types of predicates must be SFDB
			if (Predicate.SFDBLABEL == this.type) {
				Debug.debug(this, "undoSFDB(): instances of Predicate with the type of SFDBLABEL have their isSFDB flag set to false");
			}else {
				this.isSFDB = false;
			}
		}
		
		/**
		 * Initializes the predicate to be of type SFDBLABEL. This is the only
		 * initiator that sets the the isSFDB flag to true. Predicates of type
		 * SFDBLABEL are invalid of their isSFDB is false.
		 * 
		 * @param	first Character variable of the first parameter.
		 * @param	second Character variable of the second parameter.
		 * @param	sfdbLabel The specific SFDB label.
		 * @param	isNegated The truth label of the item.
		 */
		public function setSFDBLabelPredicate(first:String = "initiator", second:String = "responder", label:Number = 0, isNegated:Boolean = false, window1:Number = 0):void {
			this.isSFDB = true;
			this.primary = first;
			this.secondary = second;
			this.type = Predicate.SFDBLABEL;
			this.negated = isNegated;
			this.sfdbLabel = label;
			this.window = window1;
		}

		/**
		 * Initializes the predicate by type enumeration. Default values are
		 * assigned according to the type provided.
		 * @param	t	An enumerated value that corresponds to a predicate type.
		 */
		public function setByTypeDefault(t:Number):void {
			switch (t) {
				case Predicate.TRAIT:
					this.setTraitPredicate();
					break;
				case Predicate.NETWORK:
					this.setNetworkPredicate();
					break;
				case Predicate.STATUS:
					this.setStatusPredicate();
					break;
				case Predicate.CKBENTRY:
					this.setCKBPredicate();
					break;
				case Predicate.SFDBLABEL:
					this.setSFDBLabelPredicate();
					break;
				//case Predicate.RELATIONSHIP:
					//this.setRelationshipPredicate();
					//break;
/*				case Predicate.CURRENTSOCIALGAME:
					this.setCurrentSocialGamePredicate();
					break;
				case Predicate.KNOWLEDGE:
					this.setHasKnowledgePredicate();
					break;
				case Predicate.GIVEKNOWLEDGE:
					this.setGiveKnowledgePredicate();
					break;*/
				default:
					Debug.debug(this, "setByTypeDefault(): unkown type found.");
			}
		}
		
		/**
		 * Determines the value class of the primary property and returns a
		 * value based on that class. If it is a role class, "initiator", 
		 * "responder" or "other" will be returned. If it is a variable class,
		 * "x","y" or "z" will be returned. If it is anything else (character
		 * name or a mispelling), the raw value will be returned.
		 * @return The value based on the value class of the primary property.
		 */
		public function getPrimaryValue():String {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			switch (this.primary.toLowerCase()) {
				case "init":
				case "initiator":
				case "i":
					return "initiator";
				case "r":
				case "res":
				case "responder":
					return "responder";
				case "o":
				case "oth":
				case "other":
					return "other";
				case "x":
					return "x";
				case "y":
					return "y";
				case "z":
					return "z";
				case "":
					return "";
					Debug.debug(this, "getPrimaryValue(): primary was not set.");
				default:
					if (cif.getGameObjByName(this.primary))
						return this.primary;
					Debug.debug(this, "getPrimaryValue() primary could not be placed in a known class: " + this.primary + " " + this);
			}
			return "";
		}
		
		public function getPrimaryObject(x:GameObject, y:GameObject, z:GameObject = null):GameObject 
		{
			var first:CiF.GameObject;
			
			if (!(first = CiFSingleton.getInstance().getGameObjByName(this.primary))) {
				switch (this.getPrimaryValue()) {
					case "initiator":
					case "x":
						first = x;
						break;
					case "responder":
					case "y": 
						first = y;
						break;
					case "other":
					case "z":
						first = z;
						break;
					default:
						first = null;
				}
			}
			
			return first;
		}
		
		public function getSecondaryObject(x:GameObject, y:GameObject, z:GameObject = null):GameObject 
		{
			var second:CiF.GameObject;
			
			if (!(second = CiFSingleton.getInstance().getGameObjByName(this.secondary))) {
				switch (this.getSecondaryValue()) {
					case "initiator":
					case "x":
						second = x;
						break;
					case "responder":
					case "y": 
						second = y;
						break;
					case "other":
					case "z":
						second = z;
						break;
					default:
						second = null;
				}
			}
			
			return second;
		}
		/**
		 * Determines the value class of the secondary property and returns a
		 * value based on that class. If it is a role class, "initiator", 
		 * "responder" or "other" will be returned. If it is a variable class,
		 * "x","y" or "z" will be returned. If it is anything else (character
		 * name or a mispelling), the raw value will be returned.
		 * @return The value based on the value class of the secondary property.
		 */
		public function getSecondaryValue():String {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			switch (this.secondary.toLowerCase()) {
				case "i":
				case "init":
				case "initiator":
					return "initiator";
				case "r":
				case "res":
				case "responder":
					return "responder";
				case "o":
				case "oth":
				case "other":
					return "other";
				case "x":
					return "x";
				case "y":
					return "y";
				case "z":
					return "z";
				case "":
					//Debug.debug(this, "getSecondaryValue(): secondary was not set.");
					return "";
				default:
					if (cif.getGameObjByName(this.secondary))
						return this.secondary;
					//Debug.debug(this, "getSecondaryValue() primary could not be placed in a known class: " + this.secondary);
			}
			return "";
		}
		
		/**
		 * Determines the value class of the tertiary property and returns a
		 * value based on that class. If it is a role class, "initiator", 
		 * "responder" or "other" will be returned. If it is a variable class,
		 * "x","y" or "z" will be returned. If it is anything else (character
		 * name or a mispelling), the raw value will be returned.
		 * @return The value based on the value class of the teriary property.
		 */
		public function getTertiaryValue():String {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			switch (this.tertiary.toLowerCase()) {
				case "i":
				case "init":
				case "initiator":
					return "initiator"
				case "r":
				case "res":
				case "responder":
					return "responder";
				case "o":
				case "oth":
				case "other":
					return "other";
				case "x":
					return "x";
				case "y":
					return "y";
				case "z":
					return "z";
				case "":
					//Debug.debug(this, "getTertiaryValue(): tertiary was not set.");
					return "";
				default:
					if (cif.getGameObjByName(this.tertiary))
						return this.tertiary;
					Debug.debug(this, "getTertiaryValue(): tertiary could not be placed in a known class: " + this.tertiary);
			}
			return "";
		}
		
		/**
		 * Determines the names of any character who was 
		 * explicitly bound to a character variable in this predicate.
		 * @return the names of any character who was 
		 * explicitly bound to a character variable in this predicate.
		 */
		public function getBoundnames():Vector.<String>{
			var boundCharNames:Vector.<String> = new Vector.<String>();
			
			if (isVariableExplicitlyBound("primary"))
				boundCharNames.push(new String(this.primary));
			if (isVariableExplicitlyBound("secondary"))
				boundCharNames.push(new String(this.secondary));
			if (isVariableExplicitlyBound("teriary"))
				boundCharNames.push(new String(this.tertiary));
			return boundCharNames;
		}
		/**
		 * Determines if the character variable (either first, second, or third or primary, secondary, tertiary)
		 * is explicitly bound to a character (i.e. this.first == "Edward").
		 * 
		 * @param variable	The string representation of a character variable. Can either be "first", "second", or "third".
		 * @return true if the variable is explicitly bound to a character or false if not.
		 */
		public function isVariableExplicitlyBound(variable:String):Boolean {
			var slot:String;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			switch(variable) {
				case "first":
				case "primary":
					slot = this.primary;
					break;
				case "second":
				case "secondary":
					slot = this.secondary;
					break;
				case "third":
				case "teriary":
					slot = this.tertiary
					break;
				default:
					Debug.debug(this, "isVariableExplicitlyBound() could not determine a character variable slot from: " + variable);
			}
			
			switch (slot.toLowerCase()) {
				case "i":
				case "init":
				case "initiator":
				case "r":
				case "res":
				case "responder":
				case "o":
				case "oth":
				case "other":
				case "x":
				case "y":
				case "z":
				case "":
					//Debug.debug(this, "getTertiaryValue(): tertiary was not set.");
					return false;
				default:
					if (cif.getGameObjByName(slot))
						return true;
					Debug.debug(this, "isVariableExplicitlyBound(): slot was not a role type or a recognized character.");
			}
			return false;
		}
		
		/**********************************************************************
		 * Valutation
		 *********************************************************************/
		
		/**
		 * Performs the predicate as a valuation (aka a change to the current game model/social state).
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 * @param	third Character variable of the third predicate parameter.
		 */
		public function valuation(x:GameObject, y:GameObject=null, z:GameObject=null, sg:SocialGame=null):void {
			var first:CiF.GameObject;
			var second:CiF.GameObject;
			var third:CiF.GameObject;
			
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			Predicate.valuationCount++;
			
			//trace(Predicate.getNameByType(this.type));
			
			/**
			 * Need to determine if the predicate's predicate variables reference
			 * roles (initiator,responder), generic variables (x,y,z), or 
			 * characters (edward, karen).
			 */
			//if this.primary is not a reference to a character, determine if 
			//it is either a role or a generic variable
			if (!(first = cif.getGameObjByName(this.primary))) {
				switch (this.getPrimaryValue()) {
					case "initiator":
					case "x":
						first = x;
						break;
					case "responder":
					case "y": 
						first = y;
						break;
					case "other":
					case "z":
						first = z;
						break;
					default:
						//trace("Predicate: the first variable was not bound to a character!");
/*						if(this.type != Predicate.CURRENTSOCIALGAME) 
							Debug.debug(this, "the first variable was not bound to a character; it could be a binding problem.");*/
					//default first is not bound
				}
			}
			
			if (!(second = cif.getGameObjByName(this.secondary))) {
				switch (this.getSecondaryValue()) {
					case "initiator":
					case "x":
						second = x;
						break;
					case "responder":
					case "y": 
						second = y;
						break;
					case "other":
					case "z":
						second = z;
						break;
					default:
						second = null;
				}
			}
			
			if (!(third = cif.getGameObjByName(this.tertiary))) {
				switch (this.getTertiaryValue()) {
					case "initiator":
					case "x":
						third = x;
						break;
					case "responder":
					case "y": 
						third = y;
						break;
					case "other":
					case "z":
						third = z;
						break;
					default:
						third = null;
				}
			}
			
			/*var rtnstr:String = "first: ";
			rtnstr += first?first.name:"N/A" ;
			rtnstr += " second: ";
			rtnstr += second?second.name:"N/A";
			rtnstr += " type: ";
			rtnstr += getNameByType(this.type);
			Debug.debug(this, rtnstr); */
			
			
			/*
			 * At this point only first has to be set. Any other bindings might
			 * not be valid depending on the type of the predicate. For example
			 * a CKBENTRY type could only have a first character variable
			 * specified and would work properly. If second or third are not set
			 * their value is set to null so the proper evaluation functions can
			 * determine how to hand the different cases of character variable
			 * specification.
			 */
			
			switch (this.type) 
			{
				case TRAIT:
					Debug.debug(this, "Traits cannot be subject to valuation.");
					break;
				case NETWORK:
					updateNetwork(first, second);
					break;
				case STATUS:
					updateStatus(first, second);
					break;
				case CKBENTRY:
					Debug.debug(this, "CKBENTRIES cannot be subject to valuation.");
					break;
				case SFDBLABEL:
					Debug.debug(this, "SFDBLABELs cannot be subject to valuation.");
					break;
				//case RELATIONSHIP:
					//updateRelationship(first, second);
					//break;
/*				case CURRENTSOCIALGAME:
					Debug.debug(this, "CURRENTSOCIALGAMEs cannot be subject to valuation.");*/
				default:
					Debug.debug(this, "preforming valuation a predicate without a recoginzed type.");
			}
			
		}
		
		/**
		 * Updates the social status state with a status predicate via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 */
		private function updateStatus(first:GameObject, second:GameObject):void {
			if (this.negated) {
				if (second != null)
					Debug.debug(this, first.name + " removing status " + Status.getStatusNameByNumber(this.status) + " from " + second.name);
				else 
					Debug.debug(this, first.name + " removing status " + Status.getStatusNameByNumber(this.status));
				first.removeStatus(this.status, second);
			} else {
				if (second != null)
					Debug.debug(this, first.name + " adding status " + Status.getStatusNameByNumber(this.status) + " to " + second.name);
				else 
					Debug.debug(this, first.name + " adding status " + Status.getStatusNameByNumber(this.status));
				
				if (this.statusDuration > 0)
					first.addStatus(this.status, second, this.statusDuration);
				else
					first.addStatus(this.status, second);
			}
		}
		
		/**
		 * Updates the character's knowledge with knowledge via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * 
		 * Note: Only characters can have knowledge (April)
		 */
		private function updateKnowledge(firstObj:GameObject):void {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			if (first != null){
				if (this.negated)
					first.removeKnowledge(this.knowledge);
				else
					first.addKnowledge(this.knowledge, null);
			}
		}

		/**
		 * Updates the character's inventory with item via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * 
		 * Note: Only characters can have an inventory (April)
		 */
		private function updateInventory(firstObj:GameObject):void {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			if (first != null){
				if (this.negated)
					first.removeItem(this.item);
				else
					first.addItem(this.item, null);
			}
		}

		/**
		 * Updates the character's knowledge with knowledge via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * 
		 * Note: Only characters can handle knowledge (April)
		 */
		private function giveKnowledge(firstObj:GameObject, secondObj:GameObject):void {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			if (first != null && second != null){
				if (this.negated)
					first.removeKnowledge(this.knowledge);
				else
					first.addKnowledge(this.knowledge, second);
			}
		}

		/**
		 * Updates the character's inventory with item via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * 
		 * Note: Only characters can handle items (April)
		 */
		private function giveItem(firstObj:GameObject, secondObj:GameObject):void {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			if (first != null && second != null){
				if (this.negated)
					first.removeItem(this.item);
				else
					first.addItem(this.item, second);
			}
		}

		/**
		 * Updates the character's past item list with an item predicate via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 */
/*		private function updatePastItems(first:Character):void {
			if (this.negated)
				first.removePastItem(this.item);
			else
				first.addPastItem(this.item);
		}
*/
		/**
		 * Updates the character's desired item list with an item predicate via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 */
/*		private function updateDesiredItems(first:Character):void {
			if (this.negated)
				first.removeDesiredItem(this.item);
			else
				first.addDesiredItem(this.item);
		}
*/
		/**
		 * Updates the relationship state with a status predicate via valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 */
		/*private function updateRelationship(firstObj:GameObject, secondObj:GameObject):void {
			var rel:RelationshipNetwork= RelationshipNetwork.getInstance();
			//Debug.debug(this, "updateRelationship() change reached.");
			// (April) Only characters need to update relationships
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			if (first != null && second != null){
				if (this.negated)
				{
					rel.removeRelationship(this.relationship, first, second);
					//rel.removeRelationship(this.relationship, second, first);
					Debug.debug(this, "updateRelationship() " + RelationshipNetwork.getRelationshipNameByNumber(this.relationship) + "relationship removed.");
				}
				else
				{
					rel.setRelationship(this.relationship, first, second);
				}
			}
		}*/
		
		/**
		 * Updates a social network according to the Predicate's parameters via
		 * valuation.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 * 
		 * Note: Only characters need to update networks (April)
		 */
		private function updateNetwork(firstObj:GameObject, secondObj:GameObject):void {
			var net:SocialNetwork;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			var char:GameObject;
			
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			
			if (first != null && second != null){
			
				var firstID:int = first.networkID;
				var secondID:int;
				
				if (second) 
					secondID = second.networkID;
				
				//get the proper singleton based on desired network type.
				if (this.networkType == SocialNetwork.BUDDY) 
					net = BuddyNetwork.getInstance();
				if (this.networkType == SocialNetwork.ROMANCE) 
					net = RomanceNetwork.getInstance();
				if(this.networkType == SocialNetwork.TRUST)
					net = TrustNetwork.getInstance();
				if (this.networkType == SocialNetwork.FAMILYBOND)
					net = FamilyBondNetwork.getInstance();
				switch (getOperatorByName(this.operator)) {
					case Predicate.ADD:
						net.addWeight(this.networkValue, first.networkID, second.networkID);
						break;
					case Predicate.SUBTRACT:
						net.addWeight( -this.networkValue, first.networkID, second.networkID);
						break;
					case Predicate.MULTIPLY:
						net.multiplyWeight(first.networkID, second.networkID, this.networkValue);
						break;
					case Predicate.ASSIGN:
						net.setWeight(first.networkID, second.networkID, this.networkValue);
						break;
					case Predicate.EVERYONEUP:
						for each (char in cif.cast.characters) {
							net.addWeight(this.networkValue, char.networkID, firstID);
						}
						break;
					/*case Predicate.ALLFRIENDSUP:
						for each (char in cif.cast.characters) {
							if (cif.relationshipNetwork.getRelationship(RelationshipNetwork.FRIENDS, first, second)
								&& first.name != char.name)
								net.addWeight(this.networkValue, char.networkID, firstID);	
						}
						break;
					case Predicate.ALLDATINGUP:
						for each (char in cif.cast.characters) {
							if (cif.relationshipNetwork.getRelationship(RelationshipNetwork.DATING, first, second)
								&& first.name != char.name)
								net.addWeight(this.networkValue, char.networkID, firstID);	
						}
						break;
					case Predicate.ALLENEMYUP:
						for each (char in cif.cast.characters) {
							if (cif.relationshipNetwork.getRelationship(RelationshipNetwork.ENEMIES, first, second)
								&& first.name != char.name)
								net.addWeight(this.networkValue, char.networkID, firstID);	
						}
						break;*/
				}
			}
		}
		
		/**********************************************************************
		 * Predicate evalutation functions.
		 *********************************************************************/
				 
		/**
		 * Evaluates the predicate for truth given the characters involved
		 * bound to the parameters. The process of evaluating truth depends
		 * on the type of the specific instance of the predicate.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 * @param	third Character variable of the third predicate parameter.
		 * @return True of the predicate evaluates to true. False if it does not.
		 */
		public function evaluate(x:GameObject, y:GameObject=null, z:GameObject = null, sg:SocialGame=null):Boolean {
			var first:CiF.GameObject;
			var second:CiF.GameObject;
			var third:CiF.GameObject;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			//there is a third character we need to account for.
			var isThird:Boolean = false;
			var pred:Predicate;
			var rule:Rule;
			var intentIsTrue:Boolean = false;

			Predicate.evaluationCount++;
			
			//Debug.debug(this, "evaluate() x: " + (x?x.name:"unbound") + " y: " + (y?y.name:"unbound") + " sg: " + (sg?sg.name:"unbound") );
			
			
			//trace(Predicate.getNameByType(this.type));
			/**
			 * Need to determine if the predicate's predicate variables reference
			 * roles (initiator,responder), generic variables (x,y,z), or 
			 * characters (edward, karen).
			 */
			//if this.primary is not a reference to a character, determine if 
			//it is either a role or a generic variable
			if (!(first = cif.getGameObjByName(this.primary))) {
				switch (this.getPrimaryValue()) {
					case "initiator":
					case "x":
						first = x;
						break;
					case "responder":
					case "y": 
						first = y;
						break;
					case "other":
					case "z":
						first = z;
						break;
					default:
						//trace("Predicate: the first variable was not bound to a character!");
/*						if(this.type != CURRENTSOCIALGAME)
							Debug.debug(this, "the first variable was not bound to a character!");*/
					//default first is not bound
				}
			}
			
			if (!(second = cif.getGameObjByName(this.secondary))) {
				switch (this.getSecondaryValue()) {
					case "initiator":
					case "x":
						second = x;
						break;
					case "responder":
					case "y": 
						second = y;
						break;
					case "other":
					case "z":
						second = z;
						break;
					default:
						second = null;
				}
			}
			
			if (!(third = cif.getGameObjByName(this.tertiary))) {
				switch (this.getTertiaryValue()) {
					case "initiator":
					case "x":
						third = x;
						isThird = true;
						break;
					case "responder":
					case "y": 
						third = y;
						isThird = true;
						break;
					case "other":
					case "z":
						third = z;
						isThird = true;
						break;
					default:
						isThird = false;
						third = null;
				}
			}
			
			
			
			
/*			var rtnstr:String = "first: ";
			rtnstr += first?first.name:"N/A" ;
			rtnstr += " second: ";
			rtnstr += second?second.name:"N/A";
			rtnstr += " type: ";
			rtnstr += getNameByType(this.type);
			Debug.debug(this, rtnstr); 
*/			
			
			/*
			 * At this point only first has to be set. Any other bindings might
			 * not be valid depending on the type of the predicate. For example
			 * a CKBENTRY type could only have a first character variable
			 * specified and would work properly. If second or third are not set
			 * their value is set to null so the proper evaluation functions can
			 * determine how to hand the different cases of character variable
			 * specification.
			 */
			
			 
			/**
			 * If isSFDB is true, we want to look over the Predicate's window 
			 * in the SFDB for this predicate's context. If found, the predicate
			 * is true. Otherwise, it is false.
			 * 
			 * This is the only evaluation needed for a Predicate with isSFDB
			 * being true. 
			 */
			if (this.isSFDB && this.type != Predicate.SFDBLABEL) {
				return evalIsSFDB(x, y, z, sg);
			}
			 
			/*
			 * If the predicate is intent, we want to check it against all of the 
			 * intent predicates in the intentent rule in the passed-in social game.
			 * If this predicate matches any predicate in any rule of the intent
			 * rule vector of the social game, we return true.
			 * 
			 * Intents can only be networks and relationships.
			 */
			if (this.intent) {
				//Debug.debug(this, "evaluate() in intent processing. sg: " + sg);
				/*if (this.type == Predicate.RELATIONSHIP) {
					if (!sg.intents) {
						Debug.debug(this, "evaluate(): intent predicate evaluation: the social game context has no intent");
					}else{
						for each(rule in sg.intents) {
							for each(pred in rule.predicates) {
								if (pred.relationship == this.relationship &&
									pred.primary == this.primary &&
									pred.secondary == this.secondary &&
									pred.negated == this.negated) {
									
									return true;
								}
							}
						}
					}
				}
				else */
				if (this.type == Predicate.STATUS) {
					if (!sg.intents) {
						Debug.debug(this, "evaluate(): intent predicate evaluation: the social game context has no intent");
					} else {
						for each (rule in sg.intents) {
							for each(pred in rule.predicates) {
								if (pred.status == this.status &&
									pred.primary == this.primary &&
									pred.secondary == this.secondary &&
									pred.negated == this.negated) {
											return true;
								}
							}
						}
					}
				}
				//is it a network
				else if (this.type == Predicate.NETWORK) {
					if (!sg.intents) {
						Debug.debug(this, "evaluate(): intent predicate evaluation: the social game context has no intent");
					}else{
						for each(rule in sg.intents) {
							for each(pred in rule.predicates) {
								if (pred.networkType == this.networkType &&
									pred.comparator == this.comparator &&
									pred.primary == this.primary &&
									pred.secondary == this.secondary &&
									pred.negated == this.negated) {
									
									return true;
								}
									
							}
						}
					}
				}
				//is it a sfdbLabel
				else if (this.type == Predicate.SFDBLABEL)
				{
					if (!sg.intents) {
						Debug.debug(this, "evaluate(): intent predicate evaluation: the social game context has no intent");
					}else{
						for each(rule in sg.intents) {
							for each(pred in rule.predicates) {
								if (pred.sfdbLabel == this.sfdbLabel &&
									pred.primary == this.primary &&
									pred.secondary == this.secondary &&
									pred.negated == this.negated) {
									
									return true;
								}
							}
						}
					}
				}
				/* We either have no predicate match to the sg's intent rules 
				 * or we are not a predicate type that can encompass intent. In
				 * either case, return false.
				 */
				return false;
			}
			 
			
			if (numTimesUniquelyTrueFlag) 
			{
				//Debug.debug(this, this.toString());
				var numTimesResult:Boolean = evalForNumberUniquelyTrue(first, second, third, sg);
				return (this.negated)? !numTimesResult : numTimesResult;
			}
	
			
			
			switch (this.type) 
			{
/*				case KNOWLEDGE:
					return this.negated ? !evalKnowledge(first) : evalKnowledge(first);
				case GIVEKNOWLEDGE:
					return this.negated ? !evalGiveKnowledge(first, second) : evalGiveKnowledge(first, second);*/
				case TRAIT:
					return this.negated ? !evalTrait(first) : evalTrait(first);
				case NETWORK:
					//trace("Going in here: "+this.toString() + " first: " + first.name + " second: " + second.name);
					//var isNetworkEvalTrue:Boolean = this.negated ? !evalNetwork(first, second) : evalNetwork(first, second);
					//Debug.debug(this, "evaluate() ^ returned " + isNetworkEvalTrue);
					return evalNetwork(first, second);
				case STATUS:
					//if (first == null) Debug.debug(this, "found it: "+this.toString());
					return this.negated ? !evalStatus(first, second) : evalStatus(first, second);
				case CKBENTRY:
					return evalCKBEntry(first, second);
				case SFDBLABEL:
					return evalSFDBLABEL(first, second, third);
				//case RELATIONSHIP:
					//trace ("Relationship predicates are no longer supported, please remove them!");
					//break;
//					return this.negated ? !evalRelationship(first, second) : evalRelationship(first, second);
/*				case CURRENTSOCIALGAME:
					if (this.negated) {
						return this.currentGameName.toLowerCase() != sg.name;
					}else {
						return this.currentGameName.toLowerCase() == sg.name;
					}*/
				default:
					//trace(  "Predicate: evaluating a predicate without a recognized type.");
					Debug.debug(this, "evaluating a predicate without a recognized type of: " + this.type);
			}
			return false;
		}
		
		/**
		 * Looks through the SFDB 
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 * @param	third Character variable of the third predicate parameter.
		 * @return True of the predicate evaluates to true. False if it does not.
		 */
		public function evalIsSFDB(x:GameObject, y:GameObject = null, z:GameObject = null, sg:SocialGame = null):Boolean {
			return CiFSingleton.getInstance().sfdb.isPredicateInHistory(this, x, y, z);
	
		}
		
		/**
		 * Evaluates the predicate for truth given the characters involved
		 * bound to the parameters and determines how many times the predicate is
		 * uniquely true. The process of evaluating truth depends
		 * on the type of the specific instance of the predicate and the number of times
		 * the predicate is uniquely true.
		 * 
		 * @param	first Character variable of the first predicate parameter.
		 * @param	second Character variable of the second predicate parameter.
		 * @param	third Character variable of the third predicate parameter.
		 * @return True of the predicate evaluates to true. False if it does not.
		 */
		public function evalForNumberUniquelyTrue(x:GameObject, y:GameObject = null, z:GameObject = null, sg:SocialGame = null):Boolean {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			var numTimesTrue:int = 0;
			
			var predTrue:Boolean = false;
			var primaryCharacterOfConsideration:GameObject;
			var secondaryCharacterOfConsideration:GameObject;
			
			if (!numTimesRoleSlot)
			{
				numTimesRoleSlot = "first";
				//TODO: Fix where the numTimesRoleSlot is unspecified. Author/Tool problem
			}
			
			switch(numTimesRoleSlot)
			{
				
				case "first":
					primaryCharacterOfConsideration = x;
					break;
				case "second":
					primaryCharacterOfConsideration = y;
					break;
				case "third":
					primaryCharacterOfConsideration = z;
					break;
				case "both":
					primaryCharacterOfConsideration = x;
					secondaryCharacterOfConsideration = y;
					break;
				default:
					//TODO: Address this hack fro where author or the tool didn't properly give the role
					primaryCharacterOfConsideration = x;
					numTimesRoleSlot = "first";
					Debug.debug(this, "evalForNumberUniquelyTrue() role slot not recognized: "+ numTimesRoleSlot);
			}
			
			if (numTimesRoleSlot == "both")
			{
				switch (this.type) 
				{
					case CKBENTRY:
						numTimesTrue = evalCKBEntryForObjects(primaryCharacterOfConsideration, secondaryCharacterOfConsideration).length;
						break;
					case SFDBLABEL:
						numTimesTrue = cif.sfdb.findLabelFromValues(this.sfdbLabel, primaryCharacterOfConsideration, secondaryCharacterOfConsideration, z, this.window,this).length;
						//Debug.debug(this, "numTimes(): primary ("+primaryCharacterOfConsideration.name + ") did a "+SocialFactsDB.getLabelByNumber(this.sfdbLabel)+" thing to secondary ("+ secondaryCharacterOfConsideration.name+") "+numTimesTrue+" times.");
						break;
					default:
						Debug.debug(this, "evalForNumberUniquelyTrue() Doesn't make sense consider 'both' role type for pred types not CKB or SFDB " + this.type);
				}
			}
			else
			{
				for each (var char:GameObject in cif.cast.characters)
				{
					
					//Debug.debug(this,"evalForNumberUniquelyTrue() "+this.toString());
					predTrue = false;
					//if (!primaryCharacterOfConsideration) return false;
					
					if (char.name != primaryCharacterOfConsideration.name)
					{
						switch (this.type) 
						{
							case TRAIT:
								predTrue = evalTrait(primaryCharacterOfConsideration);
								break;
							case NETWORK:
								if ("second" == numTimesRoleSlot)
								{
									predTrue = evalNetwork(char, primaryCharacterOfConsideration);	
								}
								else
								{								
									predTrue = evalNetwork(primaryCharacterOfConsideration, char);
									//Debug.debug(this, "evaluate() ^ returned " + isNetworkEvalTrue);
								}
								break;
							case STATUS:
								if ("second" == numTimesRoleSlot)
								{
									predTrue = evalStatus(char, primaryCharacterOfConsideration);
								}
								else
								{
									predTrue = evalStatus(primaryCharacterOfConsideration, char);
								}
								break;
							case CKBENTRY:
								predTrue = evalCKBEntry(primaryCharacterOfConsideration, char);
								break;
							case SFDBLABEL:
								if ("second" == numTimesRoleSlot)
								{
									//predTrue = evalSFDBLABEL(char, primaryCharacterOfConsideration, z);
									numTimesTrue += cif.sfdb.findLabelFromValues(this.sfdbLabel, char, primaryCharacterOfConsideration, null, this.window, this).length;
								}
								else
								{
									//predTrue = evalSFDBLABEL(primaryCharacterOfConsideration, char, z);
									numTimesTrue += cif.sfdb.findLabelFromValues(this.sfdbLabel, primaryCharacterOfConsideration, char, null, this.window, this).length;
								}
								break;
							//case RELATIONSHIP:
								//predTrue = evalRelationship(primaryCharacterOfConsideration, char);
								//break;
/*							case CURRENTSOCIALGAME:
								//Debug.debug(this, "evalForNumberUniquelyTrue() Trying to print out the number of times a name of a social game is true doesn't make sense")
								predTrue = this.currentGameName.toLowerCase() == sg.name;
								break;*/
							default:
								//trace(  "Predicate: evaluating a predicate without a recoginzed type.");
								Debug.debug(this, "evaluating a predicate without a recoginzed type of: " + this.type);
						}
						if (predTrue) numTimesTrue++;
					}
				}
			}
			
			// This is a special case for where we want to count numTimesTrue for contexts labels that don't have the nonPrimary roile specified 
			if (this.type == Predicate.SFDBLABEL && this.numTimesUniquelyTrueFlag)
			{
				//commented out this because because it handles a case that doesn't make sense: i.e. sfdblabel having no from and only a to.
				//if ("second" == numTimesRoleSlot)
				//{
					//numTimesTrue += cif.sfdb.findLabelFromValues(this.sfdbLabel, null, primaryCharacterOfConsideration, null, this.window, this).length;
				//}
				//else 
				if ("first" == numTimesRoleSlot)
				{
					numTimesTrue += cif.sfdb.findLabelFromValues(this.sfdbLabel, primaryCharacterOfConsideration, null, null, this.window, this).length;
				}
			}
			
			if (numTimesTrue >= this.numTimesUniquelyTrue)
			{
				return true;
			}
			return false;
		}
		
		/**
		 * Returns true if the character in the first parameter has the trait
		 * noted in the trait field of this class.
		 * 
		 * @param first The character for which the existence of the trait is ascertained.
		 * @return True if the character has the trait. False if the trait is not present.
		 */
		public function evalTrait(first:CiF.GameObject):Boolean {
			if (first.hasTrait(this.trait))
				return true;
			return false;
		}

		/**
		 * Returns true if the knowledge has the trait
		 * noted in the trait field of this class.
		 * 
		 * @param first the knowledge to be checked
		 * @return True if the knowledge has the trait. False if the knowledge does not have the trait.
		 */
		public function evalKnowledgeTrait(first: Knowledge):Boolean {
			if (first.hasTrait(this.trait))
			{
				return true;
			}
			return false;
		}
		
		/**
		 * Returns true if the character in the first parameter has the item
		 * noted in the item field of this class.
		 * 
		 * @param first The character for which the existence of the item is ascertained.
		 * @return True if the character has the item. False if the item is not present.
		 * 
		 * Note: Only characters can have knowledge (April)
		 */
		public function evalKnowledge(firstObj:CiF.GameObject):Boolean {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			if (first != null){
				if (first.hasKnowledgeType(this.knowledge))
					return true;
			}
			return false;
		}

		/**
		 * Returns true if the character in the first parameter has the knowledge
		 * noted in the knowledge field of this class, and it was given to them by the second character.
		 * 
		 * @param first The character that has the knowledge.
		 * @param second The character that gave them the knowledge
		 * @return True if the character has the knowledge and it was gained by the second character. False if otherwise.
		 * 
		 * Note: Only characters gave give knowledge (April)
		 */
		public function evalGiveKnowledge(firstObj:CiF.GameObject, secondObj:CiF.GameObject):Boolean {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			if (first != null && second != null){
				if (first.hasKnowledgeType(this.knowledge, second))
					return true;
			}
			return false;
		}

		/**
		 * Returns true if the item has the trait
		 * noted in the trait field of this class.
		 * 
		 * @param first the item to be checked
		 * @return True if the item has the trait. False if the item does not have the trait.
		 */
		public function evalItemTrait(first:Item):Boolean {
			if (first.hasTrait(this.trait))
			{
				return true;
			}
			return false;
		}
		
		/**
		 * Returns true if the character in the first parameter has the item
		 * noted in the item field of this class.
		 * 
		 * @param first The character for which the existence of the item is ascertained.
		 * @return True if the character has the item. False if the item is not present.
		 */
		public function evalItem(first:CiF.GameObject):Boolean {
			//if (first.hasItemType(this.item))
				return true;
			//return false;
		}

		/**
		 * Returns true if the character in the first parameter has the item
		 * noted in the item field of this class, and it was given to them by the second character.
		 * 
		 * @param first The character that has the item.
		 * @param second The character that gave them the item
		 * @return True if the character has the item and it was gained by the second character. False if otherwise.
		 */
		public function evalGiveItem(first:CiF.GameObject, second:CiF.GameObject):Boolean {
			//if (first.hasItemType(this.item, second))
				return true;
			//return false;
		}

		/**
		 * Returns true if the character in the first parameter has the item
		 * noted in the pastItems field of this class.
		 * 
		 * @param first The character for which the existence of the item in the past is ascertained
		 * @return True if the character had the item in the past. False if the item is not present in the pastItem list.
		 */
/*		private function evalPastItems(first:CiF.Character):Boolean {
			if (first.pastItem(this.item))
				return true;
			return false;
		}
*/
		/**
		 * Returns true if the character in the first parameter has the item
		 * noted in the desiredItems field of this class.
		 * 
		 * @param first The character for which the existence of the desired item is ascertained
		 * @return True if the character desires the item. False if the item is not present in the desiredItems list.
		 */
/*		private function evalDesiredItems(first:CiF.Character):Boolean {
			if (first.desiresItem(this.item))
				return true;
			return false;
		}
*/
		 /** Returns true if the character in the first parameter has the relationship
		 * noted in the trait field of this class.
		 * 
		 * @param first The character for which the existence of the trait is ascertained.
		 * @return True if the character has the trait. False if the trait is not present.
		 * 
		 * Note: Relationships should only be evaled between characters (April)
		 */
		/*protected function evalRelationship(firstObj:GameObject, secondObj:GameObject):Boolean {
			var sn:RelationshipNetwork = RelationshipNetwork.getInstance();
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			if (first != null && second != null){
				//Debug.debug(this, "evalRelationship: " + first.name + " " + second.name + " " + this.toString());
				if (sn.getRelationship(this.relationship, first, second))
					return true;
			}
			return false;
		}*/
		
		/** Returns true if the character in the first parameter has the relationship
		 * noted in the trait field of this class.
		 * 
		 * @param first The character for which the existence of the status is ascertained.
		 * @return True if the character has the status. False if the status is not present.
		 */
		public function evalStatus(first:GameObject, second:GameObject):Boolean {
			//Debug.debug(this, "evalStatus() 1=" + first.name + " 2=" + second.name + " " + this.toString());
			return first.hasStatus(this.status, second);

		}
		
		/**
		 * 
		 * @param	first
		 * @param	second
		 * @return
		 * 
		 * Note: Only characters should eval networks (April)
		 */
		public function evalNetwork(firstObj:GameObject, secondObj:GameObject):Boolean {
			var first:Character = CiFSingleton.getInstance().cast.getCharByName(firstObj.name);
			var second:Character = CiFSingleton.getInstance().cast.getCharByName(secondObj.name);
			
			if (first != null && second != null){
				var net:SocialNetwork;
				var firstID:int = first.networkID;
				var secondID:int;

				if (second) 
					secondID = second.networkID;
				
				
					
				//get the proper singleton based on desired network type. 	
				if (this.networkType == SocialNetwork.BUDDY) 
					net = BuddyNetwork.getInstance();
				if (this.networkType == SocialNetwork.ROMANCE) 
					net = RomanceNetwork.getInstance();
				if(this.networkType == SocialNetwork.TRUST)
					net = TrustNetwork.getInstance();
				if (this.networkType == SocialNetwork.FAMILYBOND)
					net = FamilyBondNetwork.getInstance();
				
				//Debug.debug(this, "evalNetwork(" + first.name + ", " + second.name + ") this: " + this + " netvalue: " + net.getWeight(firstID, secondID) );
					
				if (getNumberFromComparator(this.comparator) == LESSTHAN) {
					//need social network as class
					if (net.getWeight(firstID, secondID) < this.networkValue)
						return Util.xor(this.negated, true);
				}else if (getNumberFromComparator(this.comparator)== GREATERTHAN) {
					//need social network as class
					if (net.getWeight(firstID, secondID) > this.networkValue)
						return Util.xor(this.negated, true);
				}else if (getNumberFromComparator(this.comparator) == AVERAGEOPINION) {
					if (net.getAverageOpinion(firstID) > this.networkValue) {
						return Util.xor(this.negated, true);
					}
				}else if (getNumberFromComparator(this.comparator) == FRIENDSOPINION ||
							getNumberFromComparator(this.comparator) == DATINGOPINION ||
							getNumberFromComparator(this.comparator) == ENEMIESOPINION ) {
					//get the Cast singleton
					
					//know the person who is the obj of opinion
					//know the person's friends
					//get the id's of A's friends
					var cast:Cast = Cast.getInstance();
					//var rel:RelationshipNetwork = RelationshipNetwork.getInstance();
					var sum:Number = 0.0;
					var relationshipCount:Number = 0.0;
					var i:int = 0;
					
					// (April) Relationship Stuff
					/*for each(var char:Character in cast.characters) {
						//first's friends opinion about second
						
						//are they first's friend? test example:
						//first is robert
						//second is karen
						if (char.name != first.name && char.name != second.name) {
							if(getNumberFromComparator(this.comparator) == FRIENDSOPINION) {
								if (rel.getRelationship(RelationshipNetwork.FRIENDS, char, first)) {
									//Debug.debug(this, char.name + "'s opinion used: " + net.getWeight(char.networkID, second.networkID), 5);
									sum += net.getWeight(char.networkID, second.networkID);
									relationshipCount++;
								}
							}else if(getNumberFromComparator(this.comparator) == DATINGOPINION) {
								if (rel.getRelationship(RelationshipNetwork.DATING, char, first)) {
									//Debug.debug(this, char.name + "'s opinion used: " + net.getWeight(char.networkID, second.networkID), 5);
									sum += net.getWeight(char.networkID, second.networkID);
									relationshipCount++;
								}
							}else if(getNumberFromComparator(this.comparator) == ENEMIESOPINION) {
								if (rel.getRelationship(RelationshipNetwork.ENEMIES, char, first)) {
									//Debug.debug(this, char.name + "'s opinion used: " + net.getWeight(char.networkID, second.networkID), 5);
									sum += net.getWeight(char.networkID, second.networkID);
									relationshipCount++;
								}
							}
							//if A's friend is the target, they don't count
						}
					}*/
					
					/*if (relationshipCount < 1) {
						return false;
					}*/
					
					//Debug.debug(this, "FriendsOpinion " + sum + " " + friendCount, 5);
					/*if(relationshipCount > 0.0) {
						if ( (sum / relationshipCount) < this.networkValue) {
							return Util.xor(this.negated, true);
						}
					}*/
				}
				//default return
				return Util.xor(this.negated, false);
			}
			//Debug.debug(this, "Should not eval the networks of non-characters " + firstObj.name + " + " + secondObj.name);
			return false;
		}
		
		
		public function evalCKBEntry(first:CiF.GameObject, second:CiF.GameObject):Boolean {
			//get instance of CKB
			var ckb:CulturalKB = CulturalKB.getInstance();
			var firstResults:Vector.<String>;
			var secondResults:Vector.<String>;
			var i:Number = 0;
			var j:Number = 0;
			
			if(!second) {			
			//determine if the single character constraints results in a match
				firstResults = ckb.findItem(first.name, this.firstSubjectiveLink, this.truthLabel);
				//Debug.debug(this, first.name + " " + this.firstSubjectiveLink + " " + this.truthLabel );
				return firstResults.length > 0;
			} else {			
				//Might want to push this functionality into the CKB
				//determine if the two character constraints result in a match
				//1. find first matches
				firstResults = ckb.findItem(first.name, this.firstSubjectiveLink, this.truthLabel);
				//2. find second matches
				secondResults = ckb.findItem(second.name, this.secondSubjectiveLink, this.truthLabel);
				//3. see if any of first's matches intersect second's matches.
				for (i = 0; i < firstResults.length ; ++i) {
					for (j = 0; j < secondResults.length; ++j) { 
						//Debug.debug(this, firstResults[i] + " and " + secondResults[j]);
						if (firstResults[i] == secondResults[j]) {
							//Debug.debug(this, "evalCKBEntry() "+this.toString());
							//Debug.debug(this, "evalCKBEntry() first: "+firstResults[i]+" second: "+secondResults[j]);
							return true;
						}
					}
				}
				return false;
			}
			return false;
		}
		
		/**
		 * This is similar to evalCKBEntry.  However, unlike evalCKBEntry, which
		 * only returns a boolean value if an object that fits the criteria exists
		 * or not, here we actually produce a list of all objects that DO fulfill
		 * the requirements, and then returns that list of objects as a vector.
		 * 
		 * @see evalCKBEntry
		 * 
		 * @param	first The First Character who holds an opinion on this ckb object
		 * @param	second The Second Character who holds an opinion on this ckb object
		 * @return
		 */
		public function evalCKBEntryForObjects(first:CiF.GameObject, second:CiF.GameObject):Vector.<String> {
			//get instance of CKB
			var ckb:CulturalKB = CulturalKB.getInstance();
			var firstResults:Vector.<String>;
			var secondResults:Vector.<String>;
			var intersectedResults:Vector.<String> = new Vector.<String>();
			var i:Number = 0;
			var j:Number = 0;
			
			if(!second) {			
			//determine if the single character constraints results in a match
				firstResults = ckb.findItem(first.name, this.firstSubjectiveLink, this.truthLabel);
				//Debug.debug(this, "evalCKBEntryForObjects() " + first.name + " " + this.firstSubjectiveLink + " " + this.truthLabel );
				return firstResults;
			} else {			
				//Might want to push this functionality into the CKB
				//determine if the two character constraints result in a match
				//1. find first matches
				firstResults = ckb.findItem(first.name, this.firstSubjectiveLink, this.truthLabel);
				//Debug.debug(this,"evalCKBEntryForObjects() "+this.toString());
				
				
				if (secondSubjectiveLink == "")
				{
					return firstResults;
				}
				
				//Debug.debug(this, "OK, we just filled up first results: " + firstResults.toString());
				//2. find second matches
				secondResults = ckb.findItem(second.name, this.secondSubjectiveLink, this.truthLabel);
				//3. see if any of first's matches intersect second's matches.
				for (i = 0; i < firstResults.length ; ++i) {
					//Debug.debug(this, "Going through all of the first results... " + firstResults[i]);
					for (j = 0; j < secondResults.length; ++j) { 
						//Debug.debug(this, firstResults[i] + " and " + secondResults[j]);
						if (firstResults[i] == secondResults[j]) {
							intersectedResults.push(firstResults[i]);
							//Debug.debug(this, "evalCKBEntryForObjects() we found a mutual object that fits all requirements! " + firstResults[i]);
						}
					}
				}
				return intersectedResults;
			}
			return "WHAAA HOW DID WE GET HERE?!?!";
		}
		
		/**
		 * Evaluates the truth of the SFDBLabel type Predicate given a set of characters. This
		 * evaluation is different from most other predicates in that it is always based in 
		 * history. Every SFDBLabel type predicate looks back in the social facts database to
		 * see if the label of the predicate was true for the characters in the past. If there
		 * is a match in history, it is evaluated true.
		 * 
		 * Note: we currently do not allow for a third character to be used.
		 * 
		 * @param	first
		 * @param	second
		 * @param	third
		 * @return
		 */
		public function evalSFDBLABEL(first:GameObject, second:GameObject, third:GameObject):Boolean {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			//Debug.debug(this, "evalSFDBLABEL() result: " + cif.sfdb.findLabelFromValues(this.sfdbLabel, first, second, third, this.window).length + " toString: "+this.toString());
			
			//if it is a category of label
			if (this.sfdbLabel <= SocialFactsDB.LAST_CATEGORY_COUNT && this.sfdbLabel >= 0)
			{
				for each (var fromCategoryLabel:Number in CiF.SocialFactsDB.CATEGORIES[this.sfdbLabel])
				{
					if (cif.sfdb.findLabelFromValues(fromCategoryLabel, first, second, null, this.window,this).length > 0)
						return (this.negated)?false:true;					
				}
			}
			else
			{
				//normal look up
				if (cif.sfdb.findLabelFromValues(this.sfdbLabel, first, second, null, this.window, this).length > 0)
				{
					
					return (this.negated)?false:true;
				}
			}
			return (this.negated)?true:false;
		}

		/**
		 * Determines the character name bound to the first (primary) character variable role in this predicate given
		 * a context of characters in roles.
		 * @param	initiator
		 * @param	responder
		 * @param	other
		 * @return The name of the primary character associated with the predicate character variable and role context.
		 */
		public function primaryCharacterNameFromVariables(initiator:GameObject, responder:GameObject, other:GameObject):String {
			switch(this.getPrimaryValue()) {
				case "initiator":
					return initiator.name;
				case "responder":
					return responder.name;
				case "other":
					return other.name;
				case "":
					return "";
			}
			return this.primary;
		}

		/**
		 * Determines the character name bound to the second (secondary) character variable role in this predicate given
		 * a context of characters in roles.
		 * @param	initiator
		 * @param	responder
		 * @param	other
		 * @return The name of the secondary character associated with the predicate character variable and role context.
		 */
		public function secondaryCharacterNameFromVariables(initiator:GameObject, responder:GameObject, other:GameObject):String {
			switch(this.getSecondaryValue()) {
				case "initiator":
					return initiator.name;
				case "responder":
					return responder.name;
				case "other":
					return other.name;
				case "":
					return "";
			}
			return this.secondary;
		}
		
		/**
		 * Determines the character name bound to the third (tertiary) character variable role in this predicate given
		 * a context of characters in roles.
		 * @param	initiator
		 * @param	responder
		 * @param	other
		 * @return The name of the tertiary character associated with the predicate character variable and role context.
		 */
		public function tertiarynameFromVariables(initiator:GameObject, responder:GameObject, other:GameObject):String {
			switch(this.getTertiaryValue()) {
				case "initiator":
					return initiator.name;
				case "responder":
					return responder.name;
				case "other":
					return other.name;
				case "":
					return "";
			}
			return this.tertiary;
		}
		
		/**********************************************************************
		 * Utility functions.
		 *********************************************************************/
		public function toString(): String{
			var returnstr:String = new String();
			var switchType:Number = this.type;
			
			switch(switchType) {
				case Predicate.TRAIT: 
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += "trait(" + this.primary + ", " + Trait.getNameByNumber(this.trait) + ")";
					break;
				case Predicate.NETWORK:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += SocialNetwork.getNameFromType(this.networkType) + "Network(" + this.primary + ", " + this.secondary + ") " + this.comparator + " " + this.networkValue;
					break;
				case Predicate.STATUS:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					if (this.status >= Status.FIRST_DIRECTED_STATUS || 
						this.status == Status.CAT_FEELING_BAD_ABOUT_SOMEONE ||
						this.status == Status.CAT_FEELING_GOOD_ABOUT_SOMEONE) {
							// Status is directed
							returnstr += "status(" + this.primary + ", " + this.secondary + ", " + Status.getStatusNameByNumber(this.status) + ", " + this.statusDuration + ")";
						}
					else {
						returnstr += "status(" + this.primary + ", " + Status.getStatusNameByNumber(this.status) + ", " + this.statusDuration + ")";
					}
					break;
				case Predicate.CKBENTRY:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += "ckb(" + this.primary + ", " + this.firstSubjectiveLink + ", " + this.secondary + ", " + this.secondSubjectiveLink + ", " + this.truthLabel + ")";
					break;
					//sfdb not complete
				case Predicate.SFDBLABEL:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += "SFDBLabel(" + SocialFactsDB.getLabelByNumber(this.sfdbLabel) + "," + this.primary + "," + this.secondary;
					returnstr += "," + this.sfdbOrder + ")";
					break;
				/*case Predicate.RELATIONSHIP:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += "relationship(" + this.primary + ", " + this.secondary + ", " + RelationshipNetwork.getRelationshipNameByNumber(this.relationship) + ")";
					break;*/
/*				case Predicate.KNOWLEDGE:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += "hasKnowledge(" + this.primary + ", " + Knowledge.getNameByNumber(this.knowledge) + ")";
					break;
				case Predicate.GIVEKNOWLEDGE:
					returnstr = new String();
					if (this.negated) {
						returnstr += "~";
					}
					returnstr += "giveKnowledge(" + this.primary + ", " + this.secondary + ", " + Knowledge.getNameByNumber(this.knowledge) + ")";
					break;*/
				default:
					Debug.debug(this, "tried to make a predicate of unknown type a String.");
					return "";
			}
			if (isSFDB) returnstr = "[" + returnstr + " window(" + this.window +")]";
			if (intent) return "{" + returnstr + "}";
			return returnstr;

		}
		
		public function toObject():Object {
			var newObj:Object = new Object();
			newObj.name = this.name;
			newObj.intent=this.intent;
			newObj.intentType=this.intentType;
			newObj.isSFDB = this.isSFDB;
			newObj.window = this.window;
			newObj.numTimesUniquelyTrueFlag = this.numTimesUniquelyTrueFlag;
			newObj.numTimesUniquelyTrue = this.numTimesUniquelyTrue;
			newObj.numTimesRoleSlot = this.numTimesRoleSlot;
			if(this.sfdbOrder > 0)
				newObj.sfdbOrder = this.sfdbOrder;
			if(this.intent) {
				switch(this.intentType) {
					case Predicate.INTENT_NETWORK_UP:
					case Predicate.INTENT_NETWORK_DOWN:
						newObj.type = 1;
						newObj.networkType = SocialNetwork.getNameFromType(this.networkType);
						newObj.first=this.first;
						newObj.second=this.second;
						newObj.comparator=this.comparator;
						newObj.value=this.networkValue;
						newObj.negated=this.negated;
						break;
					case Predicate.INTENT_ADD_STATUS:
					case Predicate.INTENT_REMOVE_STATUS:
						newObj.type=2;
						newObj.status=Status.getStatusNameByNumber(this.status);
						newObj.first=this.first;
						newObj.second=this.second;
						newObj.negated=this.negated
						break;
				}			
			}
			else
			{
				switch(this.type) {
					case Predicate.TRAIT:
						newObj.type=Predicate.TRAIT;
						newObj.trait=this.trait;
						newObj.first=this.first;
						newObj.negated=this.negated;
						break;
					case Predicate.NETWORK:
						newObj.type=Predicate.NETWORK;
						newObj.networkType = this.networkType;
						newObj.first=this.first;
						newObj.second=this.second;
						newObj.comparator=this.comparator;
						newObj.networkValue=this.networkValue;
						newObj.negated=this.negated;
						break;
					case Predicate.STATUS:
						newObj.type=Predicate.STATUS;
						newObj.status=this.status; 
						newObj.first=this.first;
						newObj.second=this.second;
						newObj.negated=this.negated;
						newObj.statusDuration=this.statusDuration;
						break;
					case Predicate.CKBENTRY:
						newObj.type = Predicate.CKBENTRY;
						newObj.first=this.first;
						newObj.second=this.second;
						newObj.firstSubjective = this.firstSubjectiveLink;
						newObj.secondSubjective=this.secondSubjectiveLink;
						newObj.label = this.truthLabel;
						newObj.negated=this.negated;
						break;
					//sfdb not complete
					case Predicate.SFDBLABEL:
						newObj.type=Predicate.SFDBLABEL;
						newObj.first=this.first;
						newObj.second=this.second;
						newObj.label=this.sfdbLabel;
						newObj.negated=this.negated;
						break;
				}
			}
			return newObj;
		}
		
		public function toXMLString(): String {
			var returnstr:String = new String();
			var common:String = "name=\"" + this.name + "\" intent=\"" + this.intent + "\" intentType=\"" + this.intentType;
			common += "\" isSFDB=\"" + this.isSFDB + "\" window=\"" + this.window;
			common +=  "\"" + "numTimesUniquelyTrueFlag=\"" + this.numTimesUniquelyTrueFlag + "\"" + "numTimesUniquelyTrue=\"" + this.numTimesUniquelyTrue;
			common +=  "\"" + "numTimesRoleSlot=\"" + this.numTimesRoleSlot +  "\" ";
			
			if (this.sfdbOrder > 0)
				common += "sfdbOrder=\"" + this.sfdbOrder + "\" ";
				
			if (this.intent)
			{
				switch(this.intentType) {
					case Predicate.INTENT_NETWORK_UP:
					case Predicate.INTENT_NETWORK_DOWN:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "network\" networkType=\"" + SocialNetwork.getNameFromType(this.networkType) + "\" first=\"" + this.first + "\" second=\"" + this.second;
						returnstr += "\" comparator=\"" + this.comparator + "\" value=\"" + this.networkValue + "\" negated=\""  + this.negated + "\" " + common +"/>";
						break;
					case Predicate.INTENT_ADD_STATUS:
					case Predicate.INTENT_REMOVE_STATUS:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "status\" status=\"" + Status.getStatusNameByNumber(this.status) + "\" first=\"" + this.first + "\" second=\"" + this.second;
						returnstr += "\" negated=\""  + this.negated + "\" " + common +"/>";
						break;
					default:
						Debug.debug(this, "toXMLString(): type not found: " + this.toString());
						return "";
				}
				trace(returnstr);
			}
			else
			{
				switch(this.type) {
					case Predicate.TRAIT:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "trait\" trait=\"" + Trait.getNameByNumber(this.trait) + "\" first=\"" + this.first + "\" negated=\""  + this.negated + "\" " + common +"/>";
						break;
					case Predicate.NETWORK:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "network\" networkType=\"" + SocialNetwork.getNameFromType(this.networkType) + "\" first=\"" + this.first + "\" second=\"" + this.second;
						returnstr += "\" comparator=\"" + this.comparator + "\" value=\"" + this.networkValue + "\" negated=\""  + this.negated + "\" " + common +"/>";
						break;
					case Predicate.STATUS:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "status\" status=\"" + Status.getStatusNameByNumber(this.status) + "\" first=\"" + this.first + "\" second=\"" + this.second;
						returnstr += "\" negated=\""  + this.negated + "\" duration=\"" + this.statusDuration + "\"" + common +"/>";
						break;
					case Predicate.CKBENTRY:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "CKBEntry\" first=\"" + this.first + "\" second=\"" + this.second + "\" firstSubjective=\"" + this.firstSubjectiveLink + "\" secondSubjective=\"";
						returnstr += this.secondSubjectiveLink + "\" label=\"" + this.truthLabel + "\" negated=\""  + this.negated + "\" " + common +"/>";
						break;
						//sfdb not complete
					case Predicate.SFDBLABEL:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "SFDB label\" first=\"" + this.first + "\" second=\"" + this.second + "\" label=\"" +SocialFactsDB.getLabelByNumber(this.sfdbLabel);
						returnstr += "\" negated=\""  + this.negated + "\"" + common + "/>";
						break;
					/*case Predicate.RELATIONSHIP:
						returnstr = new String();
						returnstr += "<Predicate type=\"";
						returnstr += "relationship\" first=\"" + this.first + "\" second=\"" + this.second + "\" relationship=\"";
						returnstr += RelationshipNetwork.getRelationshipNameByNumber(this.relationship) + "\" negated=\""  + this.negated + "\" " + common + "/>";
						break;*/
/*					case Predicate.KNOWLEDGE:
						returnstr = new String();
						returnstr += "knowledge\" first=\"" + this.first + "\" second=\"" + this.second + "\" knowledge=\"" + Knowledge.getNameByNumber(this.knowledge);
						returnstr += "\" negated=\"" + this.negated + "\" " + common + "/>"; 
						break;*/
					default:
						Debug.debug(this, "toXMLString(): type not found: " + this.toString());
						return "";
				}
			}
			return returnstr;
		}
		
		public function clone(): Predicate {
			var p:Predicate = new Predicate();
			p.name = this.name;
			p.description = this.description;
			p.intentType = this.intentType;
			p.type = this.type;
			p.trait = this.trait;
			p.primary = this.primary;
			p.secondary = this.secondary;
			p.tertiary = this.tertiary;
			p.networkValue = this.networkValue;
			p.comparator = this.comparator;
			p.operator = this.operator;
			//p.relationship = this.relationship;
			p.status = this.status;
			p.statusDuration = this.statusDuration;
			p.networkType = this.networkType;
			p.firstSubjectiveLink = this.firstSubjectiveLink;
			p.secondSubjectiveLink = this.secondSubjectiveLink;
			p.truthLabel = this.truthLabel;
			p.negated = this.negated;
			p.window = this.window;
			p.isSFDB = this.isSFDB;
			p.sfdbLabel = this.sfdbLabel;
			p.intent = this.intent;
			p.numTimesUniquelyTrueFlag = this.numTimesUniquelyTrueFlag;
			p.numTimesUniquelyTrue = this.numTimesUniquelyTrue;
			p.numTimesRoleSlot = this.numTimesRoleSlot;
			p.sfdbOrder = this.sfdbOrder;
			p.knowledge = this.knowledge;
			p.item = this.item;
			return p;
		}
		/**
		 * This is a semantic equality function where select properties are
		 * tested for equality such that the two predicates have the same
		 * meaning.
		 * @param	x	First predicate to test for equality.
		 * @param	y	Second predicate to test for equality.
		 * @return 	True if the predicates have the same meaning or false if
		 * they do not.
		 */
		public static function equals(x:Predicate, y:Predicate):Boolean {
			if (x.type != y.type) return false;
			if (x.intent != y.intent) return false;
			if (x.negated != y.negated) return false;
			if (x.isSFDB != y.isSFDB) return false;
			if (x.numTimesUniquelyTrueFlag != y.numTimesUniquelyTrueFlag) return false;
			if (x.numTimesUniquelyTrue != y.numTimesUniquelyTrue) return false;
			if (x.numTimesUniquelyTrueFlag)
			{
				// only check this if we have are a numTimesUniquelyTrue type predicate.
				// This helps get around a problem where a lot of the roles are set wrong.
				if (x.numTimesRoleSlot != y.numTimesRoleSlot) return false;
			}
			
			switch(x.type) {
				case Predicate.TRAIT:
					if (x.trait != y.trait) return false;
					if (x.primary != y.primary) return false;
					break;
				case Predicate.STATUS:
					if (x.status != y.status) return false;
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					break;
				/*case Predicate.RELATIONSHIP:
					if (x.relationship != y.relationship) return false;
					if (!((x.primary == y.primary) || (x.primary == y.secondary))) return false;
					if (!((x.secondary == y.primary) || (x.secondary == y.secondary))) return false;
					break;*/
				case Predicate.NETWORK:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.networkType != y.networkType) return false;
					if (x.networkValue != y.networkValue) return false;
					if (x.comparator!= y.comparator) return false;
					if (x.operator != y.operator) return false;
					break;
				case Predicate.CKBENTRY:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.firstSubjectiveLink!= y.firstSubjectiveLink) return false;
					if (x.secondSubjectiveLink!= y.secondSubjectiveLink) return false;
					if (x.truthLabel != y.truthLabel) return false;
					break;
				case Predicate.SFDBLABEL:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.sfdbLabel != y.sfdbLabel) return false;
					if (x.negated != y.negated) return false;
					if (x.sfdbOrder!= y.sfdbOrder) return false;
					break;/*
				case Predicate.KNOWLEDGETRAIT:
					if (x.primary != y.primary) return false;
					if (x.negated != y.negated) return false;
					if (x.knowledge != y.knowledge) return false;
					if (x.trait != y.trait) return false;
					break;
				case Predicate.KNOWLEDGE:
//				case Predicate.PASTITEMS:
//				case Predicate.DESIREDITEMS:
					if (x.primary != y.primary) return false;
					if (x.negated != y.negated) return false;
					if (x.knowledge != y.knowledge) return false;
					break;
				case Predicate.GIVEKNOWLEDGE:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.negated != y.negated) return false;
					if (x.knowledge != y.knowledge) return false;
					break;
				case Predicate.GIVEITEM:
					if (x.secondary != y.secondary) return false;
				case Predicate.ITEMTRAIT:
					if (x.trait != y.trait) return false;
				case Predicate.ITEM:
					if (x.primary != y.primary) return false;
					if (x.negated != y.negated) return false;
					if (x.item != y.item) return false;
				break;*/
				default:
					Debug.debug(x, "equals(): unknown Predicate type checked for equality: " + x.type);
					return false;
			}
			return true;
		}
		
		/**
		 * Determines if the structures of two Predicates are equal where
		 * structure is every Predicate parameter other than the character 
		 * variables (primary, secondary, and tertiary) and isSFDB.
		 * 
		 * @param	x
		 * @param	y
		 * @return	True if the structures of the Predicate match or false if they do not.
		 */
		public static function equalsEvaluationStructure(x:Predicate, y:Predicate):Boolean {
			if (x.type != y.type) return false;
			if (x.intent != y.intent) return false;
			if (x.negated != y.negated) return false;
			//if (x.isSFDB != y.isSFDB) return false;
			if (x.numTimesUniquelyTrueFlag != y.numTimesUniquelyTrueFlag) return false;
			if (x.numTimesUniquelyTrue != y.numTimesUniquelyTrue) return false;
			if (x.numTimesRoleSlot != y.numTimesRoleSlot) return false;
			
			switch(x.type) {
				case Predicate.TRAIT:
					if (x.trait != y.trait) return false;
					break;
				case Predicate.STATUS:
					if (x.status != y.status) return false;
					break;
				/*case Predicate.RELATIONSHIP:
					if (x.relationship != y.relationship) return false;
					break;*/
				case Predicate.NETWORK:
					if (x.networkType != y.networkType) return false;
					if (x.networkValue != y.networkValue) return false;
					if (x.comparator!= y.comparator) return false;
					if (x.operator != y.operator) return false;
					break;
				case Predicate.CKBENTRY:
					if (x.firstSubjectiveLink!= y.firstSubjectiveLink) return false;
					if (x.secondSubjectiveLink!= y.secondSubjectiveLink) return false;
					if (x.truthLabel != y.truthLabel) return false;
					break;
				case Predicate.SFDBLABEL:
					if (x.sfdbLabel != y.sfdbLabel) return false;
					if (x.negated != y.negated) return false;
					break;
				default:
					Debug.debug(x, "structureEquals(): unknown Predicate type checked for equality: " + x.type);
					return false;
			}
			return true;
			
		}
		
		
		/**
		 * Determines if the structures of two Predicates are equal where
		 * structure is every Predicate parameter other than the character 
		 * variables (primary, secondary, and tertiary) and isSFDB.
		 * 
		 * This function is for comparing ordered rules (which represent change) 
		 * with effect change rules in SGs played in the past.
		 * 
		 * @param	x
		 * @param	y
		 * @return	True if the structures of the Predicate match or false if they do not.
		 */ 
		public static function equalsValuationStructure(x:Predicate, y:Predicate):Boolean {
			if (x.type != y.type) return false;
			if (x.intent != y.intent) return false;
			if (x.negated != y.negated) return false;
			//if (x.isSFDB != y.isSFDB) return false;
			if (x.numTimesUniquelyTrueFlag != y.numTimesUniquelyTrueFlag) return false;
			if (x.numTimesUniquelyTrue != y.numTimesUniquelyTrue) return false;
			if (x.numTimesRoleSlot != y.numTimesRoleSlot) return false;
			
			switch(x.type) {
				case Predicate.TRAIT:
					if (x.trait != y.trait) return false;
					break;
				case Predicate.STATUS:
					if (x.status != y.status) return false;
					break;
				/*case Predicate.RELATIONSHIP:
					if (x.relationship != y.relationship) return false;
					break;*/
				case Predicate.NETWORK:
					if (x.networkType != y.networkType) return false;
					//Ignore network value -- the type of change is enough.
					//if (x.networkValue != y.networkValue) return false;
					if (x.operator != y.operator) return false;
					break;
				case Predicate.CKBENTRY:
					if (x.firstSubjectiveLink!= y.firstSubjectiveLink) return false;
					if (x.secondSubjectiveLink!= y.secondSubjectiveLink) return false;
					if (x.truthLabel != y.truthLabel) return false;
					break;
				case Predicate.SFDBLABEL:
					if (x.sfdbLabel != y.sfdbLabel) return false;
					if (x.negated != y.negated) return false;
					break;
				default:
					Debug.debug(x, "structureEquals(): unknown Predicate type checked for equality: " + x.type);
					return false;
			}
			return true;
			
		}
		
		
		public static function deepEquals(x:Predicate, y:Predicate): Boolean {
			if (x.type != y.type) return false;
			if (x.trait != y.trait) return false;
			if (x.intent != y.intent) return false;
			if (x.primary != y.primary) return false;
			if (x.secondary != y.secondary) return false;
			if (x.tertiary != y.tertiary) return false;
			if (x.networkValue != y.networkValue) return false;
			if (x.comparator != y.comparator) return false;
			if (x.operator != y.operator) return false;
			//if (x.relationship != y.relationship) return false;
			if (x.status != y.status) return false;
			if (x.networkType != y.networkType) return false;
			if (x.firstSubjectiveLink != y.firstSubjectiveLink) return false;
			if (x.secondSubjectiveLink != y.secondSubjectiveLink) return false;
			if (x.truthLabel != y.truthLabel) return false;
			if (x.negated != y.negated) return false;
			if (x.window != y.window) return false;
			if (x.isSFDB != y.isSFDB) return false;
			if (x.sfdbLabel != y.sfdbLabel) return false;
			if (x.numTimesUniquelyTrueFlag != y.numTimesUniquelyTrueFlag) return false;
			if (x.numTimesUniquelyTrue != y.numTimesUniquelyTrue) return false;
			if (x.numTimesRoleSlot != y.numTimesRoleSlot) return false;
			if (x.sfdbOrder!= y.sfdbOrder) return false;
			return true;
		}
		
		public static function equalsForMicrotheoryDefinitionAndSocialGameIntent(x:Predicate, y:Predicate):Boolean {
			if (x.type != y.type) return false;
			//if (x.intent != y.intent) return false;
			if (x.negated != y.negated) return false;
			if (x.isSFDB != y.isSFDB) return false;
						
			if (x.numTimesUniquelyTrueFlag != y.numTimesUniquelyTrueFlag) return false;
			if (x.numTimesUniquelyTrue != y.numTimesUniquelyTrue) return false;
			if (x.numTimesRoleSlot != y.numTimesRoleSlot) return false;
			if (x.sfdbOrder!= y.sfdbOrder) return false;
			
			switch(x.type) {
				case Predicate.TRAIT:
					if (x.trait != y.trait) return false;
					if (x.primary != y.primary) return false;
					break;
				case Predicate.STATUS:
					if (x.status != y.status) return false;
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					break;
				/*case Predicate.RELATIONSHIP:
					if (x.relationship != y.relationship) return false;
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					break;*/
				case Predicate.NETWORK:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.networkType != y.networkType) return false;
					if (x.networkValue != y.networkValue) return false;
					if (x.comparator!= y.comparator) return false;
					if (x.operator != y.operator) return false;
					break;
				case Predicate.CKBENTRY:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.firstSubjectiveLink!= y.firstSubjectiveLink) return false;
					if (x.secondSubjectiveLink!= y.secondSubjectiveLink) return false;
					if (x.truthLabel != y.truthLabel) return false;
					break;
				case Predicate.SFDBLABEL:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.sfdbLabel != y.sfdbLabel) return false;
					if (x.negated != y.negated) return false;
					break;
					/*
				case Predicate.KNOWLEDGETRAIT:
					if (x.primary != y.primary) return false;
					if (x.negated != y.negated) return false;
					if (x.knowledge != y.knowledge) return false;
					if (x.trait != y.trait) return false;
					break;
				case Predicate.KNOWLEDGE:
//				case Predicate.PASTITEMS:
//				case Predicate.DESIREDITEMS:
					if (x.primary != y.primary) return false;
					if (x.negated != y.negated) return false;
					if (x.knowledge != y.knowledge) return false;
					break;
				case Predicate.GIVEKNOWLEDGE:
					if (x.primary != y.primary) return false;
					if (x.secondary != y.secondary) return false;
					if (x.negated != y.negated) return false;
					if (x.knowledge != y.knowledge) return false;
					break;
				case Predicate.GIVEITEM:
					if (x.secondary != y.secondary) return false;
				case Predicate.ITEMTRAIT:
					if (x.trait != y.trait) return false;
				case Predicate.ITEM:
					if (x.primary != y.primary) return false;
					if (x.negated != y.negated) return false;
					if (x.item != y.item) return false;
				break;*/
				default:
					Debug.debug(x, "equals(): unknown Predicate type checked for equality: " + x.type);
					return false;
			}
			return true;
		}
		
		/**
		 * This function returns a natural language name of the given predicate.
		 * So, for example, instead of some weird scary code-looking implementation
		 * such as wants_to_pick_on(i->r), it would return something alone the lines of
		 * "Karen wants to pick on Robert"  I think, at least for this first pass, that
		 * we are not going to care about pronoun replacement, or anything along
		 * those lines!
		 * 
		 * @param	primary The actual name of the initiator (eg "Karen")
		 * @param	secondary The actual name of the responder (eg "Robert")
		 * @param	tertiary The actual name of the other (eg "Edward")
		 */
		public function toNaturalLanguageString(primary:String = "Karen", secondary:String = "Robert", tertiary:String = "Edward"):String {
			var predicateName:String = getNameByType(this.type); // "network", "relationship", etc.
			var naturalLanguageName:String = "";
			primary = makeFirstLetterUpperCase(primary);
			secondary = makeFirstLetterUpperCase(secondary);
			if (tertiary != null) tertiary = makeFirstLetterUpperCase(tertiary);
			//trace("predicate name = " + predicateName);
			if(!this.numTimesUniquelyTrueFlag){ // what follows is the 'normal' stuff -- we need to do something special if it is a num times uniquely true predicate.
				switch (predicateName){
					case "network":
						naturalLanguageName = networkToNaturalLanguage(primary, secondary , tertiary);
						break;
					/*case "relationship":
						naturalLanguageName = relationshipPredicateToNaturalLanguage(primary, secondary, tertiary);
						break;*/
					case "trait":
						naturalLanguageName = traitPredicateToNaturalLanguage(primary, secondary, tertiary);
						break;
					case "status":
						naturalLanguageName = statusPredicateToNaturalLanguage(primary, secondary, tertiary);
						break;
					case "CKB":
						naturalLanguageName = ckbPredicateToNaturalLanguage(primary, secondary, tertiary);
						break;
					case "SFDBLabel":
						naturalLanguageName = sfdbPredicateToNaturalLanguage(primary, secondary, tertiary);
						break;
					default:
						trace ("Unrecognized predicate type");
				}
			}
			else {
				if (predicateName == "CKB") naturalLanguageName = ckbPredicateToNaturalLanguage(primary, secondary, tertiary); // I handled this case originally!
				else naturalLanguageName = numTimesUniquelyTruePredicateToNaturalLanguage(primary, secondary, tertiary);
			}
			
			//Append SFDB Window information to the natural language predicate.
			var timeElapsed:String = "";
			if(this.isSFDB){
				if (this.window < 0) { // THIS IS BACKSTORY
					timeElapsed = " way back when";
				}
				else if (this.window >= 0 && this.window <= 5) {
					timeElapsed = " recently";
				}
				else if (this.window > 5 && this.window <= 10) {
					timeElapsed = " not too long ago";
				}
				else if (this.window > 10) {
					timeElapsed = " a while ago";
				}
			}
			naturalLanguageName += timeElapsed;
			
			//If we are dealing with something with an SFDB 'order' 
			//we just kind of append that to the end.
			if (this.sfdbOrder > 0) {
				naturalLanguageName += " "
				naturalLanguageName += sfdbOrderToNaturalLanguage();
			}
			
			naturalLanguageName += ".";
			return naturalLanguageName;
		}
		
		/**
		 * This function returns a natural language name of the given predicate.
		 * So, for example, instead of some weird scary code-looking implementation
		 * such as wants_to_pick_on(i->r), it would return something alone the lines of
		 * "Karen wants to pick on Robert"  I think, at least for this first pass, that
		 * we are not going to care about pronoun replacement, or anything along
		 * those lines!
		 * 
		 * @param	primary The actual name of the initiator (eg "Karen")
		 * @param	secondary The actual name of the responder (eg "Robert")
		 * @param	tertiary The actual name of the other (eg "Edward")
		 */
		public function toIntentNLGString():String {
			var naturalLanguageName:String = "";
			if (this.intent){
				var predicateName:String = getNameByType(this.type); // "network", "relationship", etc.
	
				switch (this.intentType){
					case INTENT_NETWORK_UP:
						naturalLanguageName = "(Improve " + SocialNetwork.getNameFromType(this.networkType) + " network)";
						break;
					case INTENT_NETWORK_DOWN:
						naturalLanguageName = "(Weaken " + SocialNetwork.getNameFromType(this.networkType) + " network)";
						break;
					case INTENT_ADD_STATUS:
						naturalLanguageName = "(Add status " + Status.getStatusNameByNumber(this.status) + ")";
						break;
					case INTENT_REMOVE_STATUS:
						naturalLanguageName = "(Remove status " + Status.getStatusNameByNumber(this.status) + ")";
						break;
					default:
						trace ("Unrecognized predicate type");
				}
			}
			return naturalLanguageName;
		}
		
		/**
		 * Specifically handles the converting of a network into a natural language name
		 * (e.g. "BudNetHigh(i->r) is converted to "Karen feels strong feelings of buddy towards Responder"
		 * 
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return The natural language name of the network
		 */
		public function networkToNaturalLanguage(primary:String, secondary:String, tertiary:String):String {
			var naturalLanguageName:String = "";
			var otherPeoplesOpinion:String = "";
			var initiator:String = "";
			var responder:String = "";
			
			if (this.getPrimaryValue() == "initiator")
				initiator = primary;
			else if (this.getPrimaryValue() == "responder")
				initiator = secondary;
			else
				initiator = tertiary;
				
			if (this.getSecondaryValue() == "initiator")
				responder = primary;
			else if (this.getSecondaryValue() == "responder")
				responder = secondary;
			else
				responder = tertiary;
			// simplifying for Mismanor
			if (this.comparator.toLowerCase() == "lessthan")
			{
				if (this.negated)
						naturalLanguageName = initiator + " " + SocialNetwork.getNameFromType(this.networkType) + " towards " + responder +  " isn't low enough";
					else
						naturalLanguageName = initiator + " " + SocialNetwork.getNameFromType(this.networkType) + " towards " + responder + " is low enough";
			}
			else if (this.comparator.toLowerCase() == "greaterthan")
			{
				if (this.negated)
					naturalLanguageName = initiator + " " + SocialNetwork.getNameFromType(this.networkType) + " towards " + responder + " isn't high enough";
				else
					naturalLanguageName = initiator + " " + SocialNetwork.getNameFromType(this.networkType) + " towards " + responder + " is high enough"
			}
			else
				naturalLanguageName = "Network comparator that Anne hasn't dealt with, make her fix it.";

				//First, discover if the predicate is going to be low, medium, or high.
			var isHigh:Boolean = false;;
			var isLow:Boolean = false;;
			var isMedium:Boolean = false;
			
			/* COMPARATORS:
			//
			//greaterthan
			//lessthan
			//AverageOpinion
			//FriendsOpinion
			//DatingOpinion
			//EnemiesOpinion
			//+
			//-
			//DO WE USE THESE BOTTOM ONES EVER?
			//*
			//=
			//EveryoneUp
			//AllFriendsUp
			//AllDatingUp
			//AllEnemiesUp
			*/
			
/*			//Figuring out high/medium/low, but also taking into account the context based on the comparator.
			if (this.networkValue == 66 && this.comparator=="greaterthan") isHigh = true;
			else if (this.networkValue == 34 && this.comparator=="lessthan") isLow = true;
			else if ((this.networkValue == 33 && this.comparator=="greaterthan") || (this.networkValue == 67 && this.comparator == "lessthan")) isMedium = true;

			
			else if (this.networkValue == 66 && (this.comparator == "DatingOpinion" || this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")) isHigh = true; //CONFUSED ABOUT COMPARITORS WITH THESE!!!!
			else if ((this.networkValue == 67 || this.networkValue || 33) && (this.comparator == "DatingOpinion" || this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")) isMedium = true;
			else if (this.networkValue == 34 && (this.comparator == "DatingOpinion" || this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")) isLow = true;
			else if (this.comparator == "+") { // this is a network change thing!
			
				switch(SocialNetwork.getNameFromType(this.networkType)) {
					case "buddy":
						naturalLanguageName = primary + " thinks " + secondary + " is a better buddy by " + this.networkValue + " points"; break;
					case "romance":
						naturalLanguageName = primary + "'s feelings of romance for " + secondary + " went up by " + this.networkValue; break;
					case "trust":
						naturalLanguageName = primary + " finds " + secondary + " to be more trustworthy by " + this.networkValue + " points"; break;
					case "familybond":
						naturalLanguageName = primary + "'s feelings of family bond for " + secondary + " went up by " + this.networkValue; break;
				}
				return naturalLanguageName;
			}
			else if (this.comparator == "-") { // this is a network change thing!
				switch(SocialNetwork.getNameFromType(this.networkType)) {
					case "buddy":
						naturalLanguageName = primary + " thinks " + secondary + " is a worse buddy by " + this.networkValue + " points"; break;
					case "romance":
						naturalLanguageName = primary + "'s feelings of romance for " + secondary + " went down by " + this.networkValue; break;
					case "trust":
						naturalLanguageName = primary + " finds " + secondary + " to be less trustworthy by " + this.networkValue + " points"; break;
					case "familybond":
						naturalLanguageName = primary + "'s feelings of family bond for " + secondary + " went up by " + this.networkValue; break;
				}
				return naturalLanguageName;
			}
			
			if (this.comparator == "DatingOpinion") otherPeoplesOpinion = " is dating someone who";
			else if (this.comparator == "FriendsOpinion") otherPeoplesOpinion = "'s friends, on average,";
			else if (this.comparator == "EnemiesOpinion") otherPeoplesOpinion = "'s enemies, on average,";
			else if (this.comparator == "AverageOpinion") otherPeoplesOpinion = " knows, on average, people";
			
			//Awesome, now I know if it is low, medium, or high.  Now I need to find out which network we are dealing with.
			switch(SocialNetwork.getNameFromType(this.networkType)) {
				case "buddy":
					if (isHigh) {
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = primary + " is dating someone who is a very good buddy of " + secondary;
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " are very good buddies with " + secondary;
						else
							naturalLanguageName = primary + " is a very good buddy of " + secondary;
					}
					else if (isMedium)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = primary + " is dating someone who is a pretty good buddy of " + secondary;
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " are pretty good buddies with " + secondary;
						else
							naturalLanguageName = primary + " is a pretty good buddy of " + secondary;
					else if (isLow)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = primary + " is dating someone who holds low feelings of buddiness for " + secondary;
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " are not very good buddies with " + secondary;
						else
							naturalLanguageName = primary + " holds low feelings of buddiness for " + secondary;
					else naturalLanguageName = "Unrecognized Buddy Value! Value is: " + this.networkValue + " comparator is: " + comparator;
					break;
				case "romance":
					if (isHigh) {
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating has high romance for " + secondary;
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " have high romance for " + secondary;
						else
							naturalLanguageName = primary + " has high romance for " + secondary;
					}
					else if (isMedium) {
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating has some amount of romance for " + secondary;
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " have some amount of romance for " + secondary;
						else
							naturalLanguageName = primary + " has some amount of romance for " + secondary;
					}
					else if (isLow) {
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating feels little romance for " + secondary;
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " hold little romance for " + secondary;
						else
							naturalLanguageName = primary + " feels little romance for " + secondary;
					}
					else naturalLanguageName = "Unrecognized Romance Value! Value: " + this.networkValue + " comparator: " + comparator;
					break;
				case "trust":
					if (isHigh)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating thinks " + secondary + " is really really trustworthy";
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " think " + secondary + " is really trustworthy";
						else
							naturalLanguageName = primary + " thinks " + secondary + " is totally trustworthy";
					else if (isMedium)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating thinks " + secondary + " is pretty trustworthy";
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " think " + secondary + " is kinda trustworthy";
						else
							naturalLanguageName = primary + " finds " + secondary + " to be relatively trustworthy";
					else if (isLow)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating does not think " + secondary + " is very trustworthy at all";
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " think " + secondary + " is not trustworthy";
						else {
							naturalLanguageName = primary + " thinks that " + secondary + " is not very trustworthy at all. value: " + this.networkValue;
						}
					else naturalLanguageName = "Unrecognized Trust Value! Value is: " + this.networkValue + " comparator is: " + comparator;
					break;
				case "familybond":
					if (isHigh)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating thinks " + secondary + " is really really cool";
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " think " + secondary + " is really cool";
						else
							naturalLanguageName = primary + " thinks " + secondary + " is totally cool";
					else if (isMedium)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating thinks " + secondary + " is pretty cool";
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " think " + secondary + " is kinda cool";
						else
							naturalLanguageName = primary + " finds " + secondary + " to be relatively cool";
					else if (isLow)
						if (this.comparator == "DatingOpinion")
							naturalLanguageName = "The person " + primary + " is dating does not think " + secondary + " is very cool at all";
						else  if (this.comparator == "FriendsOpinion" || this.comparator == "EnemiesOpinion" || this.comparator == "AverageOpinion")
							naturalLanguageName = primary + "" + otherPeoplesOpinion + " think " + secondary + " is not cool";
						else {
							naturalLanguageName = primary + " thinks that " + secondary + " is not very cool at all. value: " + this.networkValue;
						}
					else naturalLanguageName = "Unrecognized FamilyBond Value! Value is: " + this.networkValue + " comparator is: " + comparator;
					break;
				default:
					trace ("unrecognized network type (not buddy, not trust, not romance, not family bond)");
				}	
				*/
			return naturalLanguageName;
		}
			
		/**
		 * Here is the function that creates the natural language
		 * version of a relationship.  As in "Karen and Edward are Dating"
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return The natural language name of the relationship
		 */
		/*public function relationshipPredicateToNaturalLanguage(primary:String = "Karen", secondary:String = "Edward", tertiary:String = "Robert"):String {
			//We care about what type of network we are dealing with.
			var naturalLanguageName:String;
			var notString:String = "";
			
			if (this.negated == true) {
				notString = " not";
			}
			
			switch(RelationshipNetwork.getRelationshipNameByNumber(this.relationship)) {
				case 'friends':
					naturalLanguageName = primary + " is" + notString + " friends with " + secondary ;
					break;
				case 'dating':
					naturalLanguageName = primary + " is" + notString + " dating " + secondary;
					break;
				case 'enemies':
					naturalLanguageName = primary + " and " + secondary + " are" + notString + " enemies";
					break;
				default:
					naturalLanguageName = "unrecognized relationship (not friends, dating, or enemies)";
			}
			return naturalLanguageName;
		}*/
		
		/**
		 * @return If it is an intent, returns the intent ID, as defined as consts above. Other wise it returns -1
		 */
		public function getIntentType():int
		{
			if (!this.intent) return -1;
			
			return this.type;
			
			if (this.type == Predicate.NETWORK)
			{
				if (this.comparator == "+")
				{
					return Predicate.INTENT_NETWORK_UP;
				}
				else
				{
					return Predicate.INTENT_NETWORK_DOWN;
				}
			}
			else if (this.type == Predicate.STATUS)
			{
				if (this.negated)
					return Predicate.INTENT_REMOVE_STATUS;
				else
					return Predicate.INTENT_ADD_STATUS;
			}
			/*else if (this.type == Predicate.RELATIONSHIP)
			{
				if (this.relationship == RelationshipNetwork.FRIENDS)
				{
					if (this.negated)
					{
						return Predicate.INTENT_END_FRIENDS;
					}
					else
					{
						return Predicate.INTENT_FRIENDS;
					}
				}
				else if (this.relationship == RelationshipNetwork.DATING)
				{
					if (this.negated)
					{
						return Predicate.INTENT_END_DATING;
					}
					else
					{
						return Predicate.INTENT_DATING;
					}	
				}
				else if (this.relationship == RelationshipNetwork.ENEMIES)
				{
					if (this.negated)
					{
						return Predicate.INTENT_END_ENEMIES;
					}
					else
					{
						return Predicate.INTENT_ENEMIES;
					}
				}
			}*/
			// if we get here, we weren't one of the accepted intents
			//Debug.debug(this, "Intent type not found!");
			return -1;
		}

		public static function getIntentTypeByName(intent:String):int
		{
			switch (intent.toLowerCase())
			{
				case "intent(friends)":
					return Predicate.INTENT_FRIENDS;
				case "intent(end_friends)":
					return Predicate.INTENT_END_FRIENDS;
				case "intent(dating)":
					return Predicate.INTENT_DATING;
				case "intent(end_dating)":
					return Predicate.INTENT_END_DATING;
				case "intent(enemies)":
					return Predicate.INTENT_ENEMIES;
				case "intent(end_enemies)":
					return Predicate.INTENT_END_ENEMIES;					
				case "intent(buddy_up)":
					return Predicate.INTENT_BUDDY_UP;
				case "intent(buddy_down)":
					return Predicate.INTENT_BUDDY_DOWN;
				case "intent(romance_up)":
					return Predicate.INTENT_ROMANCE_UP;
				case "intent(romance_down)":
					return Predicate.INTENT_ROMANCE_DOWN;
				case "intent(trust_up)":
					return Predicate.INTENT_TRUST_UP;
				case "intent(trust_down)":
					return Predicate.INTENT_TRUST_DOWN;
				case "intent(familybond_up)":
					return Predicate.INTENT_FAMILYBOND_UP;
				case "intent(familybond_down)":
					return Predicate.INTENT_FAMILYBOND_DOWN;

				case "intent-network up":
					return Predicate.INTENT_NETWORK_UP;
				case "intent-network down":
					return Predicate.INTENT_NETWORK_DOWN;
				case "intent-add status":
					return Predicate.INTENT_ADD_STATUS;
				case "intent-remove status":
					return Predicate.INTENT_REMOVE_STATUS;
				default:
					return -1;
			}

		}
		
		public static function getIntentNameByNumber(intentID:int):String
		{
			switch(intentID)
			{
				case Predicate.INTENT_FRIENDS:
					return "intent(friends)";
				case Predicate.INTENT_END_FRIENDS:
					return "intent(end_friends)";
				case Predicate.INTENT_DATING:
					return "intent(dating)";
				case Predicate.INTENT_END_DATING:
					return "intent(end_dating)";
				case Predicate.INTENT_ENEMIES:
					return "intent(enemies)";
				case Predicate.INTENT_END_ENEMIES:
					return "intent(end_enemies)";
					
				case Predicate.INTENT_BUDDY_UP:
					return "intent(buddy_up)";
				case Predicate.INTENT_BUDDY_DOWN:
					return "intent(buddy_down)";
				case Predicate.INTENT_ROMANCE_UP:
					return "intent(romance_up)";
				case Predicate.INTENT_ROMANCE_DOWN:
					return "intent(romance_down)";
				case Predicate.INTENT_TRUST_UP:
					return "intent(trust_up)";
				case Predicate.INTENT_TRUST_DOWN:
					return "intent(trust_down)";
				case Predicate.INTENT_FAMILYBOND_UP:
					return "intent(familybond_up)";
				case Predicate.INTENT_FAMILYBOND_DOWN:
					return "intent(familybond_down)";
					
				case Predicate.INTENT_NETWORK_UP:
					return "intent-network up";
				case Predicate.INTENT_NETWORK_DOWN:
					return "intent-network down";
				case Predicate.INTENT_ADD_STATUS:
					return "intent-add status";
				case Predicate.INTENT_REMOVE_STATUS:
					return "intent-remove status";

				default:
					return "";
			}
		}
		
		
		/**
		 * Here is the function that creates the natural language
		 * version of a trait.  As in "Karen is Shy"
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return The natural language name of the relationship
		 */
		public function traitPredicateToNaturalLanguage(primary:String = "Karen", secondary:String = "Edward", tertiary:String = "Robert"):String {
			//We care about what type of trait we are dealing with.
			var naturalLanguageName:String;
			var first:String = this.getPrimaryValue();
			
			if (first == "initiator")
				naturalLanguageName = primary;
			else if (first == "responder")
				naturalLanguageName = secondary;
			else
				naturalLanguageName = tertiary;
				
			var notString:String = " ";
			if (this.negated) {
				notString = " not ";
			}
			
			var theTrait:int = this.trait;
			
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			naturalLanguageName += " is" + notString + Trait.getNameByNumber(theTrait);
			
			return naturalLanguageName;
		}
		
		/**
		 * Turns a status predicate into a natural language
		 * sounding version (Karen is feeling Anxious)
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return The natural language name of the relationship
		 */
		public function statusPredicateToNaturalLanguage(primary:String = "Karen", secondary:String = "Edward", tertiary:String = "Robert"):String {
			//We care about what type of trait we are dealing with.
			var naturalLanguageName:String;
			var towardsName:String;
			
			var first:String = this.getPrimaryValue();
			var second:String = this.getSecondaryValue();
			
			if (first == "initiator")
				naturalLanguageName = primary;
			else if (first == "responder")
				naturalLanguageName = secondary;
			else
				naturalLanguageName = tertiary;

			if (second == "initiator")
				towardsName = primary;
			else if (second == "responder")
				towardsName = secondary;
			else
				towardsName = tertiary;
				
			var notString:String = " ";
			if (this.negated) {
				notString = " not ";
			}
			
			naturalLanguageName += " is" + notString + Status.getStatusNameByNumber(this.status);
			
			if (this.status >= Status.FIRST_DIRECTED_STATUS)
				naturalLanguageName += " towards " + towardsName;
			
			return naturalLanguageName;
		}
		
		/**
		 * 
		 * Turns a ckb thing into a natural language thing.
		 * I'm not exactly sure how to do this one, actually.  I think it will be interesting.
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return The natural language name of the ckb
		 */
		public function ckbPredicateToNaturalLanguage(primary:String = "Karen", secondary:String = "Edward", tertiary:String = "Robert"):String {
			var naturalLanguageName:String = "";
			var amountOfThings:String = "";
			var gestaltTruth:String = "";
			var negatedString:String = "";
			if (negated) {
				negatedString = "it isn't the case that ";
			}
			//likes
			//has
			//dislikes
			//wants
			
			gestaltTruth = this.truthLabel; // cool, lame, romantic, etc.
			

			
			if ( this.firstSubjectiveLink != this.secondSubjectiveLink) {
				//PRIMARY AND SECONDARY DISAGREE
				
				//based on the num times uniquely true, it will use a different word to describe it!
				//But where do I handle negation?
				if (this.numTimesUniquelyTrue == 1 || this.numTimesUniquelyTrue == 0 ) amountOfThings = "something " + gestaltTruth;
				if (this.numTimesUniquelyTrue == 2) amountOfThings = "a couple " + gestaltTruth + " things";
				if (this.numTimesUniquelyTrue >= 3) amountOfThings = "a lot of " + gestaltTruth + " things";
				
				if (this.firstSubjectiveLink == "likes") {
					naturalLanguageName = negatedString + primary + " likes " + amountOfThings + " that " + secondary;
					switch(this.secondSubjectiveLink) {
						case "has": naturalLanguageName += " has";	break;
						case "dislikes": naturalLanguageName += " dislikes";	break;
						case "wants": naturalLanguageName += " wants"; break;
					}
				}
				else if (this.firstSubjectiveLink == "dislikes") {
					naturalLanguageName = primary + " dislikes " + amountOfThings + " that " + secondary;
					switch(this.secondSubjectiveLink) {
						case "likes": naturalLanguageName += " likes"; break;
						case "has": naturalLanguageName += " has"; break;
						case "wants": naturalLanguageName += " wants"; break;
					}
				}
				else if (this.firstSubjectiveLink == "has") {
					naturalLanguageName = primary + " has " + amountOfThings + " that " + secondary;
					switch(this.secondSubjectiveLink) {
						case "likes": naturalLanguageName += " likes"; break;
						case "dislikes": naturalLanguageName += " dislikes"; break;
						case "wants": naturalLanguageName += " wants"; break;
					}
				}
				else if (this.firstSubjectiveLink == "wants") {
					naturalLanguageName = primary + " wants " + amountOfThings + " that " + secondary;
					switch(this.secondSubjectiveLink) {
						case "likes": naturalLanguageName += " likes"; break;
						case "dislikes": naturalLanguageName += " dislikes"; break;
						case "has": naturalLanguageName += " has"; break;
					}
				}
			}
			else if (this.firstSubjectiveLink == this.secondSubjectiveLink) {
				//PRIMARY AND SECONDARY AGREE
				var theirFeeling:String;
				
				if (this.firstSubjectiveLink == "likes") theirFeeling = "like";
				else if (this.firstSubjectiveLink == "dislikes") theirFeeling = "dislike";
				else if (this.firstSubjectiveLink == "wants") theirFeeling = "want";
				else if (this.firstSubjectiveLink == "has") theirFeeling = "have";
	
				//based on the num times uniquely true, it will use a different word to describe it!
				if (this.numTimesUniquelyTrue == 1 || this.numTimesUniquelyTrue == 0 ) naturalLanguageName = primary + " and " + secondary + " both " + theirFeeling + " something " + gestaltTruth;
				if (this.numTimesUniquelyTrue == 2) naturalLanguageName = primary + " and " + secondary + " both " + theirFeeling + " a couple " + gestaltTruth + " things";
				if (this.numTimesUniquelyTrue >= 3) naturalLanguageName = primary + " and " + secondary + " both " + theirFeeling + " several " + gestaltTruth + " things";
			}
			
			return naturalLanguageName;
		}

		
		/**
		 * 
		 * Turns a sfdb thing into a natural language thing.
		 * I'm not exactly sure how to do this one, actually.  I think it will be interesting.
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return The natural language name of the sfdb
		 */
		public function sfdbPredicateToNaturalLanguage(primary:String = "Karen", secondary:String = "Edward", tertiary:String = "Robert"):String {
			var naturalLanguageName:String = "";
			var timeElapsed:String = "";
			var label:int = this.sfdbLabel;
/*			var theLabel:int = this.sfdbLabel;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			if (theLabel <= SocialFactsDB.LAST_CATEGORY_COUNT)
			{
				//resolve which trait they actually have
				for each (var l:int in SocialFactsDB.CATEGORIES[this.sfdbLabel])
				{
					if (cif.cast.getCharByName(primary.toLowerCase()).getStatus(l))
					{
						theLabel = l;
					}
				}
			}*/
			
			var sfdbLabelType:String = SocialFactsDB.getLabelByNumber(label);
			if (SocialFactsDB.CAT_POSITIVE == label) {
				sfdbLabelType = "generally positive";
			}
			else if (SocialFactsDB.CAT_NEGATIVE == label){
				sfdbLabelType = "generally negative";
			}
			
			Debug.debug(this, "label: " + label + " sfdbLabelType: " + sfdbLabelType);
			
			//I forget what order this goes in.
			//For an SFDB Label, there is primary and secondary.
			//Does it go like this:
			//PRIMARY did something RUDE to SECONDARY
			//Or is it
			//SECONDARY did something RUDE to PRIMARY.
			//I forget.  I think it is the first one maybe.
			
			
			//Going to try to move timeElapsed stuff to the outerloop.
			//naturalLanguageName = primary + " did something " + sfdbLabelType + " to " + secondary + " " + timeElapsed;
			naturalLanguageName = primary + " did something " + sfdbLabelType + " to " + secondary;
			
			if (primary == secondary || secondary == "") {
				//This is a case where the SFDB should only care about the primary person.
				//naturalLanguageName = primary + " did something " + sfdbLabelType + " " + timeElapsed;
				naturalLanguageName = primary + " did something " + sfdbLabelType;
				return naturalLanguageName;
			}
			
			return naturalLanguageName;
		}
		
		/**
		 * We need to do some special garbage if we are dealing with num times uniquely true predicates.
		 * Specifically, what we need to do is still go through each kind of predicate (because it is going
		 * to be special for each kind of predicate, relationship, network, etc).  and come up with special
		 * I think it might even be wildly different depending on who the role slot is.  Or, well, maybe
		 * only it is different if it is both.
		 * phrases for each one.
		 * @param	primary The actual name of the primary "Karen"
		 * @param	secondary The actual name of the secondary "Edward"
		 * @param	tertiary The actual name of the tertiary "Robert"
		 * @return  The natural language of the num times uniquely true predicate
		 */
		public function numTimesUniquelyTruePredicateToNaturalLanguage(primary:String = "Karen", secondary:String = "Edward", tertiary:String = "Robert"):String {
			var heroName:String = "";
			var naturalLanguageName:String = "";
			var numTimes:int = this.numTimesUniquelyTrue;
			var predicateName:String = getNameByType(this.type); // "network", "relationship", etc.
			var notString:String = "";
			
			var label:int = this.sfdbLabel;
			
			if (this.negated == true) {
				notString = " not";
			}
			
			if (numTimesRoleSlot.toLowerCase() == "first") {
				heroName = primary;
			}
			else if (numTimesRoleSlot.toLowerCase() == "second") {
				heroName = secondary;
			}
			else if (numTimesRoleSlot.toLowerCase() == "both") {
				heroName = primary + " and " + secondary;
			}
			
			switch (predicateName) {
				case "network": // this one is hard because we need to worry about directionality.
					var isHigh:Boolean = false;
					var isLow:Boolean = false;
					var isMed:Boolean = false;
					if (this.networkValue == 66 && this.comparator=="greaterthan") isHigh = true;
					else if (this.networkValue == 34 && this.comparator=="lessthan") isLow = true;
					else if ((this.networkValue == 33 && this.comparator=="greaterthan") || (this.networkValue == 67 && this.comparator == "lessthan")) isMed = true;
						//let's think about it for a second.
						//let's say that 'first' is the role slot that we care about.
						//then we are interested in things like "First finds 5 people to be cool, or first finds 3 people to be buddis > 60"
						//If 'second' is the role slot that we care about, 
						//then we are interested in things like "5 people find second to be cool"
						//I don't think we need to worry about friend's average opinion for this? Maybe we do, I am going to not worry about it for right now.
						//OK, so, now too bad.
						if (numTimesRoleSlot.toLowerCase() == "first") {
							switch(SocialNetwork.getNameFromType(this.networkType)) {
							case "buddy":
								if (isLow) {
									if (this.negated) {
										naturalLanguageName = heroName + " does not even think that at least " + numTimes + " people aren't very good buddies."; break;
									}
									else {
										naturalLanguageName = heroName + " thinks at least " + numTimes + " people aren't very good buddies."; break;
									}
									
								}
								else if (isMed) {
									if (this.negated) {
										naturalLanguageName = heroName + " does not even think that at least " + numTimes + " people are OK buddies."; break;
									}
									else {
										naturalLanguageName = heroName + " thinks at least " + numTimes + " people are OK buddies."; break;
									}
									
								}
								else if (isHigh) {
									if (this.negated) {
										naturalLanguageName = heroName + " does not even think that at least " + numTimes + " people are great buddies."; break;
									}
									else {
										naturalLanguageName = heroName + " thinks at least " + numTimes + " people are great buddies."; break;
									}
								}
								else {
									naturalLanguageName = "problem with numTimesUniqelyTrue network predicate to Natural Language";
									break;
								}
							case "romance":
								if (isLow) {
									if (this.negated) {
										naturalLanguageName = heroName + " isn't completely romantically disinterested in at least " + numTimes + " people."; break;
									}
									else {
										naturalLanguageName = heroName + " is romantically turned off by at least " + numTimes + " people."; break;
									}
									
								}
								else if (isMed) {
									if (this.negated) {
										naturalLanguageName = heroName + " isn't kinda romantically interested in at least " + numTimes + " people."; break;
									}
									else {
										naturalLanguageName = heroName + " is kinda romantically interested in at least " + numTimes + " people."; break;
									}
									
								}
								else if (isHigh) {
									if (this.negated) {
										naturalLanguageName = heroName + " is not head over heels in love with at least " + numTimes + " people."; break;
									}
									else {
										naturalLanguageName = heroName + " is head over heels gaga for at least" + numTimes + " people."; break;
									}
									
								}
								else {
									naturalLanguageName = "problem with numTimesUniqelyTrue network predicate to Natural Language";
									break;
								}
							case "cool":
								if (isLow) {
									if (this.negated) {
										naturalLanguageName = heroName + " does not think that at least " + numTimes + " people are pretty darn lame."; break;
									}
									else {
										naturalLanguageName = heroName + " thinks at least " + numTimes + " people are pretty darn lame."; break;
									}
									
								}
								else if (isMed) {
									if (this.negated) {
										naturalLanguageName = heroName + " does not think that at least " + numTimes + " people are actually kinda cool."; break;
									}
									else {
										naturalLanguageName = heroName + " thinks at least " + numTimes + " people are actually kinda cool."; break;
									}
									
								}
								else if (isHigh) {
									if (this.negated) {
										naturalLanguageName = heroName + " does not think that at least " + numTimes + " people are wicked cool."; break;
									}
									else {
										naturalLanguageName = heroName + " thinks at least " + numTimes + " people are wicked cool."; break;
									}
									
								}
								else {
									naturalLanguageName = "problem with numTimesUniqelyTrue network predicate to Natural Language";
									break;
								}
							}
						}
						else if (numTimesRoleSlot.toLowerCase() == "second") { // these are referring to there being someone who is the recipient of many opinions!
							switch(SocialNetwork.getNameFromType(this.networkType)) {
							case "buddy":
								if (isLow) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people think that " + heroName + " is a lousy buddy."; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people consider " + heroName + " to be a lousy buddy."; break;
									}
									
								}
								else if (isMed) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people think of " + heroName + " as an OK buddy."; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people are OK buddies with " + heroName; break;
									}
									
								}
								else if (isHigh) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people are great buddies with " + heroName; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people are great buddies with " + heroName; break;
									}
								}
								else {
									naturalLanguageName = "problem with numTimesUniqelyTrue network predicate to Natural Language";
									break;
								}
							case "romance":
								if (isLow) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people are disgusted by " + heroName + ", romantically speaking."; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people are completely turned off by " + heroName; break;
									}
									
								}
								else if (isMed) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people are kinda romantically interested in " + heroName; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people are kinda romantically interested in " + heroName; break;
									}
									
								}
								else if (isHigh) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people are head over heels in love with " + heroName; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people are head over heels gaga for " + heroName; break;
									}
									
								}
								else {
									naturalLanguageName = "problem with numTimesUniqelyTrue network predicate to Natural Language";
									break;
								}
							case "cool":
								if (isLow) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people think that " + heroName + " is totally lame."; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people find " + heroName + " to be totally lame."; break;
									}
									
								}
								else if (isMed) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people think " + heroName + " is cool"; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people think " + heroName + " is actually kinda cool"; break;
									}
									
								}
								else if (isHigh) {
									if (this.negated) {
										naturalLanguageName = "fewer than " + numTimes + " people think that " + heroName + " is wicked cool."; break;
									}
									else {
										naturalLanguageName = "at least " + numTimes + " people think that " + heroName + " is wicked cool."; break;
									}
									
								}
								else {
									naturalLanguageName = "problem with numTimesUniqelyTrue network predicate to Natural Language";
									break;
								}
							}
						}
					break;
				/*case "relationship": // I don't think we need to worry about the 'both' for this situation. This one is easy because we don't need to worry about directionality.
					switch(RelationshipNetwork.getRelationshipNameByNumber(this.relationship)) {
						case 'friends':
							naturalLanguageName = heroName + " is" + notString + " friends with at least " + numTimes + " people";
							break;
						case 'dating':
							naturalLanguageName = heroName + " is" + notString + " dating at least " + numTimes + " people";
							break;
						case 'enemies':
							naturalLanguageName = heroName + " is " + notString + " enemies with at least" + numTimes + " people";
							break;
						default:
							naturalLanguageName = "unrecognized relationship (not friends, dating, or enemies)";
					}
					break;*/
				case "trait":
					// Pretty sure trait's can't be num times uniquely true thingermajiggers.
					Debug.debug(this, "trait's can't be num times uniquely true!");
					break;
				case "status": // we need to think about these guys a little bit too, because direction matters.
				//First of all, we only care about directed statuses.
				//Second of all, we either care about I have a crush on 10 people.
				//OR we care about 10 people have a crush on me.
				//Again, I don't think both comes into play here, which is kind of nice.
					var theStatus:int = this.status;
			
					var cif:CiFSingleton = CiFSingleton.getInstance();
					
					if (theStatus <= Status.LAST_CATEGORY_COUNT)
					{
						//resolve which trait they actually have
						for each (var s:int in Status.CATEGORIES[this.status])
						{
							if (cif.cast.getCharByName(heroName.toLowerCase()).getStatus(s))
							{
								theStatus = s;
							}
						}
					}
					
					naturalLanguageName = heroName
					
					if(numTimesRoleSlot.toLowerCase() == "first"){ // we care about this person having a crush on lots of other people
						switch(theStatus) {
							case Status.ANGRY_AT:
								if (this.negated) naturalLanguageName += " is angry at fewer than " + numTimes + " people";
								else naturalLanguageName += " is angry with at least " + secondary + " people"; 
								break;
							case Status.PITIES:
								if (this.negated) naturalLanguageName += " pitties fewer than " + numTimes + " people";
								else naturalLanguageName += " pitties at least " + numTimes + " people"; 
								break;
							case Status.ENVIES:
								if (this.negated) naturalLanguageName += " envies fewer than " + numTimes + " people";
								else naturalLanguageName += " envies at least " + numTimes + " people"; 
								break;
							case Status.GRATEFUL_TOWARD:
								if (this.negated) naturalLanguageName += " is grateful towards fewer than " + numTimes + " people";
								else naturalLanguageName += " is grateful towards at least " + numTimes + " people"; 
								break;
							default:
								naturalLanguageName += " not a known/directed status id = " + theStatus;
						}
					}
					else if (numTimesRoleSlot.toLowerCase() == "second") { // we care about other people having this opinion towards the responder.
						naturalLanguageName = ""; // we don't want to start with the person's name for these.
						switch(theStatus) {
							case Status.ANGRY_AT:
								if (this.negated) naturalLanguageName = "Fewer than " + numTimes + " people are angry at " + heroName;
								else naturalLanguageName = "At least " + numTimes + " people are angry at " +  heroName; 
								break;
							case Status.PITIES:
								if (this.negated) naturalLanguageName = "Fewer than " + numTimes + " people pitty " + heroName;
								else naturalLanguageName = "At least " + numTimes + " people pitty " +  heroName; 
								break;
							case Status.ENVIES:
								if (this.negated) naturalLanguageName = "Fewer than " + numTimes + " people envy " + heroName;
								else naturalLanguageName = "At least " + numTimes + " people envy " +  heroName; 
								break;
							case Status.GRATEFUL_TOWARD:
								if (this.negated) naturalLanguageName = "Fewer than " + numTimes + " people are grateful toward " + heroName;
								else naturalLanguageName = "At least " + numTimes + " people are grateful toward " +  heroName; 
								break;
							default:
								naturalLanguageName += " not a known/directed status id = " + theStatus;
						}
					}
					break;
				case "CKB": // OK, these require a little bit of thought too.
					//I think we definitely need to use the magic of variables here to shorten the amount of work.
					//And, also of important note, is that I believe this is the first time that 'both' is actually an important player.
					//But, fortunately, I don't think there is any distinction between the first and the second.
					//So, we could be interested in something that the primary person has an opinion on (e.g. primary has five things they like)
					//or the secondary person (e.g. secondary has five cool things they like)
					//or it could be explicitly both (there are five things that primary likes and secondary dislikes)
					
					//APPARANTLY I HANDLED THIS ALREADY FOR CKB IN THE NORMAL CKB PREDICATE THING!
					//SO I DON'T NEED TO WORRY ABOUT IT HERE!
					
					break;
				case "SFDBLabel":
					//OK, the last one!  Sweet!
					//this is the dooozy... because all three cases have to be treated seperately.
					//If first is selected -- we are interested in the initiator doing a lot of nice thngs.
					//if second is selected -- we are interested in nicet hings happening to second.
					//if both are selected -- we are interested in first doing nice things to second.
					//lets get started!
					if (this.window == 6)
					{
						Debug.debug(this, "BREAK!");
					}
					
					var sfdbLabelType:String = SocialFactsDB.getLabelByNumber(label);
					var timeElapsed:String = "";
					if (SocialFactsDB.CAT_POSITIVE == label) {
						sfdbLabelType = "generally positive";
					}
					else if (SocialFactsDB.CAT_NEGATIVE == label){
						sfdbLabelType = "generally negative";
					}
					
					/*
					if (this.window < 0) { // THIS IS BACKSTORY
						timeElapsed = " way back when";
					}
					else if (this.window >= 0 && this.window <= 5) {
						timeElapsed = " recently";
					}
					else if (this.window > 5 && this.window <= 10) {
						timeElapsed = " not too long ago";
					}
					else if (this.window > 10) {
						timeElapsed = " a while ago";
					}
					*/
					
					notString = "at least ";
					if (negated) {
						notString = "fewer than ";
					}
					
					//Debug.debug(this, "label: " + label + " sfdbLabelType: " + sfdbLabelType);
					if (numTimesRoleSlot.toLowerCase() == "first") { // these are things that the initiator did -- we don't care to who!
						naturalLanguageName = heroName + " did " + notString + numTimes + " " + sfdbLabelType + " things";// + timeElapsed;
					}
					else if (numTimesRoleSlot.toLowerCase() == "second") { // these are things that happened to the responder -- we don't care who did them!
						naturalLanguageName = notString + numTimes + " " + sfdbLabelType + " things happened to " + heroName;// + timeElapsed;
					}
					else if (numTimesRoleSlot.toLowerCase() == "both") { // these are things that happened to the responder -- we don't care who did them!
						naturalLanguageName = primary + " did " + notString + numTimes + " " + sfdbLabelType + " things to " + secondary;// + timeElapsed;
					}
					else {
						naturalLanguageName = "poorly specified role slot when dealing with sfdb labels to natural language name";
					}
					break;
				default:
					trace ("Unrecognized predicate type");
				
			}
			return naturalLanguageName;
		}
		
		
		/**
		 * This function is the easiest of the easiest.
		 * It looks at the value of the sfdbOrder value
		 * and simply returns an english string that describes it. At least
		 * at first.  We may change it to be smarter later on, but it is good enough for now.
		 * @return
		 */
		public function sfdbOrderToNaturalLanguage():String {
			switch(sfdbOrder) {
				case 1: return "first";
				case 2: return "second";
				case 3: return "third";
				case 4: return "fourth";
				case 5: return "fifth";
				case 6: return "sixth";
				case 7: return "seventh";
				case 8: return "eighth";
				case 9: return "ninth";
				case 10: return "tenth";
				default: return "after a lot of other delicate stuff fell into place, too!";
			}
		}
		
		//Given a string (firUpp), it makes the first letter of that string upper case.
		//Perfect for fixing people's names!
		public function makeFirstLetterUpperCase(firUpp:String):String{
			return firUpp.charAt(0).toUpperCase() + firUpp.substring(1,firUpp.length);
		}
		
		public function intentEquals(pred:Predicate):Boolean {
			if (this.intentType != pred.intentType)
				return false;
			if (this.networkType != pred.networkType)
				return false;
			if (this.comparator != pred.comparator)
				return false;
			if (this.negated != pred.negated)
				return false;
			if (this.status != pred.status)
				return false;
			return true;
		}
		
		public function intentSimilar(pred:Predicate):Boolean {
			switch(this.intentType)
			{
				case INTENT_NETWORK_UP:
					if ((pred.intentType == INTENT_NETWORK_UP) && (this.networkType == pred.networkType))
						return true;
					if (pred.intentType == INTENT_ADD_STATUS)
					{
						if ((this.networkType == SocialNetwork.ROMANCE) && pred.status == Status.IS_DATING)
							return true;
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_FRIENDS_WITH)
							return true;
					}
					else if (pred.intentType == INTENT_REMOVE_STATUS)
					{
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((this.networkType == SocialNetwork.FAMILYBOND) && pred.status == Status.ESTRANGED_FROM)
							return true;
					}
					return false;
				break;
				case INTENT_NETWORK_DOWN:
					if ((pred.intentType == INTENT_NETWORK_DOWN) && (this.networkType == pred.networkType))
						return true;
					if (pred.intentType == INTENT_ADD_STATUS)
					{
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((this.networkType == SocialNetwork.FAMILYBOND) && pred.status == Status.ESTRANGED_FROM)
							return true;
					}
					else if (pred.intentType == INTENT_REMOVE_STATUS)
					{
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_FRIENDS_WITH)
							return true;
						if ((this.networkType == SocialNetwork.ROMANCE) && pred.status == Status.IS_DATING)
							return true;
					}
					return false;
				break;
				case INTENT_ADD_STATUS:
					if ((pred.intentType == INTENT_ADD_STATUS) && (this.status == pred.status))
						return true;
					else if (pred.intentType == INTENT_NETWORK_UP)
					{
						if ((pred.networkType == SocialNetwork.ROMANCE) && this.status == Status.IS_DATING)
							return true;
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_FRIENDS_WITH)
							return true;
					}
					else if (pred.intentType == INTENT_NETWORK_DOWN)
					{
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((pred.networkType == SocialNetwork.FAMILYBOND) && this.status == Status.ESTRANGED_FROM)
							return true;
					}
					return false;
				break;
				case INTENT_REMOVE_STATUS:
					if ((pred.intentType == INTENT_REMOVE_STATUS) && (this.status == pred.status))
						return true;
					else if (pred.intentType == INTENT_NETWORK_UP)
					{
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((pred.networkType == SocialNetwork.FAMILYBOND) && this.status == Status.ESTRANGED_FROM)
							return true;						
					}
					else if (pred.intentType == INTENT_NETWORK_DOWN)
					{
						if ((pred.networkType == SocialNetwork.ROMANCE) && this.status == Status.IS_DATING)
							return true;
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_FRIENDS_WITH)
							return true;						
					}
					return false;
				break;
				default:
					return false;
				break;
			}
			return false;
		}
		
		public function intentsOppositeSimilar(pred:Predicate):Boolean {
			switch(this.intentType)
			{
				case INTENT_NETWORK_UP:
					if ((pred.intentType == INTENT_NETWORK_DOWN) && (this.networkType == pred.networkType))
						return true;
					if (pred.intentType == INTENT_REMOVE_STATUS)
					{
						if ((this.networkType == SocialNetwork.ROMANCE) && pred.status == Status.IS_DATING)
							return true;
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_FRIENDS_WITH)
							return true;
					}
					else if (pred.intentType == INTENT_ADD_STATUS)
					{
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((this.networkType == SocialNetwork.FAMILYBOND) && pred.status == Status.ESTRANGED_FROM)
							return true;
					}
					return false;
				break;
				case INTENT_NETWORK_DOWN:
					if ((pred.intentType == INTENT_NETWORK_UP) && (this.networkType == pred.networkType))
						return true;
					if (pred.intentType == INTENT_REMOVE_STATUS)
					{
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((this.networkType == SocialNetwork.FAMILYBOND) && pred.status == Status.ESTRANGED_FROM)
							return true;
					}
					else if (pred.intentType == INTENT_ADD_STATUS)
					{
						if ((this.networkType == SocialNetwork.BUDDY) && pred.status == Status.IS_FRIENDS_WITH)
							return true;
						if ((this.networkType == SocialNetwork.ROMANCE) && pred.status == Status.IS_DATING)
							return true;
					}
					return false;
				break;
				case INTENT_ADD_STATUS:
					if ((pred.intentType == INTENT_REMOVE_STATUS) && (this.status == pred.status))
						return true;
					else if (pred.intentType == INTENT_NETWORK_DOWN)
					{
						if ((pred.networkType == SocialNetwork.ROMANCE) && this.status == Status.IS_DATING)
							return true;
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_FRIENDS_WITH)
							return true;
					}
					else if (pred.intentType == INTENT_NETWORK_UP)
					{
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((pred.networkType == SocialNetwork.FAMILYBOND) && this.status == Status.ESTRANGED_FROM)
							return true;
					}
					return false;
				break;
				case INTENT_REMOVE_STATUS:
					if ((pred.intentType == INTENT_REMOVE_STATUS) && (this.status == pred.status))
						return true;
					else if (pred.intentType == INTENT_NETWORK_UP)
					{
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_ENEMIES_WITH)
							return true;
						if ((pred.networkType == SocialNetwork.FAMILYBOND) && this.status == Status.ESTRANGED_FROM)
							return true;						
					}
					else if (pred.intentType == INTENT_NETWORK_DOWN)
					{
						if ((pred.networkType == SocialNetwork.ROMANCE) && this.status == Status.IS_DATING)
							return true;
						if ((pred.networkType == SocialNetwork.BUDDY) && this.status == Status.IS_FRIENDS_WITH)
							return true;						
					}
					return false;
				break;
				default:
					return false;
				break;
			}
			return false;
			
		}
		
		public function intentsOpposite(pred:Predicate):Boolean {
			var goodThisStatus:Boolean = Status.isStatusPositive(this.status);
			var goodPredStatus:Boolean = Status.isStatusPositive(pred.status);
			
			switch(this.intentType)
			{
				case INTENT_ADD_STATUS:
					if ((pred.intentType == INTENT_REMOVE_STATUS) && (goodThisStatus == goodPredStatus))
						return true;
					if ((pred.intentType == INTENT_ADD_STATUS) && (goodPredStatus != goodThisStatus))
						return true;
					return false;
					break;
				case INTENT_REMOVE_STATUS:
					if ((pred.intentType == INTENT_ADD_STATUS) && (goodThisStatus == goodPredStatus))
						return true;
					if ((pred.intentType == INTENT_REMOVE_STATUS) && (goodPredStatus != goodThisStatus))
						return true;
					return false;
					break;
				case INTENT_NETWORK_UP:
					if ((pred.intentType == INTENT_NETWORK_DOWN) && (this.networkType == pred.networkType))
						return true;
					return false;
					break;
				case INTENT_NETWORK_DOWN:
					if ((pred.intentType == INTENT_NETWORK_UP) && (this.networkType == pred.networkType))
						return true;
					return false;
					break;
				default:
					trace ("uh oh, intent not found!\n");
					return false;
					break;
				
			}
			return false;
		}
	}	
}