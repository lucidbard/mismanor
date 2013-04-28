package CiF 
{
	import flashx.textLayout.utils.CharacterUtil;
	/**
	 * This class implements the pairing of a Rule class with a set of
	 * SocialChange classes. Multiple Effect classes are aggregated by
	 * the SocialGame class to process the outcome of social game play.
	 * 
	 * <p>This class knows the specificity of the rule (aka the number of
	 * preconditions in the Rule part of the Effect) so the SocialGame can
	 * pick the most salient effect of those who's Rule evaluates to true.</p>
	 * 
	 * <p>The class also stores the ID of it's associated social game 
	 * instantiation.</p>
	 * 
	 * @see CiF.SocialGame
	 * @see CiF.Rule
	 * @see CiF.SocialChange
	 * @see CiF.Predicate
	 * 
	 */
	public class Effect
	{
		public static const EFFECT_TOO_SOON_TIME:Number = 6;
		public static const LOW_NETWORK_SALIENCE:Number = 2;
		public static const MEDIUM_NETWORK_SALIENCE:Number = 2;
		public static const HIGH_NETWORK_SALIENCE:Number = 2;
		public static const UNRECOGNIZED_NETWORK_SALIENCE:Number = 2;
		
		/**
		 * The conditions for which this effect can be take.
		 */
		public var condition:Rule;
		/**
		 * The rule containing the social change associated with the effect.
		 */
		public var change:Rule;
		
		/**
		 * Stores what last cif.time the instantiation was seen last
		 */
		public var lastSeenTime:Number = -1;
		
		/**
		 * Salience Score is an approximate measure of how "awesome" we we think this effect oughta be
		 */
		public var salienceScore:Number;
		 
		/**
		 * Locutions that comprise this effect's performance realization string
		 */
		public var locutions:Vector.<Locution>;
		/**
		 * The unique identifier.
		 */
		public var id:Number;
		/**
		 * The unique identifier of this affect's reject
		 */
		public var rejectID:Number = -1;
		/**
		 * True if the Effect is in the accept branch of the social game and
		 * false if the Effect is in the reject branch.
		 */
		public var isAccept:Boolean;
		/**
		 * The english interpretation of the Effect's outcome to be used when
		 * this effect is referenced in later game play.
		 */		
		public var referenceAsNaturalLanguage:String;
		/**
		 * The ID of the instantiation this effect uses for performance
		 * realization.
		 */
		public var instantiationID:Number;
		
		public function Effect() {
				this.condition = new Rule();
				this.change = new Rule();
				this.id = -1;
				this.isAccept = true;
				this.instantiationID = -1;
				
				this.locutions = new Vector.<Locution>();
		}
		
		public function clean():void {
			if (this.condition)
				this.condition.clean();
			this.condition = null;
			if (this.change)
				this.change.clean();
			this.change = null;
			
			if (this.locutions)
			{
				for each (var loc:Locution in this.locutions)
				{
					loc.clean();
					loc = null;
				}
					
				this.locutions = null;
			}
			referenceAsNaturalLanguage = null;
		}
		
		/**
		 * Evaluations the condition of the Effect for truth given the current
		 * game state.
		 * 
		 * @param	initiator	The initiator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 * @return True if all the predicates in the condition are true. Otherwise,
		 * false.
		 */
		public function evaluateCondition(initiator:GameObject, responder:GameObject=null, other:GameObject=null):Boolean {
			return this.condition.evaluate(initiator, responder, other);
		}
		
		/**
		 * Updates the social state if given the predicates in this valuation
		 * rule.
		 * 
		 * @param	initiator	The initiator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 */
		public function valuation(initiator:GameObject, responder:GameObject=null, other:GameObject = null):void {
			this.change.valuation(initiator, responder, other);
		}

		/**
		 * Determines if the Effect instantiation requires a third character.
		 * @return True if a third character requires or false if one is not.
		 */
		public function requiresThirdCharacter():Boolean {
			return this.condition.requiresThirdCharacter() || this.change.requiresThirdCharacter();
		}
		
		/**
		 * Checks the Effect's condition rule for a CKB predicate (which
		 * constitutes a CKB item reference).
		 * 
		 * @return True if a CKB reference exists in the Effect's change rule,
		 * false if none exists.
		 */
		public function hasCKBReference():Boolean {
			for each (var p:Predicate in this.condition.predicates) {
				if (p.type == Predicate.CKBENTRY) {
					return true;
				}
			}
			return false;
		}
		 

		
		/**
		 * Returns the Predicate that holds the CKB reference for the Effect.
		 * @return A Predicate of type CKBENTRY or null if no CKBENTRY
		 * Predicate exists in the Effect's condition Rule.
		 */
		public function getCKBReferencePredicate():Predicate {
			for each (var p:Predicate in this.condition.predicates) {
				if (p.type == Predicate.CKBENTRY) {
					return p;
				}
			}
			return null;
		}
		
		
		
		/**
		 * Checks the Effect's condition rule for a SFDB LAbel
		 * 
		 * @return True if a SFDB label exists in the Effect's change rule,
		 * false if none exists.
		 */
		public function hasSFDBLabel():Boolean {
			for each (var p:Predicate in this.change.predicates) {
				if (p.type == Predicate.SFDBLABEL) {
					return true;
				}
			}
			return false;
		}
		 

		
		/**
		 * Returns the Predicate that holds the SFDB Label for the Effect.
		 * @return A Predicate of type SFDBLabel or null if no SFDBLabel
		 * Predicate exists in the Effect's condition Rule.
		 */
		public function getSFDBLabelPredicate():Predicate {
			for each (var p:Predicate in this.change.predicates) {
				if (p.type == Predicate.SFDBLABEL) {
					return p;
				}
			}
			return null;
		}
		
		public function renderTextNotForDialogue(currentInitiator:GameObject, currentResponder:GameObject, currentOther:GameObject):String
		{
			if (!currentOther)
			{
				currentOther = new GameObject();
			}
			
			var returnString:String = "";
			
			for each (var loc:Locution in this.locutions)
			{
				returnString += loc.renderText(currentInitiator, currentResponder, currentOther);
			}
			
			return returnString;
		}
		
		public function scoreSalience():void
		{
			var salience:Number = 0;
			var pred:Predicate;
			
			for each (pred in this.change.predicates)
			{
				if (pred.type == Predicate.SFDBLABEL)
				{
					salience += 6;
				}
			}
			
			for each (pred in this.condition.predicates)
			{
				switch (pred.type) 
				{
					/*case Predicate.RELATIONSHIP:
						if (pred.negated)
						{
							salience += 1
						}
						else
						{
							salience += 3
						}	
						break;*/
					case Predicate.NETWORK:
						if (pred.comparator == "lessthan" && pred.networkValue == 34) {
							//We are dealing with a 'low' network.
							salience += LOW_NETWORK_SALIENCE;
						}
						else if (pred.comparator == "greaterthan" && pred.networkValue == 66) {
							//we are dealing with a high network.
							salience += HIGH_NETWORK_SALIENCE;
						}
						else if (pred.comparator == "greaterthan" && pred.networkValue == 33) {
							//We are dealing with MEDIUM network (don't pay attention to the 'other half' of a network.
							salience += MEDIUM_NETWORK_SALIENCE;
						}
						else if (pred.comparator == "lessthan" && pred.networkValue == 67) {
							//Technically this is 'medium', but we are going to ignore it in here, because we already caught it in the previous if.
						}
						else {
							//There was an 'unrecognized network value!' here.  Lets give it some salience anyway.
							salience += UNRECOGNIZED_NETWORK_SALIENCE;
							Debug.debug(this, "scoreSalience() effect id: " + id + " linked to instantiation " + instantiationID + " had a 'non-standard' network value used.");
						}
						/*
						//a cruddy way to not get the second medium network value
						if (pred.comparator != "lessthan" && pred.networkValue != 67)
						{
							salience += 2
						}
						*/
						break;
					case Predicate.STATUS:
						if (pred.negated)
						{
							salience += 1
						}
						else
						{
							salience += 3
						}
						break;
					case Predicate.TRAIT:
						if (pred.negated)
						{
							salience += 1
						}
						else
						{
							salience += 4
						}						
						break;
					case Predicate.CKBENTRY:
						//TODO: current I don't take into consideration whether or not first or second subjective link
						if (pred.primary == "" || pred.secondary == "")
						{
							if (pred.truthLabel == "")
							{
								salience += 3
							}
							else
							{
								salience += 4
							}
						}
						else if (pred.truthLabel == "")
						{
							salience += 4
						}
						else
						{
							//this means all are speciufied
							salience += 5
						}
						break;
					case Predicate.SFDBLABEL:
						if (pred.primary == "" || pred.secondary == "")
						{
							if (pred.sfdbLabel < 0)
							{
								salience += 3
							}
							else
							{
								salience += 4
							}
						}
						else if (pred.sfdbLabel < 0)
						{
							salience += 4
						}
						else
						{
							//this means all are specified
							salience += 5
						}
						break;
					default:
						Debug.debug(this, "scoring salience for a predicate without an unrecoginzed type of: " + pred.type);
				}
				if (Status.getStatusNameByNumber(pred.status) == "cheating on")
				{
					salience += 3;
				}
				else if (RelationshipNetwork.getRelationshipNameByNumber(pred.relationship) == "enemies")
				{
					salience += 3;
				}
				else if (RelationshipNetwork.getRelationshipNameByNumber(pred.relationship) == "dating")
				{
					salience += 3;
				}
			}
			
			if (this.lastSeenTime >= 0)
			{
				//this means we've seen this effect before
				if ((CiFSingleton.getInstance().time - this.lastSeenTime) < Effect.EFFECT_TOO_SOON_TIME)
				{
					salience -= (Effect.EFFECT_TOO_SOON_TIME*2.5 - 2*(CiFSingleton.getInstance().time - this.lastSeenTime));
				}
			}
			
			this.salienceScore = salience;
		}
		
		public static function renderText(currentInitiator:GameObject, currentResponder:GameObject, currentOther:GameObject, sgContext:SocialGameContext, speaker:String, locs:Vector.<Locution> = null, otherPresent:Boolean = false):String
		{	
			if (!currentOther)
			{
				currentOther = new GameObject();
			}
			
			var realizedString:String = "";
			
			var charLocution:CharacterReferenceLocution;
			
			var referencedInitiator:GameObject = sgContext.getInitiator();
			var referencedResponder:GameObject = sgContext.getResponder();
			var referencedOther:GameObject = sgContext.getOther();
			
			
			var speakerName:String;
			if (speaker == "initiator" || speaker == "i")
			{
				speakerName = currentInitiator.name.toLowerCase();
			}
			else if (speaker == "responder" || speaker == "r")
			{
				speakerName = currentResponder.name.toLowerCase();
			}
			else if (speaker == "other" || speaker == "o")
			{
				speakerName = currentOther.name.toLowerCase();
			}
			else
			{
				Debug.debug(Effect,"No speaker info was passed in");
			}
			
			
			//if (sgContext.performanceRealizationString == "%i% decided to make %r% %pron(i,his/her)% project")
			//{
						//Debug.debug(Effect, "1");			
			//}
			
			var subjectName:String = "";
			//this means we need to loop through the locutions again to determine subject
			//by convention, all that aren't the subject are the object.
			for each (var loc:Locution in locs)
			{
				if (subjectName == "")
				{
					if (loc.getType() == "CharacterReferenceLocution")
					{
						if ((loc as CharacterReferenceLocution).type == "I" || (loc as CharacterReferenceLocution).type == "IP")
						{
							subjectName = referencedInitiator.name.toLowerCase();//"i"; //the referred to initiator
						}
						else if ((loc as CharacterReferenceLocution).type == "R" || (loc as CharacterReferenceLocution).type == "RP")
						{
							subjectName = referencedResponder.name.toLowerCase();
						}
						else if ((loc as CharacterReferenceLocution).type == "O" || (loc as CharacterReferenceLocution).type == "OP")
						{
							subjectName = referencedOther.name.toLowerCase();//"o";
						}
					}
				}
			//if (sgContext.performanceRealizationString == "%i% decided to make %r% %pron(i,his/her)% project")
			//{
						//Debug.debug(Effect, "2 subjectName: "+subjectName);			
			//}
			}
			
			
			var referredToName:String = "";
			
			//the we know who the speaker is, and who is the subject, we can render the text
			for each (var locution:Locution in locs)
			{
				//is the person being referred to present?
				
				//who is the person being referred to?
				
					if (locution.getType() == "CharacterReferenceLocution")
					{
						charLocution = locution as CharacterReferenceLocution;
						
						if (charLocution.type == "I" || charLocution.type == "IP")
						{
							referredToName = referencedInitiator.name.toLowerCase();
						}
						else if (charLocution.type == "R" || charLocution.type == "RP")
						{
							referredToName = referencedResponder.name.toLowerCase();
						}
						else if (charLocution.type == "O" || charLocution.type == "OP")
						{
							referredToName = referencedOther.name.toLowerCase();
						}
						
						
						
						
						if (Effect.isReferredToPresent(referredToName, currentInitiator, currentResponder, currentOther,otherPresent))
						{
							/*
							 * CharacterReferenceLocution:
							 * 		- can be speaker: I or my
							 * 		- can be !speaker, but there can be a speaker: 
							 */

							//at this stage we do know that SOMEONE who will be talking is being referenced

							
							//now we have to find out if the locution is the speaker or not
							if (referredToName == speakerName 
									&& charLocution.type.length == 1
									&& subjectName != speakerName)
							{
								realizedString += "me ";
							}
							else if (referredToName == speakerName && charLocution.type.length == 1)
							{
								realizedString += "I ";
							}
							else if (referredToName == speakerName 
									&& charLocution.type.length == 2
									&& subjectName == speakerName)
							{
								realizedString += "mine ";
							}
							else if (referredToName == speakerName && charLocution.type.length == 2)
							{
								realizedString += "my ";
							}
							else if (referredToName != speakerName && charLocution.type.length == 1)
							{
								realizedString += "you ";
								//Debug.debug(Effect, "CharRef: referredToName != speakerName");
								
							}
							else if (referredToName != speakerName && charLocution.type.length == 2)
							{
								realizedString += "your ";
							}
							else
							{
								realizedString += locution.renderText(referencedInitiator, referencedResponder, referencedOther);
							}
						}
						else
						{
							realizedString += locution.renderText(referencedInitiator, referencedResponder, referencedOther);	
						}
					}
				else
				{
					//just do the normal thing because no one involved in the thing referenced is talking
					realizedString += locution.renderText(referencedInitiator, referencedResponder, referencedOther);
				}
			}
			
			//if (sgContext.performanceRealizationString == "%i% decided to make %r% %pron(i,his/her)% project")
			//{
				//Debug.debug(Effect,"HERE WE ARE, WHAT'S THE SCOOP?");
			//}
			
			return realizedString;
		}
		
		public static function isReferredToPresent(referredToName:String, currentInitiator:GameObject, currentResponder:GameObject, currentOther:GameObject,otherPresent:Boolean = false):Boolean
		{
			if (currentInitiator.name.toLowerCase() == referredToName ||
				currentResponder.name.toLowerCase() == referredToName)
			{
				return true;
			}
			if (currentOther.name.toLowerCase() == referredToName && otherPresent)
			{
				return true;
			}
			return false;
		}
		
		public function isCharacterReferencedPresent(currentInitiator:GameObject, currentResponder:GameObject, currentOther:GameObject, sgContext:SocialGameContext, speaker:String):Boolean
		{
			var referencedInitiator:GameObject = sgContext.getInitiator();
			var referencedResponder:GameObject = sgContext.getResponder();
			var referencedOther:GameObject = sgContext.getOther();
			
			if (currentInitiator.name.toLowerCase() == referencedInitiator.name.toLowerCase() ||
				currentResponder.name.toLowerCase() == referencedResponder.name.toLowerCase() ||
				currentOther.name.toLowerCase() == referencedOther.name.toLowerCase())
			{
				return true;
			}
			
			return false;
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		public function toString():String {
			var result:String = (this.isAccept)?"Accept: ":"Reject: ";
			result += this.condition.toString();
			result += " | ";
			result += this.change.toString();
			return result;
		}
		
		public function toXMLString():String {
			var returnstr:String = new String();
			returnstr += "<Effect id=\"" + this.id + "\" accept=\"" + this.isAccept +  "\" instantiationID=\"" + this.instantiationID + "\" rejectID=\"" + this.rejectID + "\">\n";
			returnstr += "<PerformanceRealization>" + this.referenceAsNaturalLanguage + "</PerformanceRealization>\n";
			returnstr += "<ConditionRule>\n ";
			for (var i:Number = 0; i < this.condition.predicates.length; ++i) {
				//returnstr += "   ";
				returnstr += this.condition.predicates[i].toXMLString();
				returnstr += "\n";
			}
			returnstr += "</ConditionRule>\n<ChangeRule>\n";
			for (i = 0; i < this.change.predicates.length; ++i) {
				//returnstr += "   ";
				returnstr += this.change.predicates[i].toXMLString();
				returnstr += "\n";
			}
			returnstr += "</ChangeRule>\n</Effect>\n";
			return returnstr;
		}
		
		public function clone(): Effect {
			var e:Effect = new Effect();
			e.change = new Rule();
			e.condition = new Rule();
			for each(var p:Predicate in this.condition.predicates) {
				e.condition.predicates.push(p.clone());
			}
			for each(p in this.change.predicates) {
				e.change.predicates.push(p.clone());
			}
			e.id = this.id;
			e.isAccept = this.isAccept;
			e.rejectID = this.rejectID;
			e.referenceAsNaturalLanguage = this.referenceAsNaturalLanguage;
			e.instantiationID = this.instantiationID;
			return e;
		}
		
		public static function equals(x:Effect, y:Effect): Boolean {
			if (!Rule.equals(x.change, y.change)) return false;
			if (!Rule.equals(x.condition, y.condition)) return false;
			if (x.id != y.id) return false;
			if (x.isAccept != y.isAccept) return false;
			return true;
		}
	}
}