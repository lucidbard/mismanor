package grailgm 
{
	import CiF.BuddyNetwork;
	import CiF.Cast;
	import CiF.Character;
	import CiF.CiFSingleton;
	import CiF.GameObject;
	import CiF.GameScore;
	import CiF.InfluenceRule;
	import CiF.InfluenceRuleSet;
	import CiF.Item;
	import CiF.Microtheory;
	import CiF.Predicate;
	import CiF.ProspectiveMemory;
	import CiF.Rule;
	/**
	 * ...
	 * @author Anne Sullivan
	 */

	 public class QuestLib 
	{		
		/**
		 * The quests in the library.
		 */
		public var quests:Vector.<Quest>;
		public var activeQuests:Vector.<Quest> = new Vector.<Quest>();
		public var possibleQuests:Vector.<Quest> = new Vector.<Quest>();
		public var selectedQuest:Quest;

		public var questGiverHistory:Vector.<Number> = new Vector.<Number>();
		public var totalQuests:Number;

		public var questMixing:Number = 1;
		public var questConcentration:Number = 0;
		public var intentWeight:Number = 0;
		
		public function QuestLib() 		
		{
			this.quests = new Vector.<Quest>();
		}

		public function clean(): void {
			var quest:Quest;
			
			if (quests)
			{
				for each (quest in quests)
				{
					quest.clean();
					quest = null;
				}
				quests = null;
			}
			
			if (activeQuests)
			{
				for each (quest in activeQuests)
				{
					quest.clean();
					quest = null;
				}
				activeQuests = null;
			}
			
			if (possibleQuests)
			{
				for each (quest in possibleQuests)
				{
					quest.clean();
					quest = null;
				}
				possibleQuests = null;
			}
			
			if (selectedQuest)
				selectedQuest.clean();
			selectedQuest = null;
			
			questGiverHistory = null;
		}
		
		public function updatePossible(initiator:Character, responderPoss:Cast): void
		{
			// start fresh
			possibleQuests = new Vector.<Quest>();
			
			// update the list of possible quests
			for each (var quest:Quest in quests)
			{
				if (!quest.used)
				{
					// evaluate whether the preconditions have been met 
					if (quest.checkAllPreconditions(initiator, responderPoss))
						possibleQuests.push(quest);
				}
			}
		}
		
		public function updateActive(initiator:GameObject, responder:GameObject): void
		{
			// start fresh
			this.activeQuests = new Vector.<Quest>();
			
			// logic for weighting quests goes here
			for each (var quest:Quest in this.possibleQuests)
			{
				var cif:CiFSingleton = CiFSingleton.getInstance();
				var questGiver:Character = cif.cast.getCharByName(quest.questGiver);
				// Score volition of the questGiver giving this particular quest
				formIntentForQuest(quest, questGiver, initiator);
								
				var socialWeight:Number = 0;
				// quests from characters with higher relationships with the player are weighted higher
/*				var char:Character = cif.cast.getCharByName(quest.questGiver);
				var player:Character = cif.cast.getCharByName("player");
				
				var romanceWeight:Number = cif.romanceNetwork.getWeight(char.networkID, player.networkID);
				var buddyWeight:Number = cif.buddyNetwork.getWeight(char.networkID, player.networkID);
				var trustWeight:Number = cif.trustNetwork.getWeight(char.networkID, player.networkID);
				var familyWeight:Number = cif.familyBondNetwork.getWeight(char.networkID, player.networkID);
				
				// -1 if less than 25, +1 if over 50, +2 if over 75, +3 if 100
				socialWeight = (Math.floor(romanceWeight / 25) - 1) + (Math.floor(buddyWeight / 25) - 1) + (Math.floor(trustWeight / 25) - 1) + (Math.floor(familyWeight / 25) - 1);
				socialWeight *= intentWeight;
*/
				socialWeight = quest.volition * intentWeight;
				
				// weight based on quest giver history
				// see if qust giver has already given a quest and keep track of the position
				var position:Number = 0;
				var concentration:Number = 0;
				var mixing:Number = 0;
				
				for each (var qgiver:String in questGiverHistory)
				{
					if (quest.questGiver.toLowerCase() == qgiver.toLowerCase())
					{
						concentration = mixing += Math.pow(0.5, position);
					}
							
					position++;
				}

				mixing *= -1; // negative weight
				mixing *= questMixing;
				
				concentration *= questConcentration;
				quest.weight = socialWeight + concentration + mixing;
			}
			
			// sort the quests by highest weight to lowest weight
			var questSort:Function = function (a:Quest, b:Quest) : int
			{
				var result:int;
				if (a.weight > b.weight) {
					result = -1;
				} else if (a.weight < b.weight) {
					result =  1;    
				} else {
					result 0;
				}
				return result;
			}
			
			this.possibleQuests.sort(questSort);

			// take the top 3 highest rated quests
			while (this.activeQuests.length < 3 && this.possibleQuests.length > 0)
			{
				this.activeQuests.push(this.possibleQuests[0]);
				this.possibleQuests.splice(0, 1);
			}

		}
		
		public function getQuest(initiator:Character):Quest
		{
			// pick the highest weighted quest with the initiator as the quest giver return null if no quests found
			for each (var quest:Quest in activeQuests)
			{
				if (quest.questGiver.toLowerCase() == initiator.name.toLowerCase())
					return quest;
			}
			return null;
		}
		
		public function formIntentForQuest(quest:Quest, questGiver:GameObject, responder:GameObject, activeOtherCast:Vector.<GameObject> = null):void {
			var possibleOthers:Vector.<GameObject> = new Vector.<GameObject>();
/*			if (activeOtherCast != null) {
				possibleOthers = activeOtherCast;
			} else {
				possibleOthers = quest.getPossibleOthers(questGiver, responder);
			}
*/
			var primary:String = quest.intents[0].predicates[0].first;
			var secondary:String = quest.intents[0].predicates[0].second;
			var otherName:String = quest.intents[0].predicates[0].tertiary;
			
			var cif:CiFSingleton = CiFSingleton.getInstance();
			var initiator:Character = cif.cast.getCharByName(questGiver.name);
			var responder:GameObject;
			var other:GameObject;
			
			if (initiator.name.toLowerCase() == primary.toLowerCase())
			{
				responder = cif.getGameObjByName(secondary);
				other = cif.getGameObjByName(otherName);
			}
			else
			{
				responder = cif.getGameObjByName(primary);
				other = cif.getGameObjByName(secondary);
			}
			
			if (other)
			{
				possibleOthers.push(other);
			}
			var score:Number = 0;
			
			if (initiator.prospectiveMemory.intentScoreCache[responder.networkID][quest.intents[0].predicates[0].getIntentType()] == ProspectiveMemory.DEFAULT_INTENT_SCORE)
			{
				
				score = this.scoreAllMicrotheoriesForQuest(quest, questGiver, responder, possibleOthers);
				initiator.prospectiveMemory.intentScoreCache[responder.networkID][quest.intents[0].predicates[0].getIntentType()] = score;
			}
			else
				score = initiator.prospectiveMemory.intentScoreCache[responder.networkID][quest.intents[0].predicates[0].getIntentType()];
				
			quest.volition = score;
		}

		public function scoreAllMicrotheoriesForQuest(quest:Quest, initiator:GameObject, responder:GameObject,activeOtherCast:Vector.<GameObject> = null):Number
		{			
			var totalScore:Number = 0.0;
			for each (var theory:Microtheory in CiFSingleton.getInstance().microtheories)
			{
				totalScore += scoreMicrotheoryForQuest(theory, initiator, responder, quest, activeOtherCast);
			}
			return totalScore;
		}

		/**
		 * This function will score an influence rule set for all others that fit the definition or no others 
		 * if the definition doesn't require it.
		 * 
		 * @param	theory
		 * @param	initiator
		 * @param	responder
		 * @param	activeOtherCast
		 * @return The total weight of the influence rules
		 */
		public function scoreMicrotheoryForQuest(theory:Microtheory, initiator:GameObject, responder:GameObject, quest:Quest, activeOtherCast:Vector.<GameObject> = null):Number
		{			
			var influenceRuleSet:InfluenceRuleSet = theory.initiatorIRS;
			var rule:Rule;
			var pred:Predicate;
			var questPred:Predicate;
			var totalScore:Number = 0;
			var tempScore:Number = 0;
			
			if (theory.definition.requiresThirdCharacter())
			{
				//if the definition is about an other, if it is true for even one other, run the MT's
				for each (var otherChar:GameObject in activeOtherCast)
				{	
					if (otherChar.name != initiator.name &&
						otherChar.name != responder.name) 
					{
						for each (pred in theory.definition.predicates)
						{
							if (questEvaluate(pred, initiator, responder, otherChar, quest))
							{
								tempScore = scoreRules(influenceRuleSet, initiator, responder, activeOtherCast, quest);
								if (tempScore > 20 || tempScore < -20)
								{
									trace(pred + " has a super high rating!!!");
								}
								totalScore += tempScore;
							}
						}
					}
				}
			}
			else
			{
				for each (pred in theory.definition.predicates)
				{
					if (questEvaluate(pred, initiator, responder, null, quest))
					{
						tempScore = scoreRules(influenceRuleSet, initiator, responder, activeOtherCast, quest);
						if (tempScore > 20 || tempScore < -20)
						{
							trace(pred + " has a super high rating!!!");
						}
						totalScore += tempScore;
					}
				}
			}
			return totalScore;
		}
		
		public function scoreRules(irs:InfluenceRuleSet, initiator:GameObject, responder:GameObject, activeOtherCast:Vector.<GameObject> = null, quest:Quest = null):Number 
		{
			var score:Number = 0.0;
			var rule:Rule;
			var pred:Predicate;
			var questPred:Predicate;
			
			for each (var ir:InfluenceRule in irs.influenceRules) 
			{
				if (ir.weight != 0)
				{
					if (ir.requiresThirdCharacter())
					{
						//if the definition is about an other, if it is true for even one other, run the MT's
						for each (var otherChar:GameObject in activeOtherCast)
						{	
							if (otherChar.name != initiator.name &&
								otherChar.name != responder.name) 
							{
								for each (pred in ir.predicates)
								{
									if (questEvaluate(pred, initiator, responder, otherChar, quest))
												score += ir.weight;
								}							
							}
						}
					}
					else
					{
						for each (pred in ir.predicates)
						{
							if (questEvaluate(pred, initiator, responder, null, quest))
							{
								score += ir.weight;
							}
						}							
					}
				}
			}
			return score;
		}
		
		public static function questEvaluate(pred:Predicate, x:GameObject, y:GameObject=null, z:GameObject= null, quest:Quest=null):Boolean {
			var first:CiF.GameObject;
			var second:CiF.GameObject;
			var third:CiF.GameObject;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			//there is a third character we need to account for.
			var isThird:Boolean = false;
			var questPred:Predicate;
			var rule:Rule;
			var intentIsTrue:Boolean = false;

			/**
			 * Need to determine if the predicate's predicate variables reference
			 * roles (initiator,responder), generic variables (x,y,z), or 
			 * characters (edward, karen).
			 */
			//if this.primary is not a reference to a character, determine if 
			//it is either a role or a generic variable
			if (!(first = cif.cast.getCharByName(pred.primary))) {
				switch (pred.getPrimaryValue()) {
					case "initiator":
					case "x":
						first = x;
						break;
					case "responder":
					case "y": 
						first = y;
						break;
					case "other":
					case "z":
						first = z;
						break;
					default:
						break;
				}
			}
			
			if (!(second = cif.cast.getCharByName(pred.secondary))) {
				switch (pred.getSecondaryValue()) {
					case "initiator":
					case "x":
						second = x;
						break;
					case "responder":
					case "y": 
						second = y;
						break;
					case "other":
					case "z":
						second = z;
						break;
					default:
						second = null;
				}
			}
			
			if (!(third = cif.cast.getCharByName(pred.tertiary))) {
				switch (pred.getTertiaryValue()) {
					case "initiator":
					case "x":
						third = x;
						isThird = true;
						break;
					case "responder":
					case "y": 
						third = y;
						isThird = true;
						break;
					case "other":
					case "z":
						third = z;
						isThird = true;
						break;
					default:
						isThird = false;
						third = null;
				}
			}
						 
			/*
			 * If the predicate is intent, we want to check it against all of the 
			 * intent predicates in the intent rule in the passed-in quest.
			 * If this predicate matches any predicate in any rule of the intent
			 * rule vector of the quest, we return true.
			 * 
			 * Intents can only be networks and relationships.
			 */
			if (pred.intent) {
				//Debug.debug(this, "evaluate() in intent processing. sg: " + sg);
				//is it a network
				if (pred.type == Predicate.NETWORK) {
					for each(rule in quest.intents) {
						for each(questPred in rule.predicates) {
							if (questPred.networkType == pred.networkType &&
								questPred.comparator == pred.comparator &&
								pred.negated == questPred.negated) {
								
								return true;
							}
								
						}
					}
				}
				//is it a sfdbLabel
				else if (pred.type == Predicate.SFDBLABEL)
				{
					for each(rule in quest.intents) {
						for each(questPred in rule.predicates) {
							if (pred.sfdbLabel == questPred.sfdbLabel &&
								pred.negated == questPred.negated) {
								
								return true;
							}
						}
					}
				}
				else if (pred.type == Predicate.STATUS) {
					for each (rule in quest.intents) {
						for each(questPred in rule.predicates) {
							if (questPred.status == pred.status &&
								pred.negated == questPred.negated) {
								return true;
							}
						}
					}
				}
				//is it a network
				return false;
			}
			 
			switch (pred.type) 
			{
				case Predicate.TRAIT:
					return pred.negated ? !pred.evalTrait(first) : pred.evalTrait(first);
				case Predicate.NETWORK:
					//trace("Going in here: "+this.toString() + " first: " + first.name + " second: " + second.name);
					//var isNetworkEvalTrue:Boolean = this.negated ? !evalNetwork(first, second) : evalNetwork(first, second);
					//Debug.debug(this, "evaluate() ^ returned " + isNetworkEvalTrue);
					return pred.evalNetwork(first, second);
				case Predicate.STATUS:
					//if (first == null) Debug.debug(this, "found it: "+this.toString());
					return pred.negated ? !pred.evalStatus(first, second) : pred.evalStatus(first, second);
				case Predicate.CKBENTRY:
					return pred.evalCKBEntry(first, second);
				case Predicate.SFDBLABEL:
					return pred.evalSFDBLABEL(first, second, third);
				default:
					break;
			}
			return false;
		}
		/**
		 * Creates all the item quest possibilities for each item 
		 * @param	List of Items to create quests from
		 * @return none
		 */
/*		public function createItemQuests(itemList:Vector.<Item>):void {
			var id:int = 0;
			for each (var item:Item in itemList){
				// create fedex quest - precondition: character has item
				var newQuest:Quest = new Quest();
				var newRule:Rule = new Rule();
				var newPredicate:Predicate = new Predicate();
				var itemName:String = item.name;
				
				newQuest.name = "Deliver " + itemName;
				newQuest.type = Quest.FEDEX;
				newQuest.item = item.clone();
				newRule.name = "Has Item " + itemName;
				newPredicate.setHasItemPredicate("initiator", item);
				newRule.predicates.push(newPredicate.clone());
				newRule.id = id;
				id++;
				newQuest.preconditions.push(newRule.clone());
				this.quests.push(newQuest.clone());
				
				// create fetch quest - precondition: character desires item and has not had it in the past
				newQuest = new Quest();
				newRule = new Rule();
				newPredicate = new Predicate();
				
				newQuest.name = "Fetch " + itemName;
				newQuest.type = Quest.FETCH;
				newQuest.item = item.clone();
				newRule.name = "Desires item not previously owned: " + itemName;
				newPredicate.setDesiresItemPredicate("initiator", item);
				newRule.predicates.push(newPredicate.clone());
				newPredicate = new Predicate();
				newPredicate.setPastItemPredicate("initiator", item, true);
				newRule.predicates.push(newPredicate.clone());
				newRule.id = 100 + id;
				id++;
				newQuest.preconditions.push(newRule.clone());
				this.quests.push(newQuest.clone());
				
				// create recovery quest - precondition: character had item in past and desires item
				newQuest = new Quest();
				newRule = new Rule();
				newPredicate = new Predicate();
				
				newQuest.name = "Recover " + itemName;
				newQuest.type = Quest.RECOVER;
				newQuest.item = item.clone();
				newRule.name = "Desires item previously owned: " + itemName;
				newPredicate.setDesiresItemPredicate("initiator", item);
				newRule.predicates.push(newPredicate.clone());
				newPredicate = new Predicate();
				newPredicate.setPastItemPredicate("initiator", item);
				newRule.predicates.push(newPredicate.clone());
				newRule.id = 200 + id;
				id++;
				newQuest.preconditions.push(newRule.clone());
				this.quests.push(newQuest.clone());
			}
		}
		*/
		
		/**
		 * Retrieves a quest from the library via its name.
		 * @param	name	The name of the quest to retrieve.
		 * @return	A reference to the quest in the library or null if there is
		 * no quest associated with the name.
		 */
		public function getByName(name:String):Quest {
			var lowerName:String = name.toLowerCase();
			for (var i:int = 0; i < quests.length; ++i) {
				if (quests[i].name.toLowerCase() == lowerName) {
					return quests[i];
				}
			}
			
			trace("Could not find quest " + name + " in quest pool!\n");
			return null;
		}
			
		/**
		 * Provides the index of the quest associated with the name.
		 * @param	name	The name of the quest.
		 * @return	The index into the library's vector of quests corresponding
		 * to the quest that matches the name. Returns -1 if there was no quest
		 * corresponding to the name.
		 */
		public function getIndexByName(name:String):int {
			for (var i:int = 0; i < quests.length; ++i) {
				if (quests[i].name.toLowerCase() == name.toLowerCase()) {
					return i;
				}
			}
			return -1;
		}
			
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/

		public function toXMLString():String {
			var output:String = "<QuestLibrary>\n";
			var i:int;
			for (i = 0; i < this.quests.length; ++i) {
				output += quests[i].toXMLString();
			}
			output += "</QuestLibrary>\n";
			return output;
		}


	}	
}
	