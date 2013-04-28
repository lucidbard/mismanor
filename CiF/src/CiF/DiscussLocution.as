package CiF 
{
	import CiF.GameObject;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class DiscussLocution implements Locution 
	{
		public var type:String; // neutral, like, love, hate
		
		public function DiscussLocution() 
		{
			
		}
		
		public function clean(): void {
			type = null;
		}
		
		/* INTERFACE CiF.Locution */
		
		public function renderText(initiator:GameObject, responder:GameObject, other:GameObject):String 
		{
			switch (type.toLowerCase())
			{
				case "neutral":
					return (other.discussNeutral);
				case "like":
					return (other.discussLike);
				case "love":
					return (other.discussLove);
				case "hate":
					return (other.discussHate);
			}			
			return "";
		}
		
		public function getType():String 
		{
			return "DiscussLocution";
		}
		
	}

}
