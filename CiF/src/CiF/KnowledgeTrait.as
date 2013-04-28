package CiF 
{
	/**
	 * ...
	 * @author ...
	 */
	public class KnowledgeTrait 
	{
		
			public static const OPENABLE: 		Number = 0;
			public static const USABLE:			Number = 1;
			public static const MAGICAL:		Number = 2;
			public static const POWERFUL:		Number = 3;
			public static const IMPORTANT:		Number = 4;
			public static const SENTIMENTAL:	Number = 5;
		
			public static const TRAIT_COUNT:	Number = 6;
		
				
			/**
			 * Given the Number representation of a Label, this function
			 * returns the String representation of that type. This is intended to
			 * be used in UI elements of the design tool.
			 * 
			 * @example <listing version="3.0">
			 * KnowledgeTrait.getNameByNumber(KnowledgeTrait.OPENABLE); //returns "openable"
			 * </listing>
			 * 
			 * @param	type The Label type as a Number.
			 * @return The String representation of the Label type.
			 */
			public static function getNameByNumber(type:Number):String {
				switch (type) {
					case KnowledgeTrait.OPENABLE:
						return "openable";
					case KnowledgeTrait.USABLE:
						return "usable";
					case KnowledgeTrait.MAGICAL:					
						return "magical";
					case KnowledgeTrait.POWERFUL:
						return "powerful";
					case KnowledgeTrait.IMPORTANT:
						return "important";
					case KnowledgeTrait.SENTIMENTAL:
						return "sentimental";
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
			 * KnowledgeTrait.getNumberByName("usable"); //returns KnowledgeTrait.USABLE
			 * </listing>
			 * 
			 * @param	type The Label type as a String.
			 * @return The Number representation of the Label type.
			 */
			public static function getNumberByName(name:String):Number {
				switch (name.toLowerCase()) {
					case "openable":
						return KnowledgeTrait.OPENABLE;
					case "usable":
						return KnowledgeTrait.USABLE;		
					case "magical":
						return KnowledgeTrait.MAGICAL;		
					case "powerful":
						return KnowledgeTrait.POWERFUL;		
					case "important":
						return KnowledgeTrait.IMPORTANT;
					case "sentimental":
						return KnowledgeTrait.SENTIMENTAL;
					default:
						return -1;
				}
			}
		
		
		
			public function KnowledgeTrait() 
			{
				
			}
		
		
			public function clone(): KnowledgeTrait {
				var it:KnowledgeTrait = new KnowledgeTrait();
				return it;
			}
		
			public static function equals(x:KnowledgeTrait, y:KnowledgeTrait): Boolean {
				return true;
			}
		
		}
		
}
