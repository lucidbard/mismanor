package CiF 
{
	import flashx.textLayout.utils.CharacterUtil;
	/**
	 * The SocialGame class stores social games in their declarative form; the
	 * social game preconditions, influence sets, and effects are stored. What
	 * is not stored is the decisions made by the player or AI system about what
	 * game choices are made. These decisions are stored in the FilledGame class.
	 * 
	 * <p>(deprecated)The defined constants denote the type of social change that 
	 * the social game has as its effect. </p>
	 * 
	 * @see CiF.FilledGame
	 * 
	 */
	public class SocialGame
	{
		// Social Game ID (For database)
		
		public var sgid:int;
		public var name:String = "";
		
		public var intents:Vector.<Rule>;
		public var preconditions:Vector.<Rule>;
		public var initiatorIRS:InfluenceRuleSet;
		public var responderIRS:InfluenceRuleSet;
		public var effects:Vector.<Effect>;
		public var instantiations:Vector.<Instantiation>;
		public var patsyRule:Rule;
		public var requiresOther:Boolean = false;
		
		public var thirdPartyTalkAboutSomeone:Boolean;
		public var thirdPartyGetSomeoneToDoSomethingForYou:Boolean;
		
		public var responderType:Number = 0;
		public var otherType:Number = 0;
		public var needsSecondOther:Boolean = false;
		
		public static const CHARACTER_TYPE:Number = 0;
		public static const ITEM_TYPE:Number = 1;
		public static const KNOWLEDGE_TYPE:Number = 2;

		public function SocialGame()
		{
			this.intents = new Vector.<Rule>();
			this.instantiations = new Vector.<Instantiation>();
			this.preconditions = new Vector.<Rule>();
			this.initiatorIRS = new CiF.InfluenceRuleSet();
			this.responderIRS = new CiF.InfluenceRuleSet();
			this.effects = new Vector.<Effect>();
			
			this.thirdPartyTalkAboutSomeone = false;
			this.thirdPartyGetSomeoneToDoSomethingForYou = false;
			this.patsyRule = new Rule();
		}
		
		public function clean(): void
		{
			name = null;
			
			var rule:Rule;
			var effect:Effect;
			var inst:Instantiation;

			if (this.intents)
			{
				for each (rule in this.intents)
				{
					rule.clean();
					rule = null;
				}
				this.intents = null;
			}
			if (this.instantiations)
			{
				for each (inst in instantiations)
				{
					inst.clean();
					inst = null;
				}
				this.instantiations = null;
			}
			
			if (this.preconditions)
			{
				for each (rule in this.preconditions)
				{
					rule.clean();
					rule = null;
				}
				this.preconditions = null;
			}
			
			if (this.initiatorIRS)
				this.initiatorIRS.clean();
			this.initiatorIRS = null;
			if (this.responderIRS)
				this.responderIRS.clean();
			this.responderIRS = null;

			if (this.effects)
			{
				for each (effect in this.effects)
				{
					effect.clean();
					effect = null;
				}
				this.effects = null;
			}
			
			if (this.patsyRule)
				this.patsyRule.clean();
			this.patsyRule = null;
		}
		/**
		 * Adds an effect to the effects list and gives it an ID.
		 * @param	effect	The effect to add to the social games's effects.
		 */
		public function addEffect(effect:Effect):void {
			var e:Effect = effect.clone();
			var idToUse:Number = 0;
			for each(var iterEffect:Effect in this.effects) {
				if (iterEffect.id > idToUse)
					idToUse = iterEffect.id + 1;
			}
			e.id = idToUse;
			this.effects.push(e);
		}
		
		/**
		 * Returns the effect who's id matches the id provided
		 * @param	effectID
		 * @return
		 */
		public function getEffectByID(effectID:int):Effect
		{
			for each (var e:Effect in this.effects)
			{
				if (e.id == effectID)
				{
					return e;
				}
			}
			Debug.debug(this, "getEffectByID() the id "+effectID+ " is not matched by any effects in the social game " + this.name);
			return new Effect();
		}
		
		/**
		 * Adds an instantation the the social game's instantions and gives
		 * it an ID. 
		 * @param	instantiation	The instantiation to add.
		 */
		public function addInstantiation(instantiation:Instantiation):void {
			var instant:Instantiation = instantiation.clone();
			var idToUse:Number = 0;
			for each(var iterInstant:Instantiation in this.instantiations) {
				if (iterInstant.id > idToUse)
					idToUse = iterInstant.id + 1;
			}
			instant.id = this.instantiations.length;
			this.instantiations.push(instant);
		}
		
		/**
		 * Returns the initiator's influence rule set score with respect to the
		 * character/role mapping given in the arguments.
		 * 
		 * @param	initiator	The initiator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 * @return
		 */
		//NOTE: this is old news...
		public function getInitiatorScore(initiator:GameObject, responder:GameObject, other:GameObject = null, sg:SocialGame = null, activeOtherCast:Vector.<GameObject> = null):Number {
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = this.getPossibleOthers(initiator, responder);
			}
			return this.initiatorIRS.scoreRules(initiator, responder, other, sg,possibleOthers);
		}
		
		/**
		 * This function returns true if the precondition is met in any way
		 * 
		 */
		public function passesAtLeastOnePrecondition(initiator:GameObject, responder:GameObject,activeOtherCast:Vector.<GameObject> = null):Boolean
		{
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = this.getPossibleOthers(initiator, responder);
			}
			
			if (this.preconditions.length > 0)
			{
				if (this.preconditions[0].requiresThirdCharacter())
				{
					//if the precondition involves an other check preconditions for static others
					for each (var otherChar:GameObject in possibleOthers)
					{
						if (otherChar.name != initiator.name &&
							otherChar.name != responder.name) 
						{
							if (this.preconditions[0].evaluate(initiator, responder, otherChar, this))
							{
								return true;
							}
						}
					}
				}
				else
				{
					
					// if there is a precondition, check precondition normally
					if (this.preconditions[0].evaluate(initiator, responder, null, this))
					{	
						return true;
					}
				}
			}
			else
			{
				//if there are no precondition, we pass the precondition
				return true;
			}
			
			// this means we shouldn't even both scoring this game
			return false;
		}
		
		/**
		 * This function will score an influence rule set for all others that fit the definition or no others 
		 * if the definition doesn't require it. This function assumes that there is one precondition rule.
		 * 
		 * @param	type either "initiator" or "responder"
		 * @param	initiator
		 * @param	responder
		 * @param	activeOtherCast
		 * @return The total weight of the influence rules
		 */
		public function scoreGame(initiator:GameObject, responder:GameObject,activeOtherCast:Vector.<GameObject> = null, isResponder:Boolean = false):Number
		{
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = this.getPossibleOthers(initiator, responder);
			}
			// (April) debugging
		//	trace("SocialGame.scoreGame: " + this.name);
			
			var influenceRuleSet:InfluenceRuleSet = (!isResponder)?this.initiatorIRS:this.responderIRS;
			
			var totalScore:Number = 0.0;
			
			if (this.preconditions.length > 0)
			{
				if (this.preconditions[0].requiresThirdCharacter())
				{
					var maxScore:Number = -999;
					
					//if the precondition involves an other run the IRS for all others with a static other
					for each (var otherChar:GameObject in possibleOthers)
					{
						var curScore:Number = 0;
						
						if (otherChar.name != initiator.name &&
							otherChar.name != responder.name) 
						{
							if (this.preconditions[0].evaluate(initiator, responder, otherChar, this))
							{
//								totalScore += influenceRuleSet.scoreRules(initiator, responder, otherChar, this, possibleOthers,"",isResponder);
								curScore += influenceRuleSet.scoreRules(initiator, responder, otherChar, this, possibleOthers,"",isResponder);
							}
						}
						if (maxScore < curScore)
							maxScore = curScore;
					}
					totalScore += maxScore;
				}
				else
				{
					// if there is a precondition, but it doesn't require a third, just score the IRS once with variable other
					if (this.preconditions[0].evaluate(initiator, responder, null, this))
					{	
						totalScore += influenceRuleSet.scoreRulesWithVariableOther(initiator, responder, null, this, possibleOthers, "", isResponder);
					}
				}
			}
			else
			{
				//if there are no precondition, just score the IRS, once with a variable other
				totalScore += influenceRuleSet.scoreRulesWithVariableOther(initiator, responder, null, this, possibleOthers,"",isResponder);
			}
			//if (initiator.prospectiveMemory.intentScoreCache[responder.networkID][sg.intents[0].predicates[0].getIntentType()] == ProspectiveMemory.DEFAULT_INTENT_SCORE)
			return totalScore;
		}
		
		/** (April)
		 * Returns true if the current responder type is appropriate for the social move.  Used to make sure item 
		 * moves aren't being used with characters and so on.
		 * 
		 * @param	responder  The responder to this social move
		 * @return  True: The responder matches the responder type held in "type" variable
		 * 			  False: The responder does mot match the type held in "type" variable
		 */
		private function checkResponderType(responder:GameObject):Boolean {
			var gameObj:GameObject = CiFSingleton.getInstance().cast.getCharByName(responder.name);
			if (gameObj != null && this.responderType == CHARACTER_TYPE) 
				{
					//trace("Responder identified as character in the cast");
					return true;
				}
			gameObj = CiFSingleton.getInstance().itemList.getItemByName(responder.name);
			if (gameObj != null && this.responderType == ITEM_TYPE) { 
					//trace("Responder identified as item in the item list");
					return true;
				}
			gameObj = CiFSingleton.getInstance().knowledgeList.getKnowledgeByName(responder.name);
			if (gameObj != null && this.responderType == KNOWLEDGE_TYPE) {
				//trace("Responder identified as knowledge in the knowledge list");
				return true;
			}
			
			//trace("Could not find responder " + responder.name + " to match type " + this.type);
			return false;
		}
		
		/** (April)
		 * Returns true if the current other type is appropriate for the social move.  Used to make sure item 
		 * moves aren't being used with characters and so on.
		 * Note that this should only be called when evaluating social moves that require others.
		 * 
		 * @param	other  The other in this social move
		 * @return  True: The other matches the other type held in "otherType" variable
		 * 			  False: The other does mot match the type held in "otherType" variable
		 */
		private function checkOtherType(other:GameObject):Boolean {
			if (requiresOther == false) Debug.debug(this, "Should not be calling checkOtherType() in a social move that does not require an other!");
			var gameObj:GameObject = CiFSingleton.getInstance().cast.getCharByName(other.name);
			if (gameObj != null && this.otherType == CHARACTER_TYPE) 
				{
					//trace("Other identified as character in the cast");
					return true;
				}
			gameObj = CiFSingleton.getInstance().itemList.getItemByName(other.name);
			if (gameObj != null && this.otherType == ITEM_TYPE) { 
					//trace("Other identified as item in the item list");
					return true;
				}
			gameObj = CiFSingleton.getInstance().knowledgeList.getKnowledgeByName(other.name);
			if (gameObj != null && this.otherType == KNOWLEDGE_TYPE) {
				//trace("Other identified as knowledge in the knowledge list");
				return true;
			}
			
		//	trace("Could not find other " + other.name + " to match type " + this.otherType);
			return false;
		}
		
		public function getPossibleOthers(initiator:GameObject, responder:GameObject):Vector.<GameObject> {
			if (!this.requiresOther) return null;
			
			var viableOthers:Vector.<GameObject> = new Vector.<GameObject>();
			
			var possibleOthers:Vector.<GameObject> = new Vector.<GameObject>();
			for each (var c:Character in CiFSingleton.getInstance().cast.characters) {
				//if (initiator.hasStatus(Status.KNOWS, c)) 
				possibleOthers.push(c as GameObject);
			}
			for each (var item:Item in CiFSingleton.getInstance().itemList.items) {
				//if (initiator.hasStatus(Status.KNOWS, item)) 
				possibleOthers.push(item as GameObject);
			}
			for each (var k:Knowledge in CiFSingleton.getInstance().knowledgeList.knowledges) {
				//if (initiator.hasStatus(Status.KNOWS, k)) 
				possibleOthers.push(k as GameObject);
			}
			
			var isOtherSuitable:Boolean;
			
			if (requiresOther){
				for each (var otherChar:GameObject in possibleOthers) {
					//trace("checking " + otherChar.name + " for viability in move");
					isOtherSuitable = true; //assume the other works unilt proven otherwise
				
					if (otherChar.name != initiator.name && otherChar.name != responder.name) {
						//if the other is found not to be suitable for filling all precondition rules, break the loop and move on
						//to the next possible other.
						//trace(this.name + " evaluating " + initiator.name + " " + responder.name + " " + otherChar.name);
						for (var i:Number = 0; i < this.preconditions.length && isOtherSuitable; ++i)
							if (!this.preconditions[i].evaluate(initiator, responder, otherChar, this)) 
								{ 
									//trace(preconditions[i].name + " failed an evaluate between " + initiator.name + " " + responder.name + " " + otherChar.name);
									isOtherSuitable = false;
								}
						// If a suitable other for preconditions is found, make sure the other ALSO is an appropriate type for the move
						// Should not be a problem for most moves (for example, RequestItem requires the other has trait "item"
						if (isOtherSuitable && !checkOtherType(otherChar)) isOtherSuitable = false;
						if (isOtherSuitable) {
							//trace(this.name + " found a suitable other1 " + otherChar.name);
							viableOthers.push(otherChar);
						}
					}
				
				}
			}
			
			if (viableOthers.length == 0) return null;
			else return viableOthers;
		}
		
		/**
		 * Returns the responder's influence rule set score with respect to the
		 * character/role mapping given in the arguments.
		 * 
		 * @param	initiator	The initiator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 * @return
		 */
		public function getResponderScore(initiator:GameObject, responder:GameObject, other:GameObject = null, sg:SocialGame = null, activeOtherCast:Vector.<GameObject> = null):Number {
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = this.getPossibleOthers(initiator, responder);
			}
			return this.responderIRS.scoreRules(initiator, responder, other, sg, possibleOthers);
		}
		
		/**
		 * Evaluates the precditions of the social game with respect to 
		 * character/role mapping given in the arguments for the initiator
		 * and responder while finding an other that fits all precondition 
		 * rules if a third character is require by any of those rules.
		 * 
		 * @param	initiator		The initiator of the social game.
		 * @param	responder		The responder of the social game.
		 * @param 	activeOtherCast The possible characters to fill the other role.
		 * @return True if all precondition rules evaluate to true. False if 
		 * they do not.
		 */
		public function checkPreconditionsVariableOther(initiator:GameObject, responder:GameObject, activeOtherCast:Vector.<GameObject> = null):Boolean {
			//trace(this.name + " in checkPreconditionsVariableOther for " + initiator.name + " " + responder.name + " ");
			// If responder is not of the right type, automatically fail
			if (checkResponderType(responder) == false) {
				//trace("Type Mismatch between " + responder.name + " and " + this.type);
				return false;
			}
			if (this.preconditions.length < 1) return true; //no preconditions is automatically true
			
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = new Vector.<GameObject>();
				for each (var c:Character in CiFSingleton.getInstance().cast.characters) {
					if (initiator.hasStatus(Status.KNOWS, c)) possibleOthers.push(c as GameObject);
				}
				for each (var item:Item in CiFSingleton.getInstance().itemList.items) {
					if (initiator.hasStatus(Status.KNOWS, item)) possibleOthers.push(item as GameObject);
				}
				for each (var k:Knowledge in CiFSingleton.getInstance().knowledgeList.knowledges) {
					if (initiator.hasStatus(Status.KNOWS, k)) possibleOthers.push(k as GameObject);
				}
			}
			
			var precond:Rule;
			var requiresOther:Boolean = false;
			var otherChar:GameObject;
			var i:int;
			var isOtherSuitable:Boolean;
			
			for each(precond in this.preconditions) {
				if (precond.requiresThirdCharacter()) {
					requiresOther = true;
					this.requiresOther = true;
					//trace(this.name + " detected requiring an other");
				}
			}
			this.requiresOther = requiresOther;
			
			if (requiresOther) {
				//trace(this.name + " checking that other");
				//iterate through all possible others and check each precondition with the current other
					for each (otherChar in possibleOthers) {
						//trace("checking " + otherChar.name + " for viability in move");
						isOtherSuitable = true; //assume the other works unilt proven otherwise
						
						if (otherChar.name != initiator.name && otherChar.name != responder.name) {
							//if the other is found not to be suitable for filling all precondition rules, break the loop and move on
							//to the next possible other.
							//trace(this.name + " evaluating " + initiator.name + " " + responder.name + " " + otherChar.name);
							for (i = 0; i < this.preconditions.length && isOtherSuitable; ++i)
								if (!this.preconditions[i].evaluate(initiator, responder, otherChar, this)) 
									{ 
										//trace(preconditions[i].name + " failed an evaluate between " + initiator.name + " " + responder.name + " " + otherChar.name);
										isOtherSuitable = false;
									}
							// If a suitable other for preconditions is found, make sure the other ALSO is an appropriate type for the move
							// Should not be a problem for most moves (for example, RequestItem requires the other has trait "item"
							if (isOtherSuitable && !checkOtherType(otherChar)) isOtherSuitable = false;
							if (isOtherSuitable) {
							//	trace(this.name + " found a suitable other1 " + otherChar.name);
								return true;
							}
						}
						
					}
					//other was true for all preconditions -- Needs to be in the loop? (April)
					if (isOtherSuitable) {
						//trace(this.name + " found a suitable other2 " + otherChar.name);
						return true;
					}
				
			} else {
				for each (precond in this.preconditions) {
					if (!precond.evaluate(initiator, responder, null, this))
						return false;
				}
				return true;
			}
			
			//default case
			return false;
		}
		
		/** (April)
		 * Evaluates the precditions of the social game with respect to 
		 * character/role mapping given in the arguments for the initiator
		 * and responder while finding ALL others that fit all precondition 
		 * rules if a third character is require by any of those rules.
		 * 
		 * @param	initiator								The initiator of the social game.
		 * @param	responder							The responder of the social game.
		 * @param 	activeOtherCast 					The possible characters to fill the other role.
		 * @return 	null									Move doesn't require an other (in which case this should never be called)
		 * 				finalChoice (length == 0) 		No others were found (in which case this move shouldn't have been offered)
		 * 				finalChoice (length > 0) 		All viable options for others from which the player can choose
		 */
		public function checkPreconditionsFindAllOthers(initiator:GameObject, responder:GameObject, activeOtherCast:Vector.<GameObject> = null):Vector.<GameObject> {
			var finalChoice:Vector.<GameObject> = null;
			//trace(this.name + " in checkPreconditionsVariableOther for " + initiator.name + " " + responder.name + " ");
			// If responder is not of the right type, automatically fail
			if (checkResponderType(responder) == false) {
				//trace("Type Mismatch between " + responder.name + " and " + this.type);
				return finalChoice; // Will be null
			}
			
			var possibleOthers:Vector.<GameObject>;
			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = new Vector.<GameObject>();
				for each (var c:Character in CiFSingleton.getInstance().cast.characters) {
					if (initiator.hasStatus(Status.KNOWS, c)) possibleOthers.push(c as GameObject);
				}
				for each (var item:Item in CiFSingleton.getInstance().itemList.items) {
					if (initiator.hasStatus(Status.KNOWS, item)) possibleOthers.push(item as GameObject);
				}
				for each (var k:Knowledge in CiFSingleton.getInstance().knowledgeList.knowledges) {
					if (initiator.hasStatus(Status.KNOWS, k)) possibleOthers.push(k as GameObject);
				}

			}
			
			if (this.preconditions.length < 1) return possibleOthers; //no preconditions is automatically true: offer all available other members
			
			finalChoice = new Vector.<GameObject>();
			var precond:Rule;
			var requiresOther:Boolean = false;
			var otherChar:GameObject;
			var i:int;
			var isOtherSuitable:Boolean;
			
			for each(precond in this.preconditions) {
				if (precond.requiresThirdCharacter()) {
					requiresOther = true;
					//trace(this.name + " detected requiring an other");
				}
			}
			this.requiresOther = requiresOther;
			
			if (requiresOther) { // WHICH IS SHOULD
				for each (otherChar in possibleOthers) {
					isOtherSuitable = true; //assume the other works unilt proven otherwise
					
					if (otherChar.name != initiator.name && otherChar.name != responder.name) {
						for (i = 0; i < this.preconditions.length && isOtherSuitable; ++i)
							if (!this.preconditions[i].evaluate(initiator, responder, otherChar, this)) 
								{ 
									//trace(preconditions[i].name + " failed an evaluate between " + initiator.name + " " + responder.name + " " + otherChar.name);
									isOtherSuitable = false;
								}
						if (isOtherSuitable && !checkOtherType(otherChar)) isOtherSuitable = false;
						if (isOtherSuitable) {
							//trace(this.name + " found a suitable other1 " + otherChar.name);
							finalChoice.push(otherChar);
						}
					}
					
				}
			}
			
			//default case
			if (finalChoice.length == 0) {
				trace("SocialGame.checkPreconditionsFindAllOthers(): Failed to find any suitable others, should not have been offered as a social move");
			}
			return finalChoice;
		}
		
		/**
         * Evaluates the precditions of the social game with respect to 
         * character/role mapping given in the arguments.
         * 
         * @param    initiator    The initiator of the social game.
         * @param    responder    The responder of the social game.
         * @param    other        A third party in the social game.
         * @return True if all precondition rules evaluate to true. False if 
         * they do not.
         */
        public function checkPreconditions(initiator:GameObject, responder:GameObject, other:GameObject = null, sg:SocialGame = null):Boolean {
			if (checkResponderType(responder) == false) {
				//trace("Type Mismatch");
				return false;
			}
            for each (var preconditionRule:Rule in this.preconditions) {
                //if (name.toLowerCase() == "true love's kiss") 
                    //Debug.debug(this, initiator.name + ", " + responder.name + " on " + preconditionRule.toString());
                if (!preconditionRule.evaluate(initiator, responder, other, sg))
                    return false;
            }
            return true;
        }
		
		public function checkEffectConditions(initiator:GameObject, responder:GameObject, other:GameObject = null):Boolean 
		{
			for each (var e:Effect in this.effects)
			{
				if (!e.condition.evaluate(initiator, responder, other))
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		 * Evaluates the intents of the social game with respect to 
		 * character/role mapping given in the arguments.
		 * 
		 * @param	initiator	The initiator of the social game.
		 * @param	responder	The responder of the social game.
		 * @param	other		A third party in the social game.
		 * @return True if all intent rules evaluate to true. False if 
		 * they do not.
		 */
		public function checkIntents(initiator:GameObject, responder:GameObject, other:GameObject = null, sg:SocialGame=null):Boolean {
			for each (var intentRule:Rule in this.intents) {
				//if (name.toLowerCase() == "true love's kiss") 
					//Debug.debug(this, initiator.name + ", " + responder.name + " on " + preconditionRule.toString());
				if (!intentRule.evaluate(initiator, responder, other, sg))
					return false;
			}
			return true;
		}
		
		/**
		 * Synonym setter for the game's name (backward compatability with
		 * GDC demo.
		 */
		public function get specificTypeOfGame():String {
			return this.name;
		}
		
		/**
		 * Synonym setter for the game's name (backward compatability with
		 * GDC demo.
		 */
		public function set specificTypeOfGame(n:String):void {
			this.name = n;
		}
		
		/**
		 * Gets social game type
		 */
		public function getResponderType():Number {
			return this.responderType;
		}
		
		/**
		 * Sets social game type
		 */
		public function setResponderType(n:Number):void {
			this.responderType = n;
		}
		
		/**
		 * Determines if we need to find a third character for the intent
		 * formation process.
		 * @return True if a third character is needed, false if not.
		 */
		public function thirdForIntentFormation():Boolean {
			for each (var r:Rule in this.preconditions) 
				if (r.requiresThirdCharacter()) return true;
			
				
			var ir:InfluenceRule;
			for each (ir in this.initiatorIRS.influenceRules)
				if (ir.requiresThirdCharacter()) return true;
				
			for each (ir in this.responderIRS.influenceRules)
				if (ir.requiresThirdCharacter()) return true;
				
			for each (var e:Effect in this.effects)
			{
				if (e.condition.requiresThirdCharacter()) return true;
				if (e.change.requiresThirdCharacter()) return true;
			}
			
			return false;
		}
		
		/**
		 * Determines if we need to find a third character for social game 
		 * play.
		 * @return True if a third character is needed, false if not.
		 */
		public function thirdForSocialGamePlay():Boolean {
			//for each (var ir:InfluenceRule in this.responderIRS.influenceRules)
				//if (ir.requiresThirdCharacter()) return true;
			for each (var e:Effect in this.effects) 
				if (e.change.requiresThirdCharacter() || e.condition.requiresThirdCharacter())
					return true;
				
			return false;
		}
		
		/**
		 * Finds an instantiation given an id. 
		 * @param	id	id of instantiation to find.
		 * @return	Instantiation with the parameterized id, null if not
		 * found.
		 */
		public function getInstantiationById(id:int):Instantiation {
			for each(var inst:Instantiation in this.instantiations) {
				if (id == inst.id)
					return inst;
			}
			Debug.debug(this, "getInstiationById() id not found. id=" + id);
			return null;
		}
		
		public function get thirdParty():Boolean
		{
			return this.thirdPartyTalkAboutSomeone || this.thirdPartyGetSomeoneToDoSomethingForYou;
		}
		
		public function updateRequiresOther():void {
			for each(var precond:Rule in this.preconditions) {
				if (precond.requiresThirdCharacter()) {
					this.requiresOther = true;
				} else {
					this.requiresOther = false;
				}
			}
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		public function toXMLString():String {
			var returnstr:String = new String();
			var i:Number = 0;
			returnstr += "<SocialGame name=\"" + this.name + "\"" + " requiresOther=\"" + this.requiresOther + "\"" + " type=\"" + this.responderType + "\"" + " othertype=\"" + this.otherType + "\""
			
			if (this.thirdPartyGetSomeoneToDoSomethingForYou)
			{
				returnstr += " thirdPartyGetSomeoneToDoSomethingForYou=\"true\"";
			}
			if (this.thirdPartyTalkAboutSomeone)
			{
				returnstr += " thirdPartyTalkAboutSomeone=\"true\"";
			}
			
			returnstr += ">\n";
	
			returnstr += "<PatsyRule>\n";
			returnstr += this.patsyRule.toXMLString();
			
			returnstr += "</PatsyRule>\n";
			
			returnstr += "<Intents>\n";
			for (i = 0; i < this.intents.length; ++i) {
				//returnstr += "   ";
				returnstr += this.intents[i].toXMLString();
				//returnstr += "\n";
			}
			returnstr += "</Intents>\n";
			
			returnstr += "<Preconditions>\n";
			for (i = 0; i < this.preconditions.length; ++i) {
				//returnstr += "   ";
				returnstr += this.preconditions[i].toXMLString();
				//returnstr += "\n";
			}
			returnstr += "</Preconditions>\n";
			
			//put xml tags here to differentiate between initiator and responder influence rules.
			returnstr += "<InitiatorInfluenceRuleSet>\n";
			returnstr += this.initiatorIRS.toXMLString();
			returnstr += "</InitiatorInfluenceRuleSet>\n";
			
			returnstr += "<ResponderInfluenceRuleSet>\n";
			returnstr += this.responderIRS.toXMLString();
			returnstr += "</ResponderInfluenceRuleSet>\n";
			
			returnstr += "<Effects>\n";
			for (i = 0; i < this.effects.length; ++i) {
				//returnstr += "   ";
				returnstr += this.effects[i].toXMLString();
				//returnstr += "\n";
			}
			returnstr += "</Effects>\n";
			
			returnstr += "<Instantiations>\n";
			for (i = 0; i < this.instantiations.length; ++i) {
				//returnstr += "   ";
				returnstr += this.instantiations[i].toXMLString();
				//returnstr += "\n";
			}
			returnstr += "</Instantiations>\n";
			
			returnstr += "</SocialGame>\n";
			return returnstr;
		}
		 
		public function clone(): SocialGame {
			var sg:SocialGame = new SocialGame();
			sg.name = this.name;
			sg.responderType = this.responderType;
			sg.otherType = this.otherType;
			sg.requiresOther = this.requiresOther;
			
			sg.intents = new Vector.<Rule>();
			var r:Rule;
			for each(r in this.intents) {
				sg.intents.push(r.clone());
			}
			
			sg.patsyRule = this.patsyRule.clone();
			
			sg.preconditions = new Vector.<Rule>();
			for each(r in this.preconditions) {
				sg.preconditions.push(r.clone());
			}
			sg.initiatorIRS = this.initiatorIRS.clone();
			sg.responderIRS = this.responderIRS.clone();
			sg.effects = new Vector.<Effect>();
			for each(var e:Effect in this.effects) {
				sg.effects.push(e.clone());
			}
			sg.instantiations = new Vector.<Instantiation>();
			for each(var i:Instantiation in this.instantiations) {
				sg.instantiations.push(i.clone());
			}
			return sg;
		}
		
		public static function equals(x:SocialGame, y:SocialGame): Boolean {
			if (x.name != y.name) return false;
			if (x.responderType != y.responderType) return false;
			if (x.intents.length != y.intents.length) return false;
			var i:Number = 0;
			for (i = 0; i < x.intents.length; ++i) {
				if (!Rule.equals(x.intents[i], y.intents[i])) return false;
			}
			if (x.preconditions.length != y.preconditions.length) return false;
			for (i=0; i < x.preconditions.length; ++i) {
				if (!Rule.equals(x.preconditions[i], y.preconditions[i])) return false;
			}
			if (!Rule.equals(x.patsyRule, y.patsyRule)) return false;
			if (!InfluenceRuleSet.equals(x.initiatorIRS, y.initiatorIRS)) return false;
			if (!InfluenceRuleSet.equals(x.responderIRS, y.responderIRS)) return false;
			if (x.effects.length != y.effects.length) return false;
			for (i = 0; i < x.effects.length; ++i) {
				if (!Effect.equals(x.effects[i], y.effects[i])) return false;
			}
			if (x.instantiations.length != y.instantiations.length) return false;
			for (i = 0; i < x.instantiations.length; ++i) {
				if (!Instantiation.equals(x.instantiations[i], y.instantiations[i])) return false;
			}
			return true;
		}
		
		public static function checkEffectSelection(name:String): Boolean {
			switch(name.toLocaleLowerCase()) {
				case "use":
					return true;
				case "give item":
					return true;
				case "give romantic item":
					return true;
				default:
					return false;
			}
		}
		
		public static function getTypeByName(name:String): Number {
			switch (name.toLowerCase())
			{
				case "character":
					return SocialGame.CHARACTER_TYPE;
				case "item":
					return SocialGame.ITEM_TYPE;
				case "knowledge":
					return SocialGame.KNOWLEDGE_TYPE;
				default:
					return -1;
			}
		}
		
		public static function getNameByType(type:Number): String {
			switch (type)
			{
				case SocialGame.CHARACTER_TYPE:
					return "character";
				case SocialGame.ITEM_TYPE:
					return "item";
				case SocialGame.KNOWLEDGE_TYPE:
					return "knowledge";
				default:
					return "type not found";
			}
		}
	}
	
}