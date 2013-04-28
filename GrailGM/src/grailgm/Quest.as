package grailgm 
{
	import CiF.Cast;
	import CiF.Character;
	import CiF.CiFSingleton;
	import CiF.Effect;
	import CiF.GameObject;
	import CiF.InfluenceRuleSet;
	import CiF.Instantiation;
	import CiF.Item;
	import CiF.Knowledge;
	import CiF.LineOfDialogue;
	import CiF.Predicate;
	import CiF.Rule;
	/**
	 * ...
	 * @author Anne Sullivan
	 * The Quest class stores quests in their declarative form; the
	 * quest preconditions, influence sets, and effects are stored. What
	 * is not stored is the decisions made by the player or AI system about what
	 * quest choices are made.
	 */
	public class Quest
	{
		public var name:String = "";
		public var type:Number = QuestType.UNKNOWN_TYPE;
		public var id:Number = -1;
		public var itemRequired:Boolean = false; // Whether the quest involves an item or not
		public var questGiver:String = new String(); 
		public var questCompleter:String = new String(); 
		
		public var intents:Vector.<Rule> = new Vector.<Rule>();
		public var preconditions:Vector.<Rule> = new Vector.<Rule>();

		public var startingStates:Vector.<QuestState> = new Vector.<QuestState>();
		public var completionStates:Vector.<QuestState> = new Vector.<QuestState>();
		
		// tags that are used for picking quests and plot points
		public var charsMentioned:Vector.<String> = new Vector.<String>();
		public var locsMentioned:Vector.<String> = new Vector.<String>();
		
		public var used:Boolean = false; // Whether the quest has been used already or not
		public var complete:Boolean = false;
		public var chosenStart:Number = -1; // the ID matching the starting instantiation used
		
		public var volition:Number = 0;
		public var weight:Number = 0;
		
		public function Quest()
		{
		}
		
		public function clean(): void {
			var rule:Rule;
			
			name = null;
			questGiver = null;
			questCompleter = null;
			
			if (intents)
			{
				for each (rule in intents)
				{
					rule.clean();
					rule = null;
				}
				intents = null;
			}
			
			if (preconditions)
			{
				for each (rule in preconditions)
				{
					rule.clean();
					rule = null;
				}
				preconditions = null;
			}
			
			var state:QuestState;
			
			if (startingStates)
			{
				for each (state in startingStates)
				{
					state.clean();
					state = null;
				}
				startingStates = null;
			}
			
			if (completionStates)
			{
				for each (state in completionStates)
				{
					state.clean();
					state = null;
				}
				completionStates = null;
			}
			
			if (charsMentioned)
			{
				for each (var char:String in charsMentioned)
				{
					//char.clean();
					char = null;
				}
				charsMentioned = null;
			}

			if (locsMentioned)
			{
				for each (var loc:String in locsMentioned)
				{
					//loc.clean();
					loc = null;
				}
				locsMentioned = null;
			}
		}
		
		// Check the success and failure conditions to see if the quest is complete
		public function checkForCompletion(initiatorName:String, responderName:String):Boolean {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			var init:Character = cif.cast.getCharByName(initiatorName);
			var resp:GameObject = cif.getGameObjByName(responderName);
			// If we have matched any of our completion states, then we have reached the end of the quest
			for each (var qstate:QuestState in this.completionStates)
			{
				if (qstate.state.evaluate(init, resp))
				{
					this.complete = true;
					return true;
				}
			}
			
			return false;			
		}

		public function getPossibleOthers(initiator:GameObject, responder:GameObject):Vector.<GameObject> 
		{
			var viableOthers:Vector.<GameObject> = new Vector.<GameObject>();
			
			// in quests, the "initiator" = quest giver
			// so the responder is the initiator listed in the predicates
			// and other is the responder listed in the predicates
			// If quests go templated, this system should be revised. Right now responder is always listed in the predicates
			
			for each (var rule:Rule in this.intents)
			{
				for each (var pred:Predicate in rule.predicates)
				{
					var other:GameObject = CiFSingleton.getInstance().getGameObjByName(pred.second);
					var found:Boolean = false;
					for each (var obj:GameObject in viableOthers)
					{
						if (obj == other)
						{
							found = true;
							break;
						}
					}
					if (!found)
						viableOthers.push(CiFSingleton.getInstance().getGameObjByName(pred.second));
				}
			}
			return viableOthers;
		}

		public function getMostSpecificDialogue(statesMatched:Vector.<QuestState>, checkForEnding:Boolean, selectedScene:GrailScene=null): String
		{
			var resultStr:String = new String();
			var chosenState:QuestState = new QuestState();
			var ggm:GrailGM = GrailGM.getInstance();
			var qState:QuestState;
				
			// find the most specific state we matched. For now we're just choosing the one with the most number of predicates
			chosenState = statesMatched[0];
			if (statesMatched.length > 1)
			{
				for each (qState in statesMatched)
				{
					if (qState.state.predicates.length >= chosenState.state.predicates.length)
						chosenState = qState;
				}
			}
				
			// Find the correct piece of dialog - find the scene that matches our starting state id
			if (!selectedScene)
				selectedScene = new GrailScene;

			// if we're looking for ending states, need to find the set that matched startingState
			if (checkForEnding)
			{
				for each (var scene:GrailScene in chosenState.scenes)
				{
					if (scene.pairedStateID == this.chosenStart)
					{
						selectedScene = scene;
						break;
					}
				}
			}
			// if it's a starting state, there's only one scene associated with it
			else
			{
				selectedScene = chosenState.scenes[0];
				chosenStart = selectedScene.pairedStateID;
			}
			
			for each (var lod:LineOfDialogue in selectedScene.dialogue.lines)
			{
				resultStr += lod.initiatorLine + "\n";
				resultStr += lod.responderLine + "\n";
			}
			
			return resultStr;
		}

		public function getStart(initiator:Character, responder:GameObject):String
		{
			// Look through the starting states, find the most specific one and fire off the dialogue
			var statesMatched:Vector.<QuestState> = new Vector.<QuestState>();
			var resultStr:String = new String();
			var qState:QuestState;
			for each (qState in this.startingStates)
			{
				if (qState.state.evaluate(initiator, responder))
					statesMatched.push(qState);
			}
			
			if (statesMatched.length > 0)
			{
				resultStr = getMostSpecificDialogue(statesMatched, false);
			}
			else
			{
				return ("We didn't find a starting state that matched, Oops! Writers: Need to write a default quest start state");
			}
			
			return resultStr;
		}
		
		public function getEnding(initiatorName:String, responderName:String):String
		{
			var resultStr:String = new String();
			var cif:CiFSingleton = CiFSingleton.getInstance();
			
			var init:Character = cif.cast.getCharByName(initiatorName);
			var resp:GameObject = cif.getGameObjByName(responderName);
			
			var qState:QuestState;
			var selectedScene:GrailScene = new GrailScene;
			
			// Find which states we matched
			var statesMatched:Vector.<QuestState> = new Vector.<QuestState>();
			
			// make a list of states that we've matched from the list of completion states
			for each (qState in this.completionStates)
			{
				if (qState.state.evaluate(init, resp))
					statesMatched.push(qState);
			}
			
			if (statesMatched.length > 0)
			{
				var ggm:GrailGM = GrailGM.getInstance();
				
				this.used = true;
				if (ggm.questLib.questMixing > 0.3)
				{
					ggm.questLib.questMixing -= 2 / ggm.questLib.totalQuests;
					ggm.questLib.questConcentration += 2 / ggm.questLib.totalQuests;					
				}

				resultStr = getMostSpecificDialogue(statesMatched, true, selectedScene);
				
				// Fire off the consequences
				var initiator:GameObject;
				var responder:GameObject;
				
				for each (var pred:Predicate in selectedScene.socialChange.predicates)
				{
					initiator = cif.getGameObjByName(pred.first);
					responder = cif.getGameObjByName(pred.second);
					pred.valuation(initiator, responder, null, null);
					trace ("outcome: " + pred.toString() + "\n");
				}				
			}
			else
			{
				resultStr = "Quest completion state not found. Abort, Abort!";
			}
			return resultStr;
		}
		
		public function checkAllPreconditions(initiator:Character, cast:Cast, item:Item=null):Boolean {			
			// check giver preconditions
			for each (var char:Character in cast.characters)
			{
				if (initiator != char)
				{
					// TODO: Check for giver preconditions by checking if there is an instantiation available for the intiator
					if (!checkPreconditions(initiator, char, item))
					{
						return false;
					}
				}
				
			}
			
			return true;
		}
				
		public function checkPreconditions(initiator:Character, responder:Character, item:Item):Boolean {
			for each (var precondition:Rule in this.preconditions)
			{
				if (!precondition.evaluate(initiator, responder, item))
				{
					return false;
				}
			}
			return true;
		}


		
		/**
		 * Evaluates the intents of the quest with respect to 
		 * character/role mapping given in the arguments.
		 * 
		 * @param	initiator	The quest giver
		 * @return True if all intent rules evaluate to true. False if 
		 * they do not.
		 */
		public function checkIntents(initiator:Character):Boolean {
			for each (var intentRule:Rule in this.intents) {
				if (!intentRule.evaluate(initiator, null))
					return false;
			}
			return true;
		}

		/**
		 * Synonym setter for the game's name (backward compatability with
		 * GDC demo.
		 */
		public function get specificNameOfQuest():String {
			return this.name;
		}
		
		/**
		 * Synonym setter for the game's name (backward compatability with
		 * GDC demo.
		 */
		public function set specificNameOfQuest(n:String):void {
			this.name = n;
		}
			
		/**
		 * Finds an instantiation given an id. 
		 * @param	id	id of instantiation to find.
		 * @return	Instantiation with the parameterized id, null if not
		 * found.
		 */
/*		public function getInstantiationById(id:int):Instantiation {
			for each(var inst:Instantiation in this.instantiations) {
				if (id == inst.id)
					return inst;
			}
			Debug.debug(this, "getInstiationById() id not found. id=" + id);
			return null;
		}
*/		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		 // TODO: This needs to be fixed up, very badly!
		public function toXMLString():String {
			var returnstr:String = new String();
			var i:Number = 0;
			returnstr += "<Quest name=\"" + this.name + "\">\n";
	
	/*		returnstr += "<Intents>\n";
			for (i = 0; i < this.intents.length; ++i) {
				//returnstr += "   ";
				returnstr += this.intents[i].toXMLString();
				//returnstr += "\n";
			}
			returnstr += "</Intents>\n";
		*/	
			returnstr += "<Type>\n";
			returnstr += this.type;
			returnstr += "</Type>\n";
			returnstr += "<Preconditions>\n";
			for (i = 0; i < this.preconditions.length; ++i) {
				//returnstr += "   ";
				returnstr += this.preconditions[i].toXMLString();
				//returnstr += "\n";
			}
			returnstr += "</Preconditions>\n";
			
			returnstr += "</Quest>\n";
			return returnstr;
		}
		 
		public function toString():String {
			return this.name;
		}
	}
	
}