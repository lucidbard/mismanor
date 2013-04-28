package events
{
	import flash.events.Event;
	
	public class EntityUpdatedEvent extends Event
	{
		public static var EFFECT:String="effect";
		public function EntityUpdatedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}