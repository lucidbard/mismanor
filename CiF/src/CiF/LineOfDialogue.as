package CiF 
{
	/**
	 * 
	 * TODO: fill out header documentation
	 * TODO: make toString make sense
	 * TODO: SFDB locutions in createLocutionVectors().
	 */
	public class LineOfDialogue
	{
		/**
		 * The number in sequence this line of dialog is in it's instantition.
		 */
		public var lineNumber:Number = -1;
		/**
		 * The initiator's dialogue.
		 */
		public var initiatorLine:String = "";
		/**
		 * The responders's dialogue.
		 */
		public var responderLine:String = "";
		/**
		 * Other's dialogue.
		 */
		public var otherLine:String = "";
		/**
		 *  Though multiple people might talk at the same time, (e.g. initiator: "I love you" responder="gasp!" simultaneously)
		 *  it might be useful to keep track of the 'important' speaker at any given time stamp (in the example above, "I Love you"
		 *  is a more important line to the narrative of the exchange than the gasp, for example)
		 */
		public var primarySpeaker:String = "";
		/**
		 *  Initiator's body animation.
		 */
		public var initiatorBodyAnimation:String = "";
		/**
		 * Initiator's face animation.
		 */
		public var initiatorFaceAnimation:String = "";
		public var initiatorFaceState:String = "";
		/**
		 * Responders's body animation.
		 */
		public var responderBodyAnimation:String = "";
		/**
		 * Initiator's face animation.
		 */
		public var responderFaceAnimation:String = "";
		public var responderFaceState:String = "";
		/**
		 * Other's body animation.
		 */
		public var otherBodyAnimation:String = "";
		/**
		 * Other's face animation.
		 */
		public var otherFaceAnimation:String = "";
		public var otherFaceState:String = "";
		/**
		 * The performance time of the line of dialogue.
		 */
		public var time:Number = 0;
		/**
		 * A flag to mark whether the initiator's line of dialog is spoken aloud
		 * (isThought=false) or meant to be a thought bubble (isThought=true)
		 */
		public var initiatorIsThought:Boolean = false;
		/**
		 * A flag to mark whether the responder's line of dialog is spoken aloud
		 * (isThought=false) or meant to be a thought bubble (isThought=true)
		 */
		public var responderIsThought:Boolean = false;
		/**
		 * A flag to mark whether the other's line of dialog is spoken aloud
		 * (isThought=false) or meant to be a thought bubble (isThought=true)
		 */
		public var otherIsThought:Boolean = false;
		/**
		 * A flag to mark whether any CKB references in the initiator's line of
		 * dialogue should be referenced textually (isPicture=false) or
		 * pictorally (isPicture=true)
		 */
		public var initiatorIsPicture:Boolean = false;
		/**
		 * A flag to mark whether any CKB references in the responder's line of
		 * dialogue should be referenced textually (isPicture=false) or
		 * pictorally (isPicture=true)
		 */
		public var responderIsPicture:Boolean = false;
		/**
		 * A flag to mark whether any CKB references in the other's line of
		 * dialogue should be referenced textually (isPicture=false) or
		 * pictorally (isPicture=true)
		 */
		public var otherIsPicture:Boolean = false;
		
		
		public var initiatorIsDelayed:Boolean = false;
		public var responderIsDelayed:Boolean = false;
		public var otherIsDelayed:Boolean = false;
		
		
		
		/**
		 * A String to represent who the initiator is speaking to
		 * (Likely values should be 'responder' or 'other'
		 */
		public var initiatorAddressing:String = "";
		/**
		 * A String to represent who the responder is speaking to
		 * (Likely values should be 'initiator' or 'other'
		 */
		public var responderAddressing:String = "";
		/**
		 * A String to represent who the other is speaking to
		 * (Likely values should be 'initiator' or 'responder'
		 */
		public var otherAddressing:String = "";
		/**
		 * A flag marking whether this other utterance
		 * is indeed spoken by the other (otherIsChorus=false)
		 * or is instead spoken by a Greek Chorus of the rest
		 * of the student body (otherIsChorus=true)
		 */
		public var isOtherChorus:Boolean = false;
		
		
		/**
		 * Variables used for staging in Prom Week
		 */
		public var otherApproach:Boolean = false;
		public var otherExit:Boolean = false;
		
		
		
		
		/**
		 * Locution Vector for the initiator.
		 */
		
		public var initiatorLocutions:Vector.<Locution>;
		/**
		 * Locution Vector for the responder.
		 */
		public var responderLocutions:Vector.<Locution>;
		/**
		 * Locution Vector for other.
		 */
		public var otherLocutions:Vector.<Locution>;
		/**
		 * The rule that stores the Predicates that represent the partial state
		 * change associated with this line of dialog. These are not to be
		 * evaluated are are present for authoring and display purposes only.
		 */
		public var partialChange:Rule;
		
		public var chorusRule:Rule;
		
		public function LineOfDialogue() {
			this.partialChange = new Rule();
			this.chorusRule = new Rule();
			this.initiatorLocutions = new Vector.<Locution>();
			this.responderLocutions = new Vector.<Locution>();
			this.otherLocutions = new Vector.<Locution>();
		}
		
		public function clean(): void {
			if (this.partialChange)
				this.partialChange.clean();
			this.partialChange = null;
			if (this.chorusRule)
				this.chorusRule.clean();
			this.chorusRule = null;
			var loc:Locution;
			
			if (this.initiatorLocutions)
			{
				for each (loc in this.initiatorLocutions)
				{
					loc.clean();
					loc = null;
				}
				this.initiatorLocutions = null;
			}
			
			if (this.responderLocutions)
			{
				for each (loc in this.responderLocutions)
				{
					loc.clean();
					loc = null;
				}
					
				this.responderLocutions = null;
			}
			
			if (this.otherLocutions)
			{
				for each (loc in this.otherLocutions)
				{
					loc.clean();
					loc = null;
				}
					
				this.otherLocutions = null;
			}
		}
		// NOTE: createLocutionVectors seems to always be called from the Util class. Therefore, I've removed it from here because it was confusing
		// to have to change it in two places. If it needs to return, please copy it from the Util class. Or better yet, change the code to call it from
		// the Util class.
		
		/**
		 * Realizes the dialogue with reference to the players of the roles in
		 * the current social game.
		 * 
		 * @param	initiator	The initator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 * @return	The line of dialogue to present to the player in their 
		 * proper role locations.
		 */
		public function realizeDialogue(initiator:Character, responder:Character, other:Character = null):LineOfDialogue {
			var lod:LineOfDialogue = this.clone();
			var l:Locution;

			lod.initiatorLine = "";
			lod.responderLine = "";
			lod.otherLine= "";
			//Debug.debug(this, "realizeDialogue(): initiator locutions length: " + this.initiatorLocutions.length);
			for each (l in this.initiatorLocutions) {
				if (l.getType() == "MixInLocution")
				{
					lod.initiatorLine += l.renderText(initiator, null, null);
				}
				else
				{
					//Debug.debug(this, "realizeDialogue(): initiator locution: " + l);
					lod.initiatorLine += l.renderText(initiator, responder, other) + " ";
				}
			}
			for each (l in this.responderLocutions) {
				if (l.getType() == "MixInLocution")
				{
					lod.responderLine += l.renderText(null, responder, null);
				}
				else
				{
					lod.responderLine += l.renderText(initiator, responder, other) + " ";
				}
			}
			for each (l in this.otherLocutions) {
				if (l.getType() == "MixInLocution")
				{
					lod.otherLine += l.renderText(null, null, other);
				}
				else
				{
					lod.otherLine += l.renderText(initiator, responder, other) + " ";
				}
			}
			//trace(lod);
			return lod;
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		public function toString():String {
			var returnstr:String = new String();
			
			//only print out a single line at a time... and make it the line of the primary speaker.
			if (this.primarySpeaker == "initiator") {
				returnstr += (lineNumber + "\ninitiator:" + initiatorLine + "\n" + initiatorBodyAnimation + "\n" + initiatorFaceAnimation + "\n" + initiatorFaceState + "\n" + responderBodyAnimation + "\n" + responderFaceAnimation + "\n" + responderFaceState + "\n" + otherBodyAnimation + "\n" + otherFaceAnimation + "\n" + otherFaceState + "\n" + time + "\n" + initiatorIsThought + "\n" + initiatorIsDelayed + "\n" + initiatorIsPicture + "\n" + initiatorAddressing + "\n" + isOtherChorus);
			}
			else if (this.primarySpeaker == "responder") {
				returnstr += (lineNumber + "\nresponder:" + responderLine + "\n" + initiatorBodyAnimation + "\n" + initiatorFaceAnimation + "\n" + initiatorFaceState + "\n" + responderBodyAnimation + "\n" + responderFaceAnimation + "\n" + responderFaceState + "\n" + otherBodyAnimation + "\n" + otherFaceAnimation + "\n" + otherFaceState + "\n" + time + "\n" + responderIsThought + "\n" + responderIsDelayed + "\n" + responderIsPicture + "\n" + responderAddressing + "\n" + isOtherChorus);
			}
			else if (this.primarySpeaker == "other") {
				returnstr += (lineNumber + "\nother:" + otherLine + "\n" + initiatorBodyAnimation + "\n" + initiatorFaceAnimation + "\n" + initiatorFaceState + "\n" + responderBodyAnimation + "\n" + responderFaceAnimation + "\n" + responderFaceState + "\n" + otherBodyAnimation + "\n" + otherFaceAnimation + "\n" + otherFaceState + "\n" + time + "\n" + otherIsThought + "\n" + otherIsDelayed + "\n" + otherIsPicture+ "\n" + otherAddressing + "\n" + isOtherChorus + "\n" + otherApproach + "\n" + otherExit);
			}
			else {
				Debug.debug(this, "toString() -- not sure who is the primary speaker");
			}
			return returnstr;
		}
		
		public function toXMLString():String {
			var returnstr:String = new String();
			returnstr += "<LineOfDialogue lineNumber=\"" + this.lineNumber 
				+ "\" initiatorLine=\"" + this.initiatorLine 
				+ "\" responderLine=\"" + this.responderLine 
				+ "\" otherLine=\"" + this.otherLine
				+ "\" primarySpeaker=\"" + this.primarySpeaker
				+"\" initiatorBodyAnimation=\"" + this.initiatorBodyAnimation 
				+ "\" initiatorFaceAnimation=\"" + this.initiatorFaceAnimation 
				+ "\" initiatorFaceState=\"" + this.initiatorFaceState 
				+ "\" responderBodyAnimation=\"" + this.responderBodyAnimation 
				+ "\" responderFaceAnimation=\"" + this.responderFaceAnimation 
				+ "\" responderFaceState=\"" + this.responderFaceState 
				+ "\" otherBodyAnimation=\"" + this.otherBodyAnimation 
				+ "\" otherFaceAnimation=\"" + this.otherFaceAnimation 
				+ "\" otherFaceState=\"" + this.otherFaceState 
				+ "\" time=\"" + this.time 
				+ "\" initiatorIsThought=\"" + this.initiatorIsThought
				+ "\" responderIsThought=\"" + this.responderIsThought
				+ "\" otherIsThought=\"" + this.otherIsThought
				+ "\" initiatorIsDelayed=\"" + this.initiatorIsDelayed
				+ "\" responderIsDelayed=\"" + this.responderIsDelayed
				+ "\" otherIsDelayed=\"" + this.otherIsDelayed
				+ "\" initiatorIsPicture=\"" + this.initiatorIsPicture
				+ "\" responderIsPicture=\"" + this.responderIsPicture
				+ "\" otherIsPicture=\"" + this.otherIsPicture
				+ "\" initiatorAddressing=\"" + this.initiatorAddressing
				+ "\" responderAddressing=\"" + this.responderAddressing
				+ "\" otherAddressing=\"" + this.otherAddressing
				+ "\" otherApproach=\"" + this.otherApproach
				+ "\" otherExit=\"" + this.otherExit
				+ "\" isOtherChorus=\"" + this.isOtherChorus
				+ "\" >\n";
			returnstr += "<PartialChange>\n" + this.partialChange.toXMLString() +"\n</PartialChange>\n";
			returnstr += "<ChorusRule>\n" + this.chorusRule.toXMLString() +"\n</ChorusRule>\n";
			returnstr += "</LineOfDialogue>";
			return returnstr;
		}
		
		
		public function clone(): LineOfDialogue {
			var l:LineOfDialogue = new LineOfDialogue();
			l.lineNumber = this.lineNumber;
			l.initiatorLine = this.initiatorLine;
			l.responderLine = this.responderLine;
			l.otherLine = this.otherLine;
			l.primarySpeaker = this.primarySpeaker;
			l.initiatorBodyAnimation = this.initiatorBodyAnimation;
			l.initiatorFaceAnimation = this.initiatorFaceAnimation;
			l.initiatorFaceState = this.initiatorFaceState;
			l.responderBodyAnimation = this.responderBodyAnimation;
			l.responderFaceAnimation = this.responderFaceAnimation;
			l.responderFaceState = this.responderFaceState;
			l.otherBodyAnimation = this.otherBodyAnimation;
			l.otherFaceAnimation = this.otherFaceAnimation;
			l.otherFaceState = this.otherFaceState;
			l.time = this.time;
			l.partialChange = this.partialChange.clone();
			l.initiatorIsThought = this.initiatorIsThought;
			l.responderIsThought = this.responderIsThought;
			l.otherIsThought = this.otherIsThought;
			l.initiatorIsDelayed = this.initiatorIsDelayed;
			l.responderIsDelayed = this.responderIsDelayed;
			l.otherIsDelayed = this.otherIsDelayed;
			l.initiatorIsPicture = this.initiatorIsPicture;
			l.responderIsPicture = this.responderIsPicture;
			l.otherIsPicture = this.otherIsPicture;
			l.initiatorAddressing = this.initiatorAddressing;
			l.responderAddressing = this.responderAddressing;
			l.otherAddressing = this.otherAddressing;
			l.isOtherChorus = this.isOtherChorus;
			l.otherApproach = this.otherApproach;
			l.otherExit= this.otherExit;
			
			
			l.initiatorLocutions = this.initiatorLocutions.concat();
			l.responderLocutions = this.responderLocutions.concat();
			l.otherLocutions = this.otherLocutions.concat();
			
			l.chorusRule = this.chorusRule.clone();
			
			return l;
		}
		
		public static function equals(x:LineOfDialogue, y:LineOfDialogue): Boolean {
			if (x.lineNumber != y.lineNumber) return false;
			if (x.initiatorLine != y.initiatorLine) return false;
			if (x.responderLine != y.responderLine) return false;
			if (x.otherLine != y.otherLine) return false;
			if (x.primarySpeaker != y.primarySpeaker) return false;
			if (x.initiatorBodyAnimation != y.initiatorBodyAnimation) return false;
			if (x.initiatorFaceAnimation != y.initiatorFaceAnimation) return false;
			if (x.initiatorFaceState != y.initiatorFaceState) return false;
			if (x.responderBodyAnimation != y.responderBodyAnimation) return false;
			if (x.responderFaceAnimation != y.responderFaceAnimation) return false;
			if (x.responderFaceState != y.responderFaceState) return false;
			if (x.otherBodyAnimation != y.otherBodyAnimation) return false;
			if (x.otherFaceAnimation != y.otherFaceAnimation) return false;
			if (x.otherFaceState != y.otherFaceState) return false;
			if (x.time != y.time) return false;
			if (x.initiatorIsThought != y.initiatorIsThought) return false;
			if (x.responderIsThought != y.responderIsThought) return false;
			if (x.otherIsThought != y.otherIsThought) return false;
			
			if (x.initiatorIsDelayed != y.initiatorIsDelayed) return false;
			if (x.responderIsDelayed != y.responderIsDelayed) return false;
			if (x.otherIsDelayed != y.otherIsDelayed) return false;
			
			if (x.initiatorIsPicture != y.initiatorIsPicture) return false;
			if (x.responderIsPicture != y.responderIsPicture) return false;
			if (x.otherIsPicture != y.otherIsPicture) return false;
			if (x.initiatorAddressing != y.initiatorAddressing) return false;
			if (x.responderAddressing != y.responderAddressing) return false;
			if (x.otherAddressing != y.otherAddressing) return false;
			if (x.isOtherChorus != y.isOtherChorus) return false;
			if (x.otherApproach!= y.otherApproach) return false;
			if (x.otherExit != y.otherExit) return false;
			if (!Rule.equals(x.chorusRule, y.chorusRule)) return false;
			return true;
		}
	}
}