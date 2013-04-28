package CiF 
{
	/**
	 * ...
	 */
	public class CharacterReferenceLocution implements Locution
	{
		
		public var type:String; // I == Initiator, R == Responder, IP == Initiator Possessive, RP == Responder Possessive.
		
		public function CharacterReferenceLocution() 
		{
			
		}
		
		public function clean(): void {
			type = null;
		}
		/**********************************************************************
		 * Locution Interface implementation
		 *********************************************************************/
		 
		/**
		 * Creates the dialogue to be presented to the player.
		 * 
		 * @param	initiator	The initator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 * @return	The dialogue to present to the player.
		 */
		public function renderText(initiator:GameObject, responder:GameObject, other:GameObject):String {
			
			var tempString:String = "";

			if (type == "I") {
				tempString = initiator.name;
			}
			if (type == "IP") {
				tempString = initiator.name;
				tempString += "'s";
			}
			if (type == "R") {
				tempString = responder.name;
			}
			if (type == "RP") {
				tempString = responder.name;
				tempString += "'s";
			}
			if (type == "O")
			{
				tempString = other.name;
			}
			if (type == "OP")
			{
				tempString = other.name;
				tempString += "'s";
			}
			return tempString;

		}
		
		public function toString():String {
			return this.type;
		}
		
		public function getType():String {
			return "CharacterReferenceLocution";
		}
	}

}