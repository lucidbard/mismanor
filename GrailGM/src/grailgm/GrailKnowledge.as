package grailgm 
{
	import CiF.Knowledge;
	import CiF.Trait;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GrailKnowledge 
	{
		public var cifKnowledge:Knowledge = new Knowledge();
		public var id:Number = -1;
		
		public function GrailKnowledge() 
		{
			super();
			// Do it automatically
			cifKnowledge.traits.push(Trait.KNOWLEDGE);			
		}
		
		public function clean(): void {
			if (cifKnowledge)
				cifKnowledge.clean();
			cifKnowledge = null;
		}
	}

}