package mismanor.event
{
	import flash.events.Event;
	
	import mismanor.CharacterSheet;
	
	public class CharacterSheetEvent extends Event
	{
		public static var CREATE_SHEET:String = "createSheet";
		public var sheet:CharacterSheet;
		public function CharacterSheetEvent(type:String, cSheet:CharacterSheet, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			sheet = cSheet;
		}
	}
}