package mismanor.event
{
	import flash.events.Event;
	
	public class DialogueEvent extends Event
	{
		public static var CONTINUE:String = "continue";
		public static var CANCEL:String = "cancel";
		public function DialogueEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}