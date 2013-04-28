package CiF 
{
	/**
	 * Defines the constants associated with trait types.
	 *
	 */
	public class Trait
	{
		//positive traits
		public static const KIND:Number = 0;
		public static const SYMPATHETIC:Number = 1;
		public static const HUMBLE:Number = 2;
		public static const FORGIVING:Number = 3;
		public static const CHARMING:Number = 4;
		public static const CHARISMATIC:Number = 5;
		public static const TACTFUL:Number = 6;
		public static const LOYAL:Number = 7;
		public static const HONEST:Number = 8;
		public static const INDEPENDENT:Number = 9;
		public static const OBSERVANT:Number = 10;
		public static const CONFIDENT:Number = 11;
		public static const PERSUASIVE:Number = 12;
		public static const OUTGOING:Number = 13;

		public static const LAST_POS_TRAIT:Number = 13;
		
		//negative traits
		public static const SHY:Number = 14;
		public static const IMPULSIVE:Number = 15;
		public static const DISAPPROVING:Number = 16;
		public static const IRRITABLE:Number = 17;
		public static const DOMINEERING:Number = 18;
		public static const ARROGANT:Number = 19;
		public static const JEALOUS:Number = 20;
		public static const OBLIVIOUS:Number = 21;
		public static const VENGEFUL:Number = 22;
		public static const UNFORGIVING:Number = 23;
		public static const NAGGING:Number = 24;
		public static const SNIDE:Number = 25;
		public static const INDECISIVE:Number = 26;
		public static const STUBBORN:Number = 27;
		public static const DISHONEST:Number = 28;
		public static const GABBY:Number = 29;
		public static const HOSTILE:Number = 30;
		public static const PROMISCUOUS:Number = 31;
		public static const LAST_NEG_TRAIT:Number = 31;
		
		//neutral traits
		public static const MALE:Number = 32;
		public static const FEMALE:Number = 33;
		public static const YOUNG:Number = 34;
		public static const OLD:Number = 35;
		
		public static const FIRST_ITEM_TRAIT:Number = 36;
		
		// item traits
		public static const ITEM:Number = 36;
		public static const EXAMINABLE:Number = 37;
		public static const HOLDABLE:Number = 38;
		public static const HIDEABLE:Number = 39;
		public static const USABLE:Number = 40;
		
		public static const TRAIT_COUNT_ITEM:Number = 5;
		
		// knowledge traits
		public static const KNOWLEDGE:Number = 41;
		public static const BACKSTORY:Number = 42;
		public static const PERSONAL:Number = 43;
		public static const FACTUAL:Number = 44;
		public static const EMOTIONAL:Number = 45;
		public static const INFLAMMATORY:Number = 46;
		public static const SECRET:Number = 47;
		public static const ENDEARING:Number = 48;
		public static const EMBARRASSING:Number = 49;
		public static const ROMANTIC:Number = 50;
		public static const ENDGAME:Number = 51;
		
		public static const FIRST_LINE_TRAIT:Number = 52;
		public static const JAMES_LINE:Number = 52;
		public static const COLONEL_LINE:Number = 53;
		public static const VIOLET_LINE:Number = 54;
		public static const BARONESS_LINE:Number = 55;
		public static const THOMAS_LINE:Number = 56;
		public static const LIZ_LINE:Number = 57;
		public static const CULT_LINE:Number = 58;
		public static const LAST_LINE_TRAIT:Number = 58;
		
		public static const PLOTPOINT:Number = 59;
		
		public static const TRAIT_COUNT_KNOWLEDGE:Number = 19;
		public static const TRAIT_COUNT:Number = 59;
		
		public function cloneTraits(): Trait {
			var t:Trait = new Trait();
			return t;
		}
		
		/**
		 * Given the Number representation of a Label, this function
		 * returns the String representation of that type. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * Trait.getNameByNumber(Trait.CONFIDENCE); //returns "confidence"
		 * </listing>
		 * 
		 * @param	type The Label type as a Number.
		 * @return The String representation of the Label type.
		 */
		public static function getNameByNumber(type:Number):String {
			switch (type) {
				case Trait.KIND:
					return "kind";
				case Trait.SYMPATHETIC:
					return "sympathetic";
				case Trait.HUMBLE:
					return "humble";
				case Trait.FORGIVING:
					return "forgiving";
				case Trait.CHARMING:
					return "charming";
				case Trait.CHARISMATIC:
					return "charismatic";
				case Trait.TACTFUL:
					return "tactful";
				case Trait.LOYAL:
					return "loyal";
				case Trait.HONEST:
					return "honest";
				case Trait.INDEPENDENT:
					return "independent";
				case Trait.OBSERVANT:
					return "observant";
				case Trait.CONFIDENT:
					return "confident";
				case Trait.PERSUASIVE:
					return "persuasive";
				case Trait.OUTGOING:
					return "outgoing";
				case Trait.SHY:
					return "shy";
				case Trait.IMPULSIVE:
					return "impulsive";
				case Trait.DISAPPROVING:
					return "disapproving";
				case Trait.IRRITABLE:
					return "irritable";
				case Trait.DOMINEERING:
					return "domineering";
				case Trait.ARROGANT:
					return "arrogant";
				case Trait.JEALOUS:
					return "jealous";
				case Trait.OBLIVIOUS:
					return "oblivious";
				case Trait.VENGEFUL:
					return "vengeful";
				case Trait.UNFORGIVING:
					return "unforgiving";
				case Trait.NAGGING:
					return "nagging";
				case Trait.SNIDE:
					return "snide";
				case Trait.INDECISIVE:
					return "indecisive";
				case Trait.STUBBORN:
					return "stubborn";
				case Trait.DISHONEST:
					return "dishonest";
				case Trait.GABBY:
					return "gabby";
				case Trait.HOSTILE:
					return "hostile";
				case Trait.PROMISCUOUS:
					return "promiscuous";
					
				case Trait.MALE:
					return "male";
				case Trait.FEMALE:
					return "female";
				case Trait.YOUNG:
					return "young";
				case Trait.OLD:
					return "old";
				case Trait.ITEM:
					return "item";
				case Trait.EXAMINABLE:
					return "examinable";
				case Trait.HOLDABLE:
					return "holdable";
				case Trait.HIDEABLE:
					return "hideable";
				case Trait.USABLE:
					return "usable";
					
				case Trait.KNOWLEDGE:
					return "knowledge";
				case Trait.BACKSTORY:
					return "backstory";
				case Trait.PERSONAL:
					return "personal";
				case Trait.FACTUAL:
					return "factual";
				case Trait.EMOTIONAL:
					return "emotional";
				case Trait.INFLAMMATORY:
					return "inflammatory";
				case Trait.SECRET:
					return "secret";
				case Trait.ENDEARING:
					return "endearing";
				case Trait.EMBARRASSING:
					return "embarrassing";
				case Trait.ROMANTIC:
					return "romantic";
				case Trait.ENDGAME:
					return "endgame";
				case Trait.JAMES_LINE:
					return "james's line";
				case Trait.COLONEL_LINE:
					return "colonel's line";
				case Trait.VIOLET_LINE:
					return "violet's line";
				case Trait.BARONESS_LINE:
					return "baroness's line";
				case Trait.THOMAS_LINE:
					return "thomas's line";
				case Trait.LIZ_LINE:
					return "liz's line";
				case Trait.CULT_LINE:
					return "cult line";
				case Trait.PLOTPOINT:
					return "plotpoint";
					
				default:
					return "trait not declared";				
			}
		}
		
		/**
		 * Given the String representation of a Label, this function
		 * returns the Number representation of that type. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * Trait.getNumberByName("cool"); //returns Trait.COOL
		 * </listing>
		 * 
		 * @param	type The Label type as a String.
		 * @return The Number representation of the Label type.
		 */
		public static function getNumberByName(name:String):Number {
			switch (name.toLowerCase()) {
				case "kind":
					return Trait.KIND;
				case "sympathetic":
					return Trait.SYMPATHETIC;
				case "humble":
					return Trait.HUMBLE;
				case "forgiving":
					return Trait.FORGIVING;
				case "charming":
					return Trait.CHARMING;
				case "charismatic":
					return Trait.CHARISMATIC;
				case "tactful":
					return Trait.TACTFUL;
				case "loyal":
					return Trait.LOYAL;
				case "honest":
					return Trait.HONEST;
				case "independent":
					return Trait.INDEPENDENT;
				case "observant":
					return Trait.OBSERVANT;
				case "confident":
					return Trait.CONFIDENT;
				case "persuasive":
					return Trait.PERSUASIVE;
				case "outgoing":
					return Trait.OUTGOING;
				case "shy":
					return Trait.SHY;
				case "impulsive":
					return Trait.IMPULSIVE;
				case "disapproving":
					return Trait.DISAPPROVING;
				case "irritable":
					return Trait.IRRITABLE;
				case "domineering":
					return Trait.DOMINEERING;
				case "arrogant":
					return Trait.ARROGANT;
				case "jealous":
					return Trait.JEALOUS;
				case "oblivious":
					return Trait.OBLIVIOUS;
				case "vengeful":
					return Trait.VENGEFUL;
				case "unforgiving":
					return Trait.UNFORGIVING;
				case "nagging":
					return Trait.NAGGING;
				case "snide":
					return Trait.SNIDE;
				case "indecisive":
					return Trait.INDECISIVE;
				case "stubborn":
					return Trait.STUBBORN;
				case "dishonest":
					return Trait.DISHONEST;
				case "gabby":
					return Trait.GABBY;
				case "hostile":
					return Trait.HOSTILE;
				case "promiscuous":
					return Trait.PROMISCUOUS;
					
				case "male":
					return Trait.MALE;
				case "female":
					return Trait.FEMALE;
				case "young":
					return  Trait.YOUNG;
				case "old":
					return Trait.OLD;
					
				case "item":
					return Trait.ITEM;
				case "examinable":
					return Trait.EXAMINABLE;
				case "holdable":
					return Trait.HOLDABLE;
				case "hideable":
					return Trait.HIDEABLE;
				case "usable":
					return Trait.USABLE;
					
				case "knowledge":
					return Trait.KNOWLEDGE;
				case "backstory":
					return Trait.BACKSTORY;
				case "personal":
					return Trait.PERSONAL;
				case "factual":
					return Trait.FACTUAL;
				case "emotional":
					return Trait.EMOTIONAL;
				case "inflammatory":
					return Trait.INFLAMMATORY;
				case "secret":
					return Trait.SECRET;
				case "endearing":
					return Trait.ENDEARING;
				case "embarrassing":
					return Trait.EMBARRASSING;
				case "romantic":
					return Trait.ROMANTIC;
				case "endgame":
					return Trait.ENDGAME;
				case "james's line":
					return Trait.JAMES_LINE;
				case "colonel's line":
					return Trait.COLONEL_LINE
				case "violet's line":
					return Trait.VIOLET_LINE;
				case "baroness's line":
					return Trait.BARONESS_LINE;
				case "thomas's line":
					return Trait.THOMAS_LINE;
				case "liz's line":
					return Trait.LIZ_LINE;

				case "cult line":
					return Trait.CULT_LINE;
				case "plotpoint":
					return Trait.PLOTPOINT;
					
				default:
					return -1;
			}
		}
		
		
		
		public function Trait() 
		{
			
		}
		
		
		public static function equals(x:Trait, y:Trait): Boolean {
			return true;
		}
		
	}

}
