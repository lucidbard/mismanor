package grailgm 
{
	/**
	 * Defines the constants associated with quest types
	 * 
	 * @author Anne Sullivan
	 */
	public class QuestType 
	{
		public static const UNKNOWN_TYPE:Number = -1;
		
		public static const ITEM_QUEST:Number = 0;
		public static const ITEM_GAIN_QUEST:Number = 1;
		public static const ITEM_GIVE_QUEST:Number = 2;
		
		public static const COMBAT_QUEST:Number = 3;
		public static const KILL_QUEST:Number = 4;
		public static const DEFEND_QUEST:Number = 5;
		
		public static const RELATIONSHIP_QUEST:Number = 6;
		public static const RELATIONSHIP_UP_QUEST:Number = 7;
		public static const RELATIONSHIP_DOWN_QUEST:Number = 8;
		
		public static const STATUS_QUEST:Number = 9;
		public static const STATUS_GAIN_QUEST:Number = 10;
		public static const STATUS_LOSE_QUEST:Number = 11;
		
		public static const STAT_QUEST:Number = 12;
		public static const STAT_UP_QUEST:Number = 13;
		public static const STAT_DOWN_QUEST:Number = 14;
		
		public static const QUEST_COUNT:Number = 15;
		
		
		public function QuestType() 
		{
			
		}
		
		/**
		 * Given the Number representation of a Quest, this function
		 * returns the String representation of that type. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * QuestType.getNameByNumber(QuestType.STATUS_QUEST); //returns "status quest"
		 * </listing>
		 * 
		 * @param	type The quest type as a Number.
		 * @return The String representation of the quest type.
		 */
		public static function getNameByNumber(type:Number):String {
			switch (type) {
				case QuestType.ITEM_QUEST:
					return "item quest";
				case QuestType.ITEM_GAIN_QUEST:
					return "gain item quest";
				case QuestType.ITEM_GIVE_QUEST:
					return "give item quest";
				
				case QuestType.COMBAT_QUEST:
					return "combat quest";
				case QuestType.KILL_QUEST:
					return "kill quest";
				case QuestType.DEFEND_QUEST:
					return "defend quest";
					
				case QuestType.RELATIONSHIP_QUEST:
					return "relationship quest";
				case QuestType.RELATIONSHIP_UP_QUEST:
					return "improve relationship quest";
				case QuestType.RELATIONSHIP_DOWN_QUEST:
					return "decrease relationship quest";
					
				case QuestType.STATUS_QUEST:
					return "status quest";
				case QuestType.STATUS_GAIN_QUEST:
					return "gain status quest";
				case QuestType.STATUS_LOSE_QUEST:
					return "lose status quest";
					
				case QuestType.STAT_QUEST:
					return "stat quest";
				case QuestType.STAT_UP_QUEST:
					return "incrase stat quest";
				case QuestType.STAT_DOWN_QUEST:
					return "decrease stat quest";
					
				default:
					return "quest type not found";				
			}
		}
		
		/**
		 * Given the String representation of a QuestType, this function
		 * returns the Number representation of that quest type. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * QuestType.getNumberByName("status quest"); //returns QuestType.STATUS_QUEST
		 * </listing>
		 * 
		 * @param	type The quest type as a String.
		 * @return The Number representation of the quest type.
		 */
		public static function getNumberByName(name:String):Number {
			switch (name.toLowerCase()) {
				case "item quest":
					return QuestType.ITEM_QUEST;
				case "gain item quest":
					return QuestType.ITEM_GAIN_QUEST;
				case "give item quest":
					return QuestType.ITEM_GIVE_QUEST;
				
				case "combat quest":
					return QuestType.COMBAT_QUEST;
				case "kill quest":
					return QuestType.KILL_QUEST;
				case "defend quest":
					return QuestType.DEFEND_QUEST;
					
				case "relationship quest":
					return QuestType.RELATIONSHIP_QUEST;
				case "improve relationship quest":
					return QuestType.RELATIONSHIP_UP_QUEST;
				case "decrease relationship quest":
					return QuestType.RELATIONSHIP_DOWN_QUEST;
					
				case "status quest":
					return QuestType.STATUS_QUEST;
				case "gain status quest":
					return QuestType.STATUS_GAIN_QUEST;
				case "lose status quest":
					return QuestType.STATUS_LOSE_QUEST;
					
				case "stat quest":
					return QuestType.STAT_QUEST;
				case "incrase stat quest":
					return QuestType.STAT_UP_QUEST;
				case "decrease stat quest":
					return QuestType.STAT_DOWN_QUEST;
					
				default:
					return -1;
			}
		}


		
	}

}