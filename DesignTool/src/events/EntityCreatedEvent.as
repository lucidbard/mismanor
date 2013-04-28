package events
{
	import flash.events.Event;
	
	public class EntityCreatedEvent extends Event
	{
		public static var RULE:String="rule_created";
		public static var EFFECT:String="effect_created";
		public static var INSTANTIATION:String="instantiation_initialized";
		public static var LINEOFDIALOGUE_CREATED:String="lineofdialogue_created";
		public static var EFFECTS_FINISHED:String="effects_finished";
		public var original:Object;
		public var entityParent:Object;
		public static var PREDICATE:String="predicate";
		public static var EFFECTS:String="effects_created";
		public static var RULES:String="rules_created";
		public static var INSTANTIATIONS:String="instantiations";
		public var specificType:int
		public static var INSTANTIATION_FINISHED:String="instantiation_created";
		public static var INSTANTIATION_INIT:String="instantiation_initialized";
		public static var SOCIAL_GAME:String="social_game";
		
		public function EntityCreatedEvent(type:String, orig:*, p:*= null, sType:int=0,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			original=orig;
			entityParent=p;
			specificType=sType;
		}
	}
}