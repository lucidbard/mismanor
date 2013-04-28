package events
{
	import flash.events.Event;
	
	public class SaveEntityEvent extends Event
	{
		public var entName:String;
		public static var SOCIAL_MOVE:String = "social_move";
		public function SaveEntityEvent(type:String, eName:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			entName=eName;
		}
	}
}