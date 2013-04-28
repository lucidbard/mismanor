package CiF 
{
	import CiF.GameObject;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class ExamineLocution implements Locution 
	{
		
		public function ExamineLocution() 
		{
			
		}
		
		public function clean(): void {
			
		}
		/* INTERFACE CiF.Locution */
		
		public function renderText(initiator:GameObject, responder:GameObject, other:GameObject):String 
		{
			// TODO: Is it ever something other than the responder who the player can examine?
			return responder.examineLine;
		}
		
		public function getType():String 
		{
			return "ExamineLocution";
		}	
	}
}
