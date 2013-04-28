package events
{
	import flash.events.Event;
	
	public class EntityLoadedEvent extends Event
	{
		public static var RULES:String="rules";
		public var specificType:int;
		public static var EFFECTS:String="effects";
		public static var LINEOFDIALOGUE:String="lineofdialogue";
		public static var INSTANTIATION:String="instantiation";
		public static var PREDICATES:String="predicates";
		public static var SOCIAL_MOVE:String="social_move";

		public function EntityLoadedEvent(type:String, sType:int=-1, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			specificType=sType;
		}
	}
}