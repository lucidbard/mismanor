package CiF 
{
	/**
	 * ...
	 */
	public class LiteralLocution implements Locution
	{
		public var content:String;
		public function LiteralLocution() 
		{
			content = "";
		}
		
		public function clean(): void {
			content = null;
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
			
			return content;
		}
		
		public function toString():String {
			return "";
		}
		
		public function getType():String {
			return "LiteralLocution";
		}
	}

}