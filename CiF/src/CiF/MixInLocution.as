package CiF 
{
	/**
	 * ...
	 * @author Mike Treanor
	 */
	public class MixInLocution implements Locution
	{
		public var content:String;
		
		public var mixInType:String;
		
		public function MixInLocution() 
		{
			content = "";
		}
		
		public function clean(): void {
			content = null;
			mixInType = null;
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
			
			var character:Character;
			if (initiator && initiator.type == GameObject.TYPE_CHARACTER)
			{
				character = initiator as Character;
			}
			else if (responder && responder.type == GameObject.TYPE_CHARACTER)
			{
				character = responder as Character;
			}
			else if (other && other.type == GameObject.TYPE_CHARACTER)
			{
				character = other as Character;
			}
			
			//Debug.debug(this,"characterName: "+character.characterName);
			
			var mixIn:String
			
			if (character != null) {
				mixIn = character.locutions[mixInType.toLowerCase()];
			
				//Debug.debug(this, "renderText: mixInType: " + mixInType + " characterLocution: " + character.locutions[mixInType] + " character: " + character.characterName);
				
				if (mixIn == null)
				{
					mixIn = Character.defaultLocutions[mixInType.toLowerCase()];
				}
			}
				
			if (mixIn != null){
				return mixIn;
			} else {
				return "";
			}
		}
		
		public function toString():String {
			return "";
		}
		
		public function getType():String {
			return "MixInLocution";
		}
	}

}