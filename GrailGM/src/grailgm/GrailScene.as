package grailgm 
{
	import CiF.Instantiation;
	import CiF.Rule;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GrailScene 
	{
		public var dialogue:Instantiation;
		public var socialChange:Rule;
		public var pairedStateID:Number; 		// this is currently only used to match ending quest state instantiations to a particular starting state
		
		public function GrailScene() 
		{
			dialogue = new Instantiation();
			socialChange = new Rule();
			pairedStateID = -1;
		}
		
		public function clean(): void {
			if (dialogue)
				dialogue.clean();
			dialogue = null;
			
			if (socialChange)
				socialChange.clean();
			socialChange = null;
		}
		
	}

}