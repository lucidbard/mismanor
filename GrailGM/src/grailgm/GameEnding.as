package grailgm 
{
	import CiF.Predicate;
	import CiF.Rule;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GameEnding 
	{
		public var state:Rule = new Rule;
		public var endingText:String = new String;
		public var id:Number=0;
		
		public function GameEnding() 
		{
			
		}
		
		public function clean(): void {
			if (state)
				state.clean();
			state = null;
			
			endingText = null;
		}
	}

}