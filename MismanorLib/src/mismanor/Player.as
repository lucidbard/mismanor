package mismanor 
{
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class Player extends GameCharacter
	{
		public var displayName:String = new String();
		
		public function setDisplayName(newName:String): void
		{
			displayName = newName;
		}
		
		public function Player() 
		{
			super();
		}
	}

}