package grailgm 
{
	import CiF.Effect;
	import CiF.Instantiation;
	import CiF.Rule;
	/**
	 * ...
	 * @author Anne Sullivan
	 * 
	 * Used for keeping track of states used with quests. This includes both initial states and completion states
	 */
	public class QuestState 
	{
		public var name:String;
		public var id:Number;
		public var state:Rule;
		public var scenes:Vector.<GrailScene>;
		
		public function QuestState() 
		{
			name = new String();
			id = -1;
			state = new Rule;
			
			scenes = new Vector.<GrailScene>();
		}
		
		public function clean(): void {
			name = null;
			if (state)
				state.clean();
			state = null;
			
			if (scenes)
			{
				for each (var scene:GrailScene in scenes)
				{
					scene.clean();
					scene = null;
				}
				scenes = null;
			}
		}
		
		public function toXMLString():String
		{
			// TODO: Write out the XML for this!
			var returnstr:String = new String();
			
			return returnstr;
		}
	}

}