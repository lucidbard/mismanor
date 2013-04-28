package CiF 
{
	import CiF.Character;
	/**
	 * ...
	 * @author Mike Treanor
	 */
	public class ToCLocution implements Locution
	{
		public var locutions:Vector.<Locution>;
		public var realizedString:String;
		
		public var tocID:int;
		public var rawString:String = "";
		
		public var speaker:String = "";
		
		public function ToCLocution() 
		{
			
		}		
		
		public function clean(): void {
			realizedString = null;
			rawString = null;
			speaker = null;
			
			if (locutions)
			{
				for each (var loc:Locution in locutions)
				{
					loc.clean();
					loc = null;
				}
				this.locutions = null;
			}
		}
		
		/* INTERFACE CiF.Locution */
		public function renderText(initiator:GameObject, responder:GameObject, other:GameObject):String
		{
			realizedString = "";
			
			//render toc strings
			var locution:Locution;

			for each (locution in this.locutions)
			{
				if (locution.getType() == "MixInLocution")
				{
					this.realizedString += locution.renderText(initiator, null, null) + " ";
				}
				else
				{
					if (locution.getType() == "SFDBLabelLocution")
					{
						(locution as SFDBLabelLocution).speaker = this.speaker;
					}
					//this.realizedString += locution.renderText(initiator, responder, other) + " "; //THIS MAKES PLURAL THINGS NOT WORK!
					this.realizedString += locution.renderText(initiator, responder, other);
				}
			}

			return this.realizedString;
		}
		
		public function toString():void
		{
			
		}
		
		public function getType():String
		{
			return "ToCLocution";
		}
	}
}