package CiF 
{
	/**
	 * The Microtheory class stores a domain dependent set of rules that govern
	 * CiF. These rules get included when scoring intent formation and the
	 * responder's accept/reject score when the definition of the microtheory
	 * is met in the current intent formation or game playing context. This 
	 * allows for the domain rules (of important social properties like
	 * relationships and network transformations) to be kept in one place and
	 * not be repeated in each social game.
	 * 
	 * Also included in Microtheory are the interrupt games that are associated 
	 * with the domain of the Microtheory. These interrupt social games look
	 * much like other normal social games with two distinctions. The first is
	 * that they have a special type of predicate whose evaluation is based on
	 * the name of the current social game played (currentGame(True Love's Kiss))
	 * so we can easily cull the set of games that can be interrupted or not in 
	 * the interrupt social game's preconditions. The second change is that 
	 * the initiator and responder influence rule sets are are not used (as of
	 * conception; might change) and will generally be empty and ignored.
	 * 
	 */
	public class Microtheory
	{
		/**
		 * The English name of the microtheory.
		 */
		public var name:String;
		/**
		 * 
		 * The rule-based definition of the microtheory's domain.
		 */
		public var definition:Rule;
		/**
		 * The domain dependent initiator influence rule set.
		 */
		public var initiatorIRS:InfluenceRuleSet;
		/**
		 * The domain dependent responder influence rule set.
		 */
		public var responderIRS:InfluenceRuleSet;
		/**
		 * References to the domain dependent interrupts.
		 */
		public var interrupts:Vector.<SocialGame>;
		/**
		 * Score of last evaluation of this microtheory.
		 */
		public var lastScore:Number;
		/**
		 * True if the last score is valid, false if not.
		 */
		public var lastScoreValid:Boolean;
		/**
		 * True if the last time the MT was evaluated, the precondition was true.
		 */
		public var lastPreconditionValid:Boolean;
		
		public function Microtheory() {
			this.name = "Not named.";
			this.definition = new Rule();
			this.initiatorIRS = new InfluenceRuleSet();
			this.responderIRS = new InfluenceRuleSet();
			this.interrupts = new Vector.<SocialGame>();
			this.lastScore = 0.0;
			this.lastScoreValid = false;
			this.lastPreconditionValid = false;
		}
		
		public function clean(): void {
			this.name = null;
			if (this.definition)
				this.definition.clean();
			this.definition = null;
			
			if (this.initiatorIRS)
				this.initiatorIRS.clean();
			this.initiatorIRS = null;
			
			if (this.responderIRS)
				this.responderIRS.clean();
			this.responderIRS = null;
			
			if (this.interrupts)
			{
				for each (var sg:SocialGame in this.interrupts)
				{
					sg.clean();
					sg = null;
				}
				this.interrupts = null;
			}
		}
		
		/**
		 * This function will score an influence rule set for all others that fit the definition or no others 
		 * if the definition doesn't require it.
		 * 
		 * @param	type either "initiator" or "responder"
		 * @param	initiator
		 * @param	responder
		 * @param	activeOtherCast
		 * @return The total weight of the influence rules
		 */
		public function scoreMicrotheoryByType(initiator:GameObject, responder:GameObject,sg:SocialGame=null,activeOtherCast:Vector.<GameObject> = null):Number
		{
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = new Vector.<GameObject>();
				for each (var c:Character in CiFSingleton.getInstance().cast.characters) {
					possibleOthers.push(c as GameObject);
				}
				for each (var i:Item in CiFSingleton.getInstance().itemList.items) {
					possibleOthers.push(i as GameObject);
				}
				for each (var k:Knowledge in CiFSingleton.getInstance().knowledgeList.knowledges) {
					possibleOthers.push(k as GameObject);
				}
			}
			
			var influenceRuleSet:InfluenceRuleSet = this.initiatorIRS;//(type == "initiator")?this.initiatorIRS:this.responderIRS;
			
			var x:GameObject;
			var y:GameObject;
			
			x = initiator;//(type == "initiator")?initiator:responder;
			y = responder;//(type == "initiator")?responder:initiator;
			
			var totalScore:Number = 0.0;

			if (x.name.toLowerCase() == "zack" && y.name.toLowerCase() == "monica" && this.name == "Dealing with someone who used to be cheating on you" && CiFSingleton.getInstance().time > 3)
			{
				Debug.debug(this, "STOP!");
			}
			
			var start:int;
			var end:int;
			if (this.definition.requiresThirdCharacter())
			{
				//if the definition is about an other, if it is true for even one other, run the MT's
				for each (var otherChar:GameObject in possibleOthers)
				{	
					if (otherChar.name != x.name &&
						otherChar.name != y.name) 
					{

						if (this.definition.evaluate(x, y, otherChar, sg))
						{
							// do not reverse roles here, because whichever IRS we are using, the roles are how they ought to be
							// role reversal for MTs happens at parsing xml time.
							totalScore += influenceRuleSet.scoreRules(x, y, otherChar, sg, possibleOthers, this.name);
						}
					}
				}
			}
			else
			{
				if (this.definition.evaluate(x, y, null, sg))
				{
					//if the definition doesn't involve an other, we score the rules with a variable other
					totalScore += influenceRuleSet.scoreRulesWithVariableOther(x, y, null, sg, possibleOthers, this.name);
				}		
			}
			//if (x.prospectiveMemory.intentScoreCache[y.networkID][sg.intents[0].predicates[0].getIntentType()] == ProspectiveMemory.DEFAULT_INTENT_SCORE)
			return totalScore;
		}
		
		/**************************************************************************
		 * Utility Functions
		 *************************************************************************/
		
		public function toXML():XML {
			/* <Microtheories>
			 *   <Microtheory>
			 *     <Name>Brag</Name>
			 *     <Domain>
			 *       <Rule>
			 *         //standard rule predicate list
			 *       </Rule>
			 *     </Domain>
			 *     <InitiatorInfluenceRuleSet>
			 * 			//standard IRS
			 *     </InitiatorInfluenceRuleSet>
			 *     <ResponderInfluenceRuleSet>
			 * 			//standard IRS
			 *     </ResponderInfluenceRuleSet>
			 *   </Microtheory>
			 * </Microtheories>
			 */
			
			//Debug.debug(this, "toXML() this.initiatorIRS: " + this.initiatorIRS.toXMLString());
			 
			//<ResponderInfluenceRuleSet>{this.responderIRS.toXML()}</ResponderInfluenceRuleSet>
			var outXML:XML = <Microtheory>
								<Name>{this.name}</Name>
								<Definition>{this.definition.toXML()}</Definition>
								<InitiatorInfluenceRuleSet>{this.initiatorIRS.toXML()}</InitiatorInfluenceRuleSet>
								<ResponderInfluenceRuleSet></ResponderInfluenceRuleSet>
							</Microtheory>;
			return outXML;
		}
		
		public function toJSON():String {
			var outObject:Object = new Object();
			outObject.name = this.name;
			outObject.definition = new Object();
			outObject.definition.micreotheory = true;
			outObject.definition.type = 0;
			outObject.definition.name = this.definition.name;
			outObject.definition.description = this.definition.description;
			outObject.definition.predicates = new Array();
			for(var i:int = 0; i < this.definition.length; i++) {
				(outObject.definition.predicates as Array).push((this.definition).predicates[i].toObject());
			}
			outObject.initiatorIRS = new Array();
			for(var j:int = 0; j < this.initiatorIRS.influenceRules.length; j++) {
				var newRule:Object = {name:this.initiatorIRS.influenceRules[j].name,micreotheory: true,type:0,name:this.initiatorIRS.influenceRules[j].name,description:this.initiatorIRS.influenceRules[j].description,predicates:new Array()};
				for(var k:int  = 0; k < this.initiatorIRS.influenceRules[j].predicates.length; k++) {
					(newRule.predicates as Array).push((this.initiatorIRS.influenceRules[j].predicates[k] as Predicate).toObject());
				}
			}
			outObject.initiatorIRS.push(newRule);
			return JSON.stringify(outObject);
		}
		
		public function toXMLString():String {
			return this.toXML().toXMLString();
		}

		public function clone():Microtheory 	{
				var newMicrotheory:Microtheory = new Microtheory();
				
				newMicrotheory.name = this.name;
				
				newMicrotheory.definition = this.definition.clone();
				
				newMicrotheory.initiatorIRS = this.initiatorIRS.clone();
				newMicrotheory.responderIRS = this.responderIRS.clone();
				newMicrotheory.interrupts = this.interrupts.slice(0, this.interrupts.length - 1);
				
				return newMicrotheory;
		}
	}
}
		
