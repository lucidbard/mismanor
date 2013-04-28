package grailgm 
{
	import CiF.GameObject;
	import CiF.Instantiation;
	import CiF.LineOfDialogue;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GrailInstantiation
	{
		public static const INSTANTIATION_NEUTRAL:Number = 0;
		public static const INSTANTIATION_LIKE:Number = 1;
		public static const INSTANTIATION_LOVE:Number = 2;
		public static const INSTANTIATION_HATE:Number = 3;
		public static const INSTANTIATION_TRANSITION:Number = 4; // transition-triggered instantiation
		
		public static const INSTANTIATION_TYPES:Number = 5;

		public var instantiationType:Number = 0;
		public var speaker:String = new String();
		public var cifInstantiation:Instantiation = new Instantiation();
		
		public function GrailInstantiation() 
		{
			super();
		}
		
		public function clean(): void {
			speaker = null;
			if (cifInstantiation)
				cifInstantiation.clean();
			cifInstantiation = null;
		}
		
		public static function getIDByName(name:String):Number
		{
			switch (name.toLowerCase())
			{
				case "neutral":
					return INSTANTIATION_NEUTRAL;
				case "like":
					return INSTANTIATION_LIKE;
				case "love":
					return INSTANTIATION_LOVE;
				case "hate":
					return INSTANTIATION_HATE;
				case "transition":
					return INSTANTIATION_TRANSITION;
				default:
					return -1;
			}
		}
		
		public static function getNameByID(id:Number):String
		{
			switch (id)
			{
				case INSTANTIATION_NEUTRAL:
					return "neutral";
				case INSTANTIATION_LIKE:
					return "like";
				case INSTANTIATION_LOVE:
					return "love";
				case INSTANTIATION_HATE:
					return "hate";
				case INSTANTIATION_TRANSITION:
					return "transition";
				default:
					return "instantiation type not found";
			}
		}
		
		public function clone():GrailInstantiation
		{
			var gi:GrailInstantiation = new GrailInstantiation();
			
			gi.cifInstantiation = this.cifInstantiation.clone();
			gi.speaker = this.speaker;
			gi.instantiationType = this.instantiationType;
			
			return gi;

		}
		
/*				<Instantiation type="hate" speaker="Violet" id="0" name="Violet hates the player">
         		 <LineOfDialogue lineNumber="0" initiatorLine="Violet is in a cult and is told in a hateful way" responderLine="What?" otherLine="" primarySpeaker="initiator" time="0" initiatorIsThought="false" responderIsThought="false" otherIsThought="false" initiatorIsDelayed="false" responderIsDelayed="false" otherIsDelayed="false" initiatorIsPicture="false" responderIsPicture="false" otherIsPicture="false" initiatorAddressing="responder" responderAddressing="initiator" otherAddressing="initiator" otherApproach="false" otherExit="false" isOtherChorus="false"/>
				</Instantiation>
				<Instantiation type="love" speaker="Violet" id="1" name="Violet loves the player">
         		 <LineOfDialogue lineNumber="0" initiatorLine="Violet is in a cult and is told in a loving way" responderLine="What?" otherLine="" primarySpeaker="initiator" time="0" initiatorIsThought="false" responderIsThought="false" otherIsThought="false" initiatorIsDelayed="false" responderIsDelayed="false" otherIsDelayed="false" initiatorIsPicture="false" responderIsPicture="false" otherIsPicture="false" initiatorAddressing="responder" responderAddressing="initiator" otherAddressing="initiator" otherApproach="false" otherExit="false" isOtherChorus="false"/>
				</Instantiation>
				<Instantiation type="neutral" speaker="Violet" id="2" name="Violet is neutral to the player">
         		 <LineOfDialogue lineNumber="0" initiatorLine="Violet is in a cult and is told in a neutral way" responderLine="What?" otherLine="" primarySpeaker="initiator" time="0" initiatorIsThought="false" responderIsThought="false" otherIsThought="false" initiatorIsDelayed="false" responderIsDelayed="false" otherIsDelayed="false" initiatorIsPicture="false" responderIsPicture="false" otherIsPicture="false" initiatorAddressing="responder" responderAddressing="initiator" otherAddressing="initiator" otherApproach="false" otherExit="false" isOtherChorus="false"/>
				</Instantiation>
				<Instantiation type="like" speaker="Violet" id="3" name="Violet likes the player">
         		 <LineOfDialogue lineNumber="0" initiatorLine="Violet is in a cult and is told in a likeable way" responderLine="What?" otherLine="" primarySpeaker="initiator" time="0" initiatorIsThought="false" responderIsThought="false" otherIsThought="false" initiatorIsDelayed="false" responderIsDelayed="false" otherIsDelayed="false" initiatorIsPicture="false" responderIsPicture="false" otherIsPicture="false" initiatorAddressing="responder" responderAddressing="initiator" otherAddressing="initiator" otherApproach="false" otherExit="false" isOtherChorus="false"/>
				</Instantiation>
			</Instantiations>
		</PlotPoint> */
		public function toXML():XML
		{
			var returnXML:XML;
			
			returnXML = <Instantiation type={GrailInstantiation.getNameByID(this.instantiationType)} speaker={this.speaker} id ={this.cifInstantiation.id} name={this.cifInstantiation.name}></Instantiation>;

			for (var i:Number = 0; i < this.cifInstantiation.lines.length; ++i) {
				returnXML.appendChild(new XML(this.cifInstantiation.lines[i].toXMLString()));
			}
			
			return returnXML;
			
		}
	}

}