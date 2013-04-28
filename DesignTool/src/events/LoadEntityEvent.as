package events
{
	import flash.events.Event;
	
	public class LoadEntityEvent extends Event
	{
		public static var SOCIAL_MOVE:String = "social_game";
		public var id:int;
		public var name:String;
		public function LoadEntityEvent(type:String, idvar:int=0, nm:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			id=idvar;
			name=nm;
		}
	}
}