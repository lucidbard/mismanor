package events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		
		public var userId:int;
		public static var LOGGED_IN:String = "logged_in";
		public function LoginEvent(type:String, userID:int=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			userId = userID;
		}
	}
}