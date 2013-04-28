package grailgm 
{
	import CiF.BuddyNetwork;
	import CiF.Character;
	import CiF.CiFSingleton;
	import CiF.Effect;
	import CiF.FamilyBondNetwork;
	import CiF.GameObject;
	import CiF.GameScore;
	import CiF.Instantiation;
	import CiF.Item;
	import CiF.LineOfDialogue;
	import CiF.Predicate;
	import CiF.RomanceNetwork;
	import CiF.Rule;
	import CiF.RuleRecord;
	import CiF.SocialGame;
	import CiF.SocialGameContext;
	import CiF.SocialNetwork;
	import CiF.Status;
	import CiF.Trait;
	import CiF.TrustNetwork;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GrailGM 
	{
		private static var _instance:GrailGM = new GrailGM();
		private var cif:CiFSingleton = CiFSingleton.getInstance();
		public var questLib:QuestLib;
		public var plotPointPool:PlotPointPool;
		public var endings:Vector.<GameEnding>;
		public var world:World;
		public var curQuest:Quest; // current quest under consideration by the player
		public var buddyNetwork:BuddyNetwork;
		public var romanceNetwork:RomanceNetwork;
		public var trustNetwork:TrustNetwork;
		public var familyBondNetwork:FamilyBondNetwork;
		public var charList:Vector.<GrailCharacter> = new Vector.<GrailCharacter>();
		public var itemList:Vector.<GrailItem> = new Vector.<GrailItem>();
		public var knowledgeList:Vector.<GrailKnowledge> = new Vector.<GrailKnowledge>();
		public var moveNameList:Vector.<String> = new Vector.<String>();
		private var currentSocialMove:String; // Used when figuring out possible others for the move
		private var currentOther:String;
		public var gameWaitingForInput:Boolean = false;
		public var playerName:String = new String();
		public var curDialog:Instantiation;
		public var systemMessage:String = "";
		public var endGame:Boolean = false;
		public var plotPointFound:Boolean = false;
		public var plotPointUsedName:String = "";
		public var movesSincePlotPoint:Number = 0;
		public var lastCharSpoken:String = "";
		
		public function GrailGM() 
		{
			if (_instance != null) {
				throw new Error("GrailGM (Constructor): " + "Cast can only be accessed through GrailGM.getInstance()");
			}
			questLib = new QuestLib();
			plotPointPool = new PlotPointPool();
			world = new World();
			buddyNetwork = BuddyNetwork.getInstance();
			romanceNetwork = RomanceNetwork.getInstance();
			trustNetwork = TrustNetwork.getInstance();
			familyBondNetwork = FamilyBondNetwork.getInstance();
			endings = new Vector.<GameEnding>();
			
			initEndings();
		}
		
		public function clean(): void {
			if (this.questLib)
				this.questLib.clean();
			this.questLib = null;
			
			if (this.plotPointPool)
				this.plotPointPool.clean();
			this.plotPointPool = null;
			
			if (this.endings)
			{
				for each (var ending:GameEnding in this.endings)
				{
					ending.clean();
					ending = null;
				}
				this.endings = null;
			}
	
			if (this.world)
				this.world.clean();
			this.world = null;
			
			if (this.curQuest)
				this.curQuest.clean();
			this.curQuest = null;
			
			if (this.buddyNetwork)
				this.buddyNetwork.clean();
			this.buddyNetwork = null;
			
			if (this.romanceNetwork)
				this.romanceNetwork.clean();
			this.romanceNetwork = null;
			
			if (this.trustNetwork)
				this.trustNetwork.clean();
			this.trustNetwork = null;
			
			if (this.familyBondNetwork)
				this.familyBondNetwork.clean();
			this.familyBondNetwork = null;
			
			if (this.charList)
			{
				for each (var char:GrailCharacter in this.charList)
				{
					char.clean();
					char = null;
				}
				this.charList = null;
			}
			
			if (this.itemList)
			{
				for each (var item:GrailItem in this.itemList)
				{
					item.clean();
					item = null;
				}
				this.itemList = null;
			}
			
			if (this.knowledgeList)
			{
				for each (var know:GrailKnowledge in this.knowledgeList)
				{
					know.clean();
					know = null;
				}
				this.knowledgeList = null;
			}
			
			if (this.moveNameList)
			{
				for each (var str:String in moveNameList)
					str = null;
				this.moveNameList = null;
			}
			
			currentSocialMove = null;
			currentOther = null;
			playerName = null;
			
			if (this.curDialog)
				this.curDialog.clean();
			this.curDialog = null;
			
			systemMessage = null;
			plotPointUsedName = null;
		}
		
		// be able to reset the grailGM
		public function reset(): void
		{
			clean();
			questLib = new QuestLib();
			plotPointPool = new PlotPointPool();
			world = new World();
			buddyNetwork = BuddyNetwork.getInstance();
			romanceNetwork = RomanceNetwork.getInstance();
			trustNetwork = TrustNetwork.getInstance();
			familyBondNetwork = FamilyBondNetwork.getInstance();
			endings = new Vector.<GameEnding>();

			charList = new Vector.<GrailCharacter>();
			itemList = new Vector.<GrailItem>();
			knowledgeList = new Vector.<GrailKnowledge>();
			moveNameList = new Vector.<String>();
			currentSocialMove = "";
			currentOther = "";
			gameWaitingForInput = false;
			playerName = "";
			curDialog = null;
			systemMessage = "";
			endGame = false;
			plotPointFound = false;
			plotPointUsedName = "";
			curQuest = null;
			movesSincePlotPoint = 0;
			lastCharSpoken = "";
			
			cif.reset();
			
			initEndings();
		}
		
		// Set up the social moves for the game
		public function initActions():void
		{
			trace("Games loaded: " + cif.socialGamesLib.games.length);
			//cif.formIntentForAll();
			for each (var game:SocialGame in this.cif.socialGamesLib.games)
			{
				moveNameList.push(game.name);
			}
			this.cif.prepareLocutions();	
		}
		
		// Set up plot points for the game
		public function initPlotPoints(): void
		{
			this.plotPointPool.updatePossible();
			this.plotPointPool.updateActive();
		}
		
		public function getCharacterByName(name:String):GrailCharacter
		{
			for each (var char:GrailCharacter in this.charList)
			{
				if (char.cifCharacter.name.toLowerCase() == name.toLowerCase())
					return char;
			}
			return null;
		}
		
		public function getItemByName(name:String):GrailItem
		{
			for each (var item:GrailItem in this.itemList)
			{
				if (item.cifItem.name.toLowerCase() == name.toLowerCase())
					return item;
			}
			return null;
		}
		
		public function getKnowledgeByName(name:String):GrailKnowledge
		{
			for each (var knowledge:GrailKnowledge in this.knowledgeList)
			{
				if (knowledge.cifKnowledge && knowledge.cifKnowledge.name.toLowerCase() == name.toLowerCase())
					return knowledge;
			}
			
			return null;
		}
		
		public function getPlotPointByID(id:Number):PlotPoint
		{
			for each (var plotPoint:PlotPoint in this.plotPointPool.plotPoints)
			{
				if (plotPoint.id == id)
					return plotPoint;
			}
			
			return null;
		}
		
		public function getPlotPointByName(name:String):PlotPoint
		{
			for each (var plotPoint:PlotPoint in this.plotPointPool.plotPoints)
			{
				if (plotPoint.name == name)
					return plotPoint;
			}
			return null;
		}
		
		public static function getInstance():GrailGM {
			return _instance;
		}

		public function realizeDialog(sg:SocialGame, context:SocialGameContext, initiator:GameObject, responder:GameObject, other:GameObject=null): Instantiation
		{
			var dialog:Instantiation = sg.getInstantiationById(sg.getEffectByID(context.effectID).instantiationID).realizeDialogue(initiator, responder, other);
			var parsedLine:Array;
			var tagRegEx:RegExp = /\$/; 
			var piece:String;
			var instNum:Number;
			
			for each (var lod:LineOfDialogue in dialog.lines)
			{
				var i:Number = dialog.lines.indexOf(lod);
				var pattern:RegExp = /player/gi;
				// replace "player" with player's name because CiF doesn't have access to the player's name, so it can't be done at that end, only at grailGMs end
				lod.initiatorLine = lod.initiatorLine.replace(pattern, playerName);
				lod.responderLine = lod.responderLine.replace(pattern, playerName);

				trace(lod.initiatorLine + ", " + lod.responderLine);
				parsedLine = lod.initiatorLine.split(tagRegEx);
				for each(piece in parsedLine) {
					this.plotPointPool.plotPointMixIn(initiator.name, responder.name, lod, i, piece, dialog);
				}
				parsedLine = lod.responderLine.split(tagRegEx);
				for each(piece in parsedLine) {
					this.plotPointPool.plotPointMixIn(initiator.name, responder.name, lod, i, piece, dialog);
				}
			}
			return dialog;
		}
		
		// functions for choosing social moves and quests and all
		private function randomMove():String
		{
			var randomNum:int = Math.floor(Math.random() * (moveNameList.length));
			return moveNameList[randomNum];
		}
/*		
		private function questAccept(e:TextEvent):void {
			dialogBox.defaultTextFormat = defaultTextFormat;
			questJournal.defaultTextFormat = defaultTextFormat;
			dialogBox.htmlText = "Quest " + e.text + "\nClick on a character to interact.";
			if (e.text == "accepted")
			{
				var textString:String = new String();
				textString = responderName + "'s quest\n";
				textString += gameState.curQuest.name + "\n";
				textString += gameState.curQuest.successState + "\n\n";
				questList.push(textString);
				gameState.numActiveQuests++;
				gameState.curQuest.questGiver = gameState.curCharacter;
			}
			questJournal.text = "Quest Journal\n\n";
			for each(var quest:String in questList)
			{
				questJournal.appendText(quest);
			}
			
			dialogBox.removeEventListener(TextEvent.LINK, questAccept);
		}
		
		
		private function roomChangeItemMove(e:MouseEvent):void {
			if (gameMap.changedRooms) {
				// Gather possible initiators other than the player
				gameMap.shareKnowsInRoom(player);
				cif.formIntentForAll();
				if (calculateItemMoveResponse()) {
					trace("Player moved rooms and someone has an item move scored > 0");
					// Make a responding item move
					dialogBox.htmlText = "A character in this room would like to speak with you!\n\n";
					respondingItemMove();
				}
				gameMap.changedRooms = false;
			}
		}
*/	
		// initiator is the person who is initiating the responding move, not the person who initiated the original move
		public function respondingMove(initiatorName:String, responderName:String,aiIsPlaying:Boolean):String
		{
			// pick the highest rated move based on the NPC that the player is talking to
			var sg:SocialGame;
			var context:SocialGameContext; 
			var gameScore:GameScore;
			var highestScores:Vector.<GameScore> = new Vector.<GameScore>();
			var grailInitiator:GrailCharacter = this.getCharacterByName(initiatorName);
			var initiator:Character = cif.cast.getCharByName(initiatorName);
			var responder:GameObject = cif.getGameObjByName(responderName);
			var resultString:String = new String();
			
			// Only allowing the player to have one quest at a time for now
			// TODO: Get quest stuff working the right way
			if (!this.curQuest)
			{
				trace("Picking a quest");
				// have to check every time since the social state can change every time
				this.questLib.updatePossible(initiator, cif.cast);
				this.questLib.updateActive(initiator, responder);
				
				var questList:Array = new Array();
					
				curQuest = questLib.getQuest(initiator);
				if (curQuest)
				{
					// Reset quest urge -- the NPC tried!
					cif.cast.getCharByName(initiatorName).resetUrge(Status.QUEST_TYPE_URGE);
					resultString += "QUEST: " + curQuest.getStart(initiator, responder) + "\n";
				}
			}
			// TODO: If we move to more than one quest, this logic will need to change
			else 
			{
				if (curQuest.checkForCompletion(initiatorName, responderName))
				{
					// quest is completed
					// Make appropriate ending happen
					var ending:String = curQuest.getEnding(initiatorName, responderName);
					resultString += "QUESTEND: " + ending + "\n";
					// reset to no curquest
					curQuest = null;
				}
			}
		
			cif.formIntentForSocialGames(initiator, responder);
			highestScores = initiator.prospectiveMemory.getHighestGameScoresTo(responderName, 4);
			trace(initiator.prospectiveMemory);
			for each (var gs:GameScore in highestScores) {
				trace("Possible highest score: " + gs + " at " + gs.score);		
			}
			gameScore = highestScores[0];
			highestScores.splice(0, 1);
			while (highestScores.length > 0 && grailInitiator.moveInHistory(gameScore.name))
			{
				gameScore = highestScores[0];
				highestScores.splice(0, 1);
			}	
			if (gameScore == null) throw new DefinitionError("GrailGM:responding move: gameScore is null");
			if (aiIsPlaying)
			{
				resultString += "highest game chosen is " + gameScore + " at " + gameScore.score + "\n";
			}
			trace("highest game chosen is " + gameScore + " at " + gameScore.score);
			
			sg = cif.socialGamesLib.getByName(gameScore.name);
			grailInitiator.addMove(sg.name);
			context = cif.playGame(sg, initiator, responder);
			
			// reset urges
			initiator.resetUrge(Status.CHARACTER_TYPE_URGE);
			if (sg.responderType == SocialGame.ITEM_TYPE || sg.otherType == SocialGame.ITEM_TYPE) {
					initiator.resetUrge(Status.ITEM_TYPE_URGE);
				}
			if (sg.responderType == SocialGame.KNOWLEDGE_TYPE || sg.otherType == SocialGame.KNOWLEDGE_TYPE) {
				initiator.resetUrge(Status.KNOWLEDGE_TYPE_URGE);
			}
			
			if (aiIsPlaying)
				resultString += initiatorName + " responds ---\n";
			else
				resultString += initiatorName + " responds ----------<br>";
			
			var displayName:String = responderName;

			if (responderName.toLowerCase() == "player")
				displayName = playerName;
				
			if (context.responderScore < 0) {
				if (!aiIsPlaying)
					resultString += displayName + " rejects " + sg.name + "<br>";
			}
			else {
				if (!aiIsPlaying)
					resultString += displayName + " accepts " + sg.name + "<br>";
			}
			
			this.curDialog = realizeDialog(sg, context, initiator, responder, cif.getGameObjByName(context.other));
			// Adds line breaks?
			for each (var lod:LineOfDialogue in curDialog.lines)
			{
				if (lod.initiatorLine != "") {
					if (!aiIsPlaying)
						resultString += lod.initiatorLine + "<br>";
				}
				if (lod.responderLine != "") {
					if (!aiIsPlaying)
						resultString += lod.responderLine + "<br>";
				}
			}
			
			movesSincePlotPoint++;
			// put in the output that a plot point has been found
			if (this.plotPointFound)
			{
				plotPointPool.updatePool();
				movesSincePlotPoint = 0;
				resultString += "PLOTPOINT: " + this.plotPointUsedName;
				if (aiIsPlaying)
					resultString += "\n";
				else
					resultString += "<br>";
					
		
				resultString += "ACTIVE-PLOTS: ";
				for each (var pp:PlotPoint in plotPointPool.activePlotPoints)
					resultString += pp.name + " ";
				resultString += "\n";

				this.plotPointFound = false;
				this.plotPointUsedName = "";
			}

			
			var r:RuleRecord;
			//trace("Are there any rule records?...");
			var tempStr:String = "";
			var rstar:Vector.<RuleRecord>;

			if (context.responderScore >= 0) {
				rstar = cif.getPredicateRelevance(sg, initiator, responder, cif.getGameObjByName(context.other), "responder", null, "positive");
				if (rstar && rstar.length)
				{
					trace (rstar[0].toNaturalString());
					tempStr = rstar[0].toNaturalString();
				}
			} else {
				rstar = cif.getPredicateRelevance(sg, initiator, responder, cif.getGameObjByName(context.other), "responder", null, "negative");
				if (rstar && rstar.length)
				{
					trace(rstar[0].toNaturalString());
					tempStr = rstar[0].toNaturalString();
				}
			}
			if (context.responderScore >= 0)
			{
				if (tempStr != "")
				{
					if (aiIsPlaying)
					{
						resultString += sg.name + " accepted by " + responderName + " because " + tempStr;
						if (context.other)
							resultString += " with " + context.other;
						resultString += "\n";
					}
					systemMessage += sg.name + " accepted by " + responderName + " because " + tempStr;
				}
				else
				{
					if (aiIsPlaying)
					{
						resultString += sg.name + " accepted by " + responderName;
						if (context.other)
							resultString += " with " + context.other + " by default";
						resultString += "\n";
					}
					systemMessage += sg.name + " accepted by " + responderName + " by default.";
				}
			}
			else
			{
				if (tempStr != "")
				{
					if (aiIsPlaying)
					{
						resultString += sg.name + " rejected by " + responderName + " because " + tempStr + "\n";
					}
					systemMessage += sg.name + " rejected by " + responderName + " because " + tempStr;
				}
				else
				{
					if (aiIsPlaying)
					{
						resultString += sg.name + " rejected by " + responderName + " by default.\n";
					}
					systemMessage += sg.name + " rejected by " + responderName + " by default.";
				}
			}
			
//			systemMessage += sg.getEffectByID(context.effectID).toString();
			cif.changeSocialState(context);
			handleItemMoveEffects(context);
			if (aiIsPlaying && context != null)
			{
				var effect:Effect = sg.getEffectByID(context.effectID);
				
				resultString += "\n" + effect.toString() + "\n";
				resultString += "Social State\n";
				for each (var pred:Predicate in effect.change.predicates)
				{
					var first:GameObject;
					var second:GameObject;

					if (pred.type == Predicate.NETWORK)
					{
						switch (pred.getPrimaryValue())
						{
							case "initiator":
								first = initiator;
								break;
							case "responder":
								first = responder;
								break;
							case "other":
								first = cif.getGameObjByName(context.other);
								break;
							default:
								break;
						}
						
						switch (pred.getSecondaryValue())
						{
							case "initiator":
								second = initiator;
								break;
							case "responder":
								second = responder;
								break;
							case "other":
								second = cif.getGameObjByName(context.other);
								break;
						}
						resultString += SocialNetwork.getNameFromType(pred.networkType) + ": ";
						resultString += first.name + "-->" + second.name + ": ";
						resultString += cif.getNetworkWeightByType(pred.networkType, first.networkID, second.networkID) + "\n";
					}
				}
			}
			if (!aiIsPlaying)
				resultString += "<br><a href =\"event:continue\">Continue...</A>";
				
			// if the game has ended, find and print an ending
			if (this.endGame)
			{
				resultString += "ENDING: " + this.findEnding(initiator, responder);
			}
			return resultString;
		}

		public function getDialogLine(isInitiator:Boolean, lineNumber:Number): String
		{
			var resultString:String = new String();
			
			if (isInitiator)
				resultString = this.curDialog.lines[lineNumber].initiatorLine;
			else
				resultString = this.curDialog.lines[lineNumber].responderLine;
				
			return resultString;
		}
		// Figure out if there is an NPC in the room that wants to play a social move with the player 
		// or any items in the room
		// -- Occurs after the player performs a social move, for now 
		public function respondingItemMove(player:GrailCharacter,aiIsPlaying:Boolean): String {
			var resultString:String = new String();
			var availableInitiators:Vector.<Character> = new Vector.<Character>();
			var availableResponders:Vector.<GameObject> = new Vector.<GameObject>();
			
			// Gather possible initiators other than the player
			for each (var char:GrailCharacter in world.locationList[world.curRoom].charactersInLocation) {
				if (char.name != "player") availableInitiators.push(char.cifCharacter);
			}
			// Player and room objects are available for responding to
			availableResponders.push(player.cifCharacter as GameObject);
			// NPCs access items through moves with the player
			for each (var roomItem:GrailItem in world.locationList[world.curRoom].itemsInLocation) {
				availableResponders.push(roomItem.cifItem as GameObject);
			}
			
			// Determine if there are any characters in the room who want to make a move on the player or available items
			var targetInit:Character;
			var targetResp:GameObject;
			var targetScore:GameScore;
			var gameScore:GameScore;
			var testGame:GameScore;
			var initiator:Character;
			var highestScores:Vector.<GameScore> = new Vector.<GameScore>();
			
			cif.formIntentForAll();
			for each (var initchar:Character in availableInitiators) {
				for each (var respchar:GameObject in availableResponders) {
					gameScore = null;
					initiator = cif.cast.getCharByName(initchar.name);
					highestScores = initiator.prospectiveMemory.getHighestGameScoresTo(respchar.name, cif.socialGamesLib.games.length);
					highestScores.reverse();
					//trace(initiator.prospectiveMemory);
					// Find only social moves that require item responders or item ToC's
					while (highestScores.length > 0 && gameScore == null) {
						testGame = highestScores.pop();
						var testMove:SocialGame = cif.socialGamesLib.getByName(testGame.name);
						if ((testMove.otherType == SocialGame.ITEM_TYPE ||
							testMove.responderType == SocialGame.ITEM_TYPE)
							&& testGame.score > 0){
							gameScore = testGame;
						}
					}
					//trace("highest game between " + initchar.name + " and " + respchar.name + " is " + gameScore.name + " with score " + gameScore.score);
					if (targetScore == null && gameScore != null) {
						targetScore = gameScore;
						targetInit = initchar;
						targetResp = respchar;
					} else if (gameScore != null && gameScore.score > targetScore.score) {
						targetScore = gameScore;
						targetInit = initchar;
						targetResp = respchar;
					}
				}
			}
			
			//trace("WINNER!: " + targetInit.name + " " + targetScore.name + " with " + targetResp.name + " and score " + targetScore.score);
			var sg:SocialGame;
			var context:SocialGameContext; 
			var respName:String;
			sg = cif.socialGamesLib.getByName(targetScore.name);
			context = cif.playGame(sg, targetInit, targetResp, null, null);
			
			if (aiIsPlaying)
			{
				resultString = targetInit.name + " responds ----------\n";
			}
			else
			{
				resultString = targetInit.name + " responds ----------<br>";
			}
			// Set name of responder -- could be player or item
			if (targetResp.name == "player") respName = playerName;
			else respName = targetResp.name;
			
			if (context.responderScore < 0)
			{
				if (aiIsPlaying)
				{
					resultString += respName + " rejects " + sg.name + "\n";
				}
				else
				{
					resultString += respName + " rejects " + sg.name + "<br>";
				}
			}
			else
			{
				if (aiIsPlaying)
				{
					resultString += respName + " accepts " + sg.name + "\n";
				}
				else
				{
					resultString += respName + " accepts " + sg.name + "<br>";
				}
			}
			
			curDialog = realizeDialog(sg, context, targetInit, targetResp, cif.getGameObjByName(context.other));
			
			for each (var lod:LineOfDialogue in curDialog.lines)
			{
				if (lod.initiatorLine != "") {
					if (aiIsPlaying)
					{
						resultString += lod.initiatorLine + "\n";
					}
					else
					{
						resultString += lod.initiatorLine + "<br>";
					}
				}
				if (lod.responderLine != "") {
					if (aiIsPlaying)
					{
						resultString += lod.responderLine + "\n";
					}
					else
					{
						resultString += lod.responderLine + "<br>";
					}
				}
			}
			
			movesSincePlotPoint++;
			// put in the output that a plot point has been found
			if (this.plotPointFound)
			{
				plotPointPool.updatePool();
				movesSincePlotPoint = 0;
				resultString += "PLOTPOINT: " + this.plotPointUsedName;
				if (aiIsPlaying)
					resultString += "\n";
				else
					resultString += "<br>";
					
				resultString += "ACTIVE-PLOTS: ";
				for each (var pp:PlotPoint in plotPointPool.activePlotPoints)
					resultString += pp.name + " ";
				resultString += "\n";

				this.plotPointFound = false;
				this.plotPointUsedName = "";
			}

			systemMessage += sg.getEffectByID(context.effectID).toString();
			
			trace(this, "CONTEXT!!!!!!!:\n" + context.toXMLString() + "\n");
			cif.changeSocialState(context);
			handleItemMoveEffects(context);

			resultString += "<br><a href =\"event:continue\">Continue...</A>";
			return resultString;
		}

		// (April)
		// Should only be called when speaking with a character (replaces event handling of moveChosen)
		// Allows the player to select what other objects to discuss, share, or talk about (characters, items, knowledge)
		public function offerOthers(moveName:String, initiatorName:String, responderName:String,aiIsPlaying:Boolean):String {
			var sg:SocialGame;
			var context:SocialGameContext;
			var resultString:String = new String();
			
			sg = cif.socialGamesLib.getByName(moveName);
				
			if (sg.requiresOther) {
				// Prep dialogue box
				if (!aiIsPlaying)
					resultString = "Choose what you would like to talk about in " + sg.name + ": \n";

				// Save the social move to be accessed by otherChosen later when sent to moveChosen()
				currentSocialMove = sg.name;
				var initiator:Character = cif.cast.getCharByName(initiatorName);
				var responder:GameObject = cif.getGameObjByName(responderName);
				// Find all the possible others (TO DO: WILL NEED TO BE UPDATED WITH SEEN/KNOW)
				for each (var obj:GameObject in sg.getPossibleOthers(initiator, responder)) {
					// Characters/Items should have been seen by the initiator (player) and know exist
					if (obj.hasStatus(Status.KNOWN_BY, initiator)) {
						if (aiIsPlaying)
							resultString += obj.name + "\n";
						else
							resultString += "<a href=\"event:" + obj.name + "\">" + obj.name + "</a><br/>\n";
					}
				}
				// waiting for player input
				this.gameWaitingForInput = true;
			}
			else { // Requires no other
				resultString += moveChosen(moveName, initiatorName, responderName, aiIsPlaying);
			}			
						
			return resultString;
		}	
		
		public function itemMoveSelected(moveName:String, initiatorName:String, responderName:String,aiIsPlaying:Boolean):String {
			var resultString:String = new String();

			currentSocialMove = moveName;
			
			if (cif.socialGamesLib.getByName(moveName).needsSecondOther) {
				resultString += offerEffects(moveName, initiatorName, responderName);
			} else {
				resultString += itemMoveChosen(moveName, initiatorName, responderName,aiIsPlaying);
			}
			return resultString;
		}
		// (April)
		// Only should be called after offerOthers()
		// e is the name of the other selected, sg name is held in currentSocialMove
		public function otherChosen(initiatorName:String, responderName:String, other:String,aiIsPlaying:Boolean):String {
			var resultString:String = new String();

			// Passes the other the player selected to moveChosen()
			// Does this move need to select an effect when handling people? (Giving Gift)
			if (cif.socialGamesLib.getByName(currentSocialMove).needsSecondOther) {
				currentOther = other;
				resultString = offerEffects(currentSocialMove, initiatorName, responderName, other);
			} else {
				resultString = moveChosen(currentSocialMove, initiatorName, responderName, aiIsPlaying,other);
			}
			
			
			return resultString;
		}
		
		// (April)
		// Should be called when the move requires choosing an effect (Give Gift, Give Romantic Gift, Use)
		// Allows the player to select what specific effect they want to enact with a move
		// otherChosen signals the use of this inside a character move (instead of an item)
		private function offerEffects(moveName:String, initiatorName:String, responderName:String, otherChosen:String = ""):String {
			var sg:SocialGame = cif.socialGamesLib.getByName(moveName);
			var context:SocialGameContext;
			var possibleOthers:Vector.<GameObject> = new Vector.<GameObject>();
			// assume true by this point -- the player isn't supposed to know
			var acceptGameIntent:Boolean = true;
			var effects:Vector.<Effect>;
			var initiator:Character = cif.cast.getCharByName(initiatorName);
			var responder:GameObject = cif.getGameObjByName(responderName);
			var resultString:String = new String();
			
			if (otherChosen != "") {
				// This is for NPC responders
				resultString = "Choose your intention for playing " + sg.name + " with " + otherChosen + ": \n";
				possibleOthers.push(cif.getGameObjByName(otherChosen))
				effects = cif.getAllSalientEffects(sg, acceptGameIntent, initiator, 
													responder, possibleOthers, cif.getAllGameObjs());
			
			} else {
				// This is for Items
				resultString = "Choose what you want to do with " + responderName + ": \n";
				// Use doesn't need any others, but why not...
				possibleOthers = cif.getAllGameObjs();
				effects = cif.getAllSalientEffects(sg, acceptGameIntent, initiator, 
													responder, possibleOthers, cif.getAllGameObjs());
			}
			
			for each (var eff:Effect in effects) {
				resultString += "<a href=\"event:" + eff.referenceAsNaturalLanguage + "\">" + eff.referenceAsNaturalLanguage + "</a>\n";
			}

			/*
			if (aiIsPlaying)
			{
				resultString += "\n" + sg.getEffectByID(context.effectID).toString() + "\n";
			}
			*/
			// need the player to give input on effect
			this.gameWaitingForInput = true;
			
			return resultString;
		}
	
		// (April)
		// Only should be called after offerOthers()
		// e is the effect.referenceAsNaturalLanguage
		public function effectChosen(initiatorName:String, responderName:String, effectString:String,aiIsPlaying:Boolean):String {
			var resultString:String = new String();
			var initiator:Character = cif.cast.getCharByName(initiatorName);
			var responder:GameObject = cif.getGameObjByName(responderName);

			// Passes the other and effect the player selected to moveChosen()
			if (cif.socialGamesLib.getByName(currentSocialMove).responderType == SocialGame.CHARACTER_TYPE){
				resultString = moveChosen(currentSocialMove, initiatorName, responderName,aiIsPlaying, currentOther, effectString);
			} else if (cif.socialGamesLib.getByName(currentSocialMove).responderType == SocialGame.ITEM_TYPE) {
				resultString = itemMoveChosen(currentSocialMove, initiatorName, responderName, aiIsPlaying,effectString);
			} else {
				trace("ERROR: Should not be able to click and interact with Knowledge social moves directly");
			}
			/*
			if (aiIsPlaying)
			{
				resultString += "\n" + sg.getEffectByID(context.effectID).toString() + "\n";
			}
			*/
			return resultString;
		}
		
		// (April)
		// Finds the effect that matches the string that the player clicked
		// Note that these strings aren't unique by necessity!
		private function findEffectByNaturalLanguageReference(sg:SocialGame, ref:String):Effect {
			for each (var eff:Effect in sg.effects) {
				if (eff.referenceAsNaturalLanguage == ref) return eff;
			}
			return null;
		}

		public function completeQuest(initiatorName:String, responderName:String):String
		{
			var responseString:String = new String();
			
			// figures out correct ending, deals with effects and outputs the correct instantiation
			responseString = curQuest.getEnding(initiatorName, responderName);
			
			responseString += "<a href =\"event:continue\">Continue...</A>";
			curQuest = null;
			return responseString;
		}
		
		public function moveChosen(sgName:String, initiatorName:String, responderName:String, aiIsPlaying:Boolean,other:String = "", effectRef:String = ""):String
		{
			var sg:SocialGame;
			var context:SocialGameContext; 
			var resultString:String = new String();
			var grailInitiator:GrailCharacter = this.getCharacterByName(initiatorName);
			var initiator:Character = grailInitiator.cifCharacter;
			var responder:Character = cif.cast.getCharByName(responderName);
			
			// If chosen move is completing a quest, need to remove it from the quest journal
			// and calculate the quest effects
			// TODO: Move quest effects to grailGM?
/*			if (sgName == "Complete Quest")
			{
				questList.pop();
				if (gameState.curQuest.complete == Quest.SUCCESS)
				{
					dialogBox.htmlText = gameState.curQuest.successText;
					for each (var successEffect:Effect in gameState.curQuest.successEffects)
					{
						dialogBox.htmlText += "\n" + successEffect;
						successEffect.valuation(gameState.curQuest.questGiver);
					}
				}
				else
				{
					dialogBox.htmlText = gameState.curQuest.failureText;
					for each (var failureEffect:Effect in gameState.curQuest.failureEffects)
					{
						dialogBox.htmlText += "\n" + failureEffect;
						failureEffect.valuation(gameState.curQuest.questGiver);
					}
				}	
				// clear out current quests, update stats text to reflect effects of finished quest
				gameState.curQuest = new Quest();
				gameState.numActiveQuests--;
				updateStatsText();
				// Also reset quest urge
				cif.cast.getCharByName(responderName).resetUrge(Status.QUEST_TYPE_URGE);
				
				if (questList.length == 0)
				{
					questJournal.text = "Quest Journal\n\nNo current quests";
				}
				else
				{
					questJournal.text = "Quest Journal\n\n";
					for each (var quest:String in questList)
					{
						questJournal.appendText(quest);
					}
				}
			 }
			else
			{
*/				sg = cif.socialGamesLib.getByName(sgName);
				
				// track what move the player chose
				grailInitiator.addMove(sgName);
				var possibleOther:Vector.<GameObject> = new Vector.<GameObject>();
				possibleOther.push(cif.getGameObjByName(other));
				
				var effect:Effect;
				if (effectRef != "")
					effect = findEffectByNaturalLanguageReference(sg, effectRef);

				context = cif.playGame(sg, initiator, responder, null, possibleOther, cif.getAllGameObjs(), effect);

				lastCharSpoken = responder.name;
				
				if (context.responderScore < 0) {
					if (aiIsPlaying)
					{
						resultString = responder.name + " rejects " + sg.name + "\n";
					}
					else
					{
						resultString = responder.name + " rejects " + sg.name + "<br>";
					}
				}
				else {
					if (aiIsPlaying)
					{
						resultString = responder.name + " accepts " + sg.name + "\n";
					}
					else
					{
						resultString = responder.name + " accepts " + sg.name + "<br>";
					}
				}
				
				// reset urges
				responder.resetUrge(Status.CHARACTER_TYPE_URGE);
				if (sg.responderType == SocialGame.ITEM_TYPE || sg.otherType == SocialGame.ITEM_TYPE) {
						responder.resetUrge(Status.ITEM_TYPE_URGE);
					}
				if (sg.responderType == SocialGame.KNOWLEDGE_TYPE || sg.otherType == SocialGame.KNOWLEDGE_TYPE) {
					responder.resetUrge(Status.KNOWLEDGE_TYPE_URGE);
				}
				
				// figure out what instantiation will be shown to the player
				// displayed as lines of dialog
				curDialog = realizeDialog(sg, context, initiator, responder, cif.getGameObjByName(context.other));
				var initiatorDisplayName:String = initiatorName;
				var responderDisplayName:String = responderName;
				
				if (initiatorName.toLowerCase() == "player")
					initiatorDisplayName = playerName;
				else if (responderName.toLowerCase() == "player")
					responderDisplayName = playerName;

				for each (var lod:LineOfDialogue in curDialog.lines)
				{
					if (lod.initiatorLine != "") {
						if (aiIsPlaying)
						{
							resultString += lod.initiatorLine + "\n";
						}
						else
						{
							resultString += lod.initiatorLine + "<br>";
						}
					}
					if (lod.responderLine != "") {
						if (aiIsPlaying)
						{
							resultString += lod.responderLine + "\n";
						}
						else
						{
							resultString += lod.responderLine + "<br>";
						}
					}
				}

				movesSincePlotPoint++;
				// put in the output that a plot point has been found
				if (this.plotPointFound)
				{
					plotPointPool.updatePool();
					movesSincePlotPoint = 0;
					resultString += "PLOTPOINT: " + this.plotPointUsedName;
					if (aiIsPlaying)
						resultString += "\n";
					else
						resultString += "<br>";
						
					resultString += "ACTIVE-PLOTS: ";
					for each (var pp:PlotPoint in plotPointPool.activePlotPoints)
						resultString += pp.name + " / ";
					resultString += "\n";

					this.plotPointFound = false;
					this.plotPointUsedName = "";
				}

				var r:RuleRecord;
				//trace("Are there any rule records?...");
				var tempStr:String = "";
				var rstar:Vector.<RuleRecord>;
				
				if (context.responderScore >= 0) {
					rstar = cif.getPredicateRelevance(sg, initiator, responder, cif.getGameObjByName(context.other), "responder", null, "positive");
					if (rstar && rstar.length)
					{
						trace (rstar[0].toNaturalString());
						tempStr = rstar[0].toNaturalString();
					}
/*					for each (r in rstar) {
						trace(r.toLongString());
						tempStr += r.toLongString() + "\n";
					}*/
				} else {
					rstar = cif.getPredicateRelevance(sg, initiator, responder, cif.getGameObjByName(context.other), "responder", null, "negative");
					if (rstar && rstar.length)
					{
						trace(rstar[0].toNaturalString());
						tempStr = rstar[0].toNaturalString();
					}
/*					for each (r in rstar) {
						trace(r.toLongString());
						tempStr += r.toLongString() + "\n";
					}*/
				}
				if (context.responderScore >= 0)
				{
					if (tempStr != "")
					{
						if (aiIsPlaying)
						{
							resultString += sg.name + " accepted by " + responderName + " because " + tempStr + "\n";
						}
						systemMessage += sg.name + " accepted by " + responderName + " because " + tempStr;
					}
					else
					{
						if (aiIsPlaying)
						{
							resultString += sg.name + " accepted by " + responderName + " by default.\n";
						}
						systemMessage += sg.name + " accepted by " + responderName + " by default.";
					}
				}
				else
				{
					if (tempStr != "")
					{
						if (aiIsPlaying)
						{
							resultString += sg.name + " rejected by " + responderName + " because " + tempStr + "\n";
						}
						systemMessage += sg.name + " rejected by " + responderName + " because " + tempStr;
					}
					else
					{
						if (aiIsPlaying)
						{
							resultString += sg.name + " rejected by " + responderName + " by default.\n";
						}
						systemMessage += sg.name + " rejected by " + responderName + " by default.";
					}
				}
				
				trace(this, "CONTEXT!!!!!!!:\n" + context.toXMLString() + "\n");

//				systemMessage += sg.getEffectByID(context.effectID).toString() + "<br>";

				cif.changeSocialState(context);
				handleItemMoveEffects(context);

				// no longer waiting for player input to finish the social move
				gameWaitingForInput = false;
				if (aiIsPlaying && context != null)
				{
					var sgeffect:Effect = sg.getEffectByID(context.effectID);
					
					resultString += "\n" + sgeffect.toString() + "\n";
					resultString += "Social State\n";
					for each (var pred:Predicate in sgeffect.change.predicates)
					{
						var first:GameObject;
						var second:GameObject;

						if (pred.type == Predicate.NETWORK)
						{
							switch (pred.getPrimaryValue())
							{
								case "initiator":
									first = initiator;
									break;
								case "responder":
									first = responder;
									break;
								case "other":
									first = cif.getGameObjByName(context.other);
									break;
								default:
									break;
							}
							
							switch (pred.getSecondaryValue())
							{
								case "initiator":
									second = initiator;
									break;
								case "responder":
									second = responder;
									break;
								case "other":
									second = cif.getGameObjByName(context.other);
									break;
							}
							resultString += SocialNetwork.getNameFromType(pred.networkType) + ": ";
							resultString += first.name + "-->" + second.name + ": ";
							resultString += cif.getNetworkWeightByType(pred.networkType, first.networkID, second.networkID) + "\n";
						}
					}
				}
				return resultString;
			}

		
		private function itemMoveChosen(sgName:String, initiatorName:String, responderName:String, aiIsPlaying:Boolean,effectRef:String = ""):String
		{
			var sg:SocialGame;
			var context:SocialGameContext; 
			var effect:Effect;
			var resultString:String = new String();
			var initiator:Character = cif.cast.getCharByName(initiatorName);
			var responder:Item = cif.itemList.getItemByName(responderName);
			
			sg = cif.socialGamesLib.getByName(sgName);
			effect = findEffectByNaturalLanguageReference(sg, effectRef);
			
			context = cif.playGame(sg, initiator, responder, null, null, cif.getCharGameObjs(), effect);
			//Debug.debug(this, "CONTEXT1!!!!!!!:\n" + context.toXMLString() + "\n");
			if (context.responderScore < 0) {
				if (aiIsPlaying)
				{
					resultString = responderName + " rejects " + sg.name + "\n";
					
				}
				else
				{
					resultString = responderName + " rejects " + sg.name + "<br>";
				}
			}
			else {
				if (aiIsPlaying)
				{
					resultString = responderName + " accepts " + sg.name + "\n";
				}
				else
				{
					resultString = responderName + " accepts " + sg.name + "<br>";
				}
			}
			
			handleItemMoveEffects(context);
			
			// figure out what instantiation will be shown to the player
			// displayed as lines of dialog
			curDialog = realizeDialog(sg, context, initiator, responder as GameObject);
			var initiatorDisplayName:String = initiatorName;
			var responderDisplayName:String = responderName;
			
			if (initiatorName.toLowerCase() == "player")
				initiatorDisplayName = playerName;
			else if (responderName.toLowerCase() == "player")
				responderDisplayName = playerName;
				
			for each (var lod:LineOfDialogue in curDialog.lines)
			{
				if (lod.initiatorLine != "") {
					if (aiIsPlaying)
					{
						resultString += lod.initiatorLine + "\n";
					}
					else
					{
						resultString += lod.initiatorLine + "<br>";
					}
					
				}
				if (lod.responderLine != "") {
					if (aiIsPlaying)
					{
						resultString += lod.responderLine + "\n";
					}
					else
					{
						resultString += lod.responderLine + "<br>";
					}
					
				}
			}

			movesSincePlotPoint++;
			// put in the output that a plot point has been found
			if (this.plotPointFound)
			{
				plotPointPool.updatePool();
				movesSincePlotPoint = 0;
				resultString += "PLOTPOINT: " + this.plotPointUsedName;
				if (aiIsPlaying)
					resultString += "\n";
				else
					resultString += "<br>";
					
				resultString += "ACTIVE-PLOTS: ";
				for each (var pp:PlotPoint in plotPointPool.activePlotPoints)
					resultString += pp.name + " ";
				resultString += "\n";

				this.plotPointFound = false;
				this.plotPointUsedName = "";
			}

			systemMessage += sg.getEffectByID(context.effectID).toString();
			
			var r:RuleRecord;
			//trace("Are there any rule records?...");
			if (context.responderScore >= 0) {
				for each (r in (cif.getPredicateRelevance(sg, initiator, responder, 
											   cif.getGameObjByName(context.other), "responder", null, "positive"))) {
					//trace(r);
				}
			} else {
				for each (r in (cif.getPredicateRelevance(sg, initiator, responder, 
											   cif.getGameObjByName(context.other), "responder", null, "negative"))) {
					//trace(r);
				}
			}
			
			trace(this, "CONTEXT!!!!!!!:\n" + context.toXMLString() + "\n");
			cif.changeSocialState(context);
			
			resultString += "<br><a href =\"event:continue\">Continue...</A>";
			
			// no longer waiting for player input to finish the social move
			gameWaitingForInput = false;
			
			return resultString;
		}
		
		// Figure out if there is an NPC in the room that wants to play a social move with the player 
		// or any items in the room
		// -- Occurs after the player performs a social move, for now 
		public function calculateItemMoveResponse(player:GrailCharacter ): Boolean {
			var availableInitiators:Vector.<Character> = new Vector.<Character>();
			var availableResponders:Vector.<GameObject> = new Vector.<GameObject>();
			
			// Gather possible initiators other than the player
			for each (var char:GrailCharacter in world.locationList[world.curRoom].charactersInLocation) {
				if (char.name != "player") 
					availableInitiators.push(char.cifCharacter);
			}

			// Player and room objects are available for responding to
			availableResponders.push(player.cifCharacter as GameObject);
			// NPCs access items through moves with the player
			for each (var roomItem:GrailItem in world.locationList[world.curRoom].itemsInLocation) {
				availableResponders.push(roomItem.cifItem as GameObject);
			}
			
			// TESTING
			var initiators:String = "Inits: ";
			for each (var init:Character in availableInitiators) {
				initiators += init.name + ", ";
			}
			trace(initiators);
			var responders:String = "Resps: ";
			for each (var resp:GameObject in availableResponders) {
				responders += resp.name + ", ";
			}
			trace(responders);
			
			// Determine if there are any characters in the room who want to make a move on the player or available items
			var targetInit:Character;
			var targetResp:GameObject;
			var targetScore:GameScore;
			var gameScore:GameScore;
			var testGame:GameScore;
			var initiator:Character;
			var highestScores:Vector.<GameScore> = new Vector.<GameScore>();
			for each (var initchar:Character in availableInitiators) {
				for each (var respchar:GameObject in availableResponders) {
					gameScore = null;
					initiator = cif.cast.getCharByName(initchar.name);
					highestScores = initiator.prospectiveMemory.getHighestGameScoresTo(respchar.name, cif.socialGamesLib.games.length);
					highestScores.reverse();
					//trace(initiator.prospectiveMemory);
					// Find only social moves that require item responders or item ToC's
					while (highestScores.length > 0 && gameScore == null) {
						testGame = highestScores.pop();
						var testMove:SocialGame = cif.socialGamesLib.getByName(testGame.name);
						if ((testMove.otherType == SocialGame.ITEM_TYPE ||
							testMove.responderType == SocialGame.ITEM_TYPE)
							&& testGame.score > 0){
							gameScore = testGame;
						}
					}
					//trace("highest game between " + initchar.name + " and " + respchar.name + " is " + gameScore.name + " with score " + gameScore.score);
					if (targetScore == null && gameScore != null) {
						targetScore = gameScore;
						targetInit = initchar;
						targetResp = respchar;
					} else if (gameScore != null && gameScore.score > targetScore.score) {
						targetScore = gameScore;
						targetInit = initchar;
						targetResp = respchar;
					}
				}
			}
			// Make sure a game exists at all...
			if (targetInit != null) {
				trace("WINNER!: " + targetInit.name + " " + targetScore.name + " with " + targetResp.name + " and score " + targetScore.score);
				return true;
			}
			return false;
		}
		
		public function valuateItemPredicates(pred:Predicate, init:GameObject, resp:GameObject=null, other:GameObject = null ): void
		{
			// Deal with the CiF part of it
			pred.valuation(init, resp, other);
			
			// Deal with the grailGM/game part of it
			if (pred.type == Predicate.STATUS && (pred.status == Status.HELD_BY || pred.status == Status.IS_HOLDING))
			{
				if (!pred.negated)
					addItem(init, resp, other);
				else
					removeItem(init, resp, other);
			}
		}
		
		public function addItem(init:GameObject, resp:GameObject, other:GameObject): void
		{
			
		}
		
		public function removeItem(init:GameObject, resp:GameObject, other:GameObject): void
		{
			
		}
		
		// Should be called in any situation where social moves including items will be played
		// This includes moves with items (Pick up, Put down)
		// AND moves with characters concerning items (Give item)
		// 
		// Please note the order of predicates in the effect rules matters for the game state to change correctly
		public function handleItemMoveEffects(context:SocialGameContext):void {
			var init:GameObject = cif.cast.getCharByName(context.initiator);
			var resp:GameObject = cif.getGameObjByName(context.responder);
			var other:GameObject = cif.getGameObjByName(context.other);
			
			var rule:Rule = context.getChange();
			var item:GrailItem = this.getItemByName(resp.name);
			var char2:GrailCharacter = this.getCharacterByName(resp.name);
			var char:GrailCharacter = this.getCharacterByName(init.name);

			for each (var p:Predicate in rule.predicates) {
				
				// TODO: This stuff should all be taken care of in valuation, not done by hand here 
				
				// NOTE: The order of these two checks matters in the document!:
				// In giving an item, the first player must drop it, then the second will pick it up.  
				
				// If the post-effects of the move indicate the item should not be held, then drop it
				// Note: This assumes that in the effect preconditions that the "Held By" status was TRUE
				// and that the item was in the initiator's game inventory before the move
				// ALSO note that different cases for NPCs may be required
				if (p.type == Predicate.STATUS)
				{
					if (p.status == Status.HELD_BY || p.status == Status.IS_HOLDING)
					{
						// If the responder is an item
						if (p.first == "responder")
						{
							if (p.second == "initiator" &&
							init.type == GameObject.TYPE_CHARACTER &&
							resp.type == GameObject.TYPE_ITEM)
							{
								if (p.negated) // effect: initiator should no longer be holding the responder (item)
								{
									char.inventory.removeItem(char, item);
									world.addItemToRoom(item, world.curRoom);
								}
								else // effect: initiator should be holding the responder (item)
								{
									world.removeItemFromRoom(item, world.curRoom);
									char.inventory.addItem(char, item);
								}
										
							}
						}
						else if (p.first == "other" && other)
						{
							item = this.getItemByName(other.name);
							
							if (p.second == "initiator" &&
								init.type == GameObject.TYPE_CHARACTER &&
								other.type == GameObject.TYPE_ITEM)
							{
								if (p.negated)
								{
									char.inventory.removeItem(char, item); // effect: initiator drops the item
									if (!item.isHeld())
										world.addItemToRoom(item, world.curRoom);
								}
								else
								{
									char.inventory.addItem(char, item); // effect: initiator picks up the item
									world.removeItemFromRoom(item, world.curRoom);								
								}
							}
							else if (p.second == "responder" &&
									init.type == GameObject.TYPE_CHARACTER &&
									other.type == GameObject.TYPE_ITEM)
							{
								if (p.negated)
								{
									char2.inventory.removeItem(char2, item); // effect: responder drops the item
									if (!item.isHeld())
										world.addItemToRoom(item, world.curRoom);								
								}
								else
								{
									char2.inventory.addItem(char2, item); // effect: responder picks up the item
									world.removeItemFromRoom(item, world.curRoom);								
								}
							}
						}
					}
				}
			}
		}
		
		public function intentNLG(intent:Rule):String {
			var str:String = "";
			//str += intent.name + " " + intent.toString + " " + intent.predicates[0].name + " " + intent.predicates[0].type;
			str += intent.predicates[0].toIntentNLGString();
			//trace(str);
			return str;
		}
		
		public function printMoves(initiatorName:String, responderName:String, numSocialMoves:Number, showIntent:Boolean,aiIsPlaying:Boolean = false, moveList:Vector.<String> = null):String
		{
			var resultString:String = new String();
			//trace("I should be printingMoves right now!");
			moveNameList = new Vector.<String>();
			var move:String;
			var grailInitiator:GrailCharacter = this.getCharacterByName(initiatorName);
			var initiator:Character = grailInitiator.cifCharacter;
			var responder:GameObject = cif.getGameObjByName(responderName);
			var highestScores:Vector.<GameScore>;
			var gameScore:GameScore;
			
			var start:int = getTimer();
			cif.clearProspectiveMemory();
			cif.formIntentForSocialGames(initiator, responder);
			highestScores = initiator.prospectiveMemory.getHighestGameScoresTo(responderName, numSocialMoves + grailInitiator.lastMoves.length);

			// If quest is complete and we're talking to the quest completer, give the player the option of completing the quest
			if (this.curQuest && this.curQuest.checkForCompletion(initiatorName, responderName) && 
				initiatorName.toLowerCase() == "player" && responderName.toLowerCase() == curQuest.questCompleter.toLowerCase()) {
					numSocialMoves--;
					resultString += "<a href=\"event:Complete Quest\">Complete Quest</a>\n";
			}

			if (highestScores.length)
			{
				do {
					gameScore = highestScores[0];
					if (gameScore == null) throw new DefinitionError("GrailGM:responding move: gameScore is null");
					highestScores.splice(0, 1);
					trace("highest game chosen is " + gameScore + " at " + gameScore.score);
			
					move = gameScore.name;

					if (!grailInitiator.moveInHistory(move))
					{
						if (showIntent){
							if (aiIsPlaying)
								moveList.push(move);

							resultString += "<a href=\"event:" + move + "\">" + move + " " + intentNLG(cif.socialGamesLib.getByName(move).intents[0]) + "</a>\n";
						} else {
							if (aiIsPlaying)
								moveList.push(move);

							resultString += "<a href=\"event:" + move + "\">" + move + "</a>\n";
						}
						
						// Calibrate the social move amount based on the one that's first given and the complete quest move
						numSocialMoves--;
					}
					
				} while (numSocialMoves > 0 && highestScores.length > 0);
			}
			
			if (resultString.length == 0)
			{
				// TODO: Need to figure out the logic so that the player doesn't get stuck in the middle of a move
				resultString += "No moves available\n";
			}
			trace("print moves took " + (getTimer() - start) + "ms");
			return resultString;
		}
		
		public function printItemMoves(initiatorName:String, responderName:String, numSocialMoves:Number, showIntent:Boolean):String
		{
			var resultString:String = new String();
			moveNameList = new Vector.<String>();
			for each (var game:SocialGame in cif.socialGamesLib.games)
			{
				trace("found game for item: " + game.name);
				if (game.checkPreconditionsVariableOther(cif.cast.getCharByName(initiatorName), cif.itemList.getItemByName(responderName), cif.getAllGameObjs())){
					moveNameList.push(game.name);
				}
			}

			for each (var strgame:String in moveNameList) {
				if (showIntent){
					resultString += "<a href=\"event:" + strgame + "\">" + strgame + " " + intentNLG(cif.socialGamesLib.getByName(strgame).intents[0]) + "</a>\n";
				} else {
					resultString += "<a href=\"event:" + strgame + "\">" + strgame + "</a>\n";
				}
			}
			return resultString;
		}

		public function getNetworkStats(aiIsPlaying:Boolean):String
		{
			var statsText:String = new String();
			var player:Character = cif.cast.getCharByName("player");
			
			for each (var char:Character in cif.cast.characters)
			{
				// TODO: Why is this a switch statement? Just make sure it's not the player and that it's a character, and we're good.
				switch(char.name.toLowerCase())
				{
					case "colonel":
						if(!aiIsPlaying){
							statsText += "Colonel:\nBuddy:";
							statsText += cif.buddyNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.buddyNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Trust:";
							statsText += cif.trustNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.trustNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Romance:";
							statsText += cif.romanceNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.romanceNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Family:";
							statsText += cif.familyBondNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.familyBondNetwork.getWeight(char.networkID, player.networkID) + "<br><br>";
						}else {
							statsText += "Colonel:\nBuddy:";
							statsText += cif.buddyNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.buddyNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Trust:";
							statsText += cif.trustNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.trustNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Romance:";
							statsText += cif.romanceNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.romanceNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Family:";
							statsText += cif.familyBondNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.familyBondNetwork.getWeight(char.networkID, player.networkID) + "\n\n";
						}
						break;
					case "violet":
						if(!aiIsPlaying){
							statsText += "Violet:<br>Buddy:";
							statsText += cif.buddyNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.buddyNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Trust:";
							statsText += cif.trustNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.trustNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Romance:";
							statsText += cif.romanceNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.romanceNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Family:";
							statsText += cif.familyBondNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.familyBondNetwork.getWeight(char.networkID, player.networkID) + "<br><br>";
						}else {
							statsText += "Violet:\nBuddy:";
							statsText += cif.buddyNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.buddyNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Trust:";
							statsText += cif.trustNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.trustNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Romance:";
							statsText += cif.romanceNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.romanceNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Family:";
							statsText += cif.familyBondNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.familyBondNetwork.getWeight(char.networkID, player.networkID) + "\n\n";

						}
						break;
					case "james":
						if(!aiIsPlaying){
							statsText += "James:<br>Buddy:";
							statsText += cif.buddyNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.buddyNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Trust:";
							statsText += cif.trustNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.trustNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Romance:";
							statsText += cif.romanceNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.romanceNetwork.getWeight(char.networkID, player.networkID) + "<br>";
							statsText += "Family:";
							statsText += cif.familyBondNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.familyBondNetwork.getWeight(char.networkID, player.networkID) + "<br><br>";
						}else {
							statsText += "James:\nBuddy:";
							statsText += cif.buddyNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.buddyNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Trust:";
							statsText += cif.trustNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.trustNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Romance:";
							statsText += cif.romanceNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.romanceNetwork.getWeight(char.networkID, player.networkID) + "\n";
							statsText += "Family:";
							statsText += cif.familyBondNetwork.getWeight(player.networkID, char.networkID) + ", " + cif.familyBondNetwork.getWeight(char.networkID, player.networkID) + "\n\n";
						}
						break;
					default:
						break;
				}
			}
			return statsText;
		}
		
		public function findEnding(initiator:GameObject, responder:GameObject):String
		{
			var resultString:String = new String;
			
			for each (var ending:GameEnding in this.endings)
			{
				// do we meet the requirements for this ending?
				if (ending.state.evaluate(initiator, responder))
				{
					resultString += ending.endingText + "\n";
				}
			}
			
			if (!resultString.length)
			{
				var playerID:Number = cif.getGameObjByName("player").networkID;
				var buddies:Vector.<Number> = new Vector.<Number>();
				var romances:Vector.<Number> = new Vector.<Number>();
				var trusts:Vector.<Number> = new Vector.<Number>();
				var family:Vector.<Number> = new Vector.<Number>();
				var networkID:Number;
				var networks:Vector.<Number> = new Vector.<Number>(cif.cast.characters.length);
				
				// is the player close to any of the characters?
				buddies = buddyNetwork.getReverseRelationshipsAboveThreshold(playerID, 75);
				romances = romanceNetwork.getReverseRelationshipsAboveThreshold(playerID, 75);
				trusts = trustNetwork.getReverseRelationshipsAboveThreshold(playerID, 75);
				family = familyBondNetwork.getReverseRelationshipsAboveThreshold(playerID, 75);
				
				if (!buddies.length && !romances.length && !trusts.length)
				{
					// No ending met, that means bad ending!
					resultString = "Sadly having made no friends in the manor the player is sacrificed to raise Violet's mother. ";
					resultString += "Unfortunately since the player dies they don't even get to see if the sacrifice worked.\n";
				}
				else
				{
					// find who the player is closest to
					for each (networkID in buddies)
					{
						networks[networkID]++;
					}
					for each (networkID in romances)
					{
						networks[networkID]++;
					}
					for each (networkID in trusts)
					{
						networks[networkID]++;
					}
					for each (networkID in family)
					{
						networks[networkID]++;
					}
					
					// find out which networkID had the highest number of matches (and therefore the most number of networks above 75)
					var max:Number = -1;
					var networkValue:Number;
					
					for each (networkValue in networks)
					{
						if (networkValue > max)
							max = networkValue;
					}
					
					var chars:String = "";
					
					// which chars match this amount?
					for (var i:Number = 0; i < networks.length; i++)
					{
						if (networks[i] == max)
							chars += cif.cast.getCharByID(i).name + " ";
					}
					
					resultString += "The player's strong ties allow them to escape with " + chars + "\n";
				}
			}
			
			return resultString;
		}
		
		// TODO: This should really be stored in a XML file, but I ran out of time
		public function initEndings(): void
		{
			var newEnding:GameEnding = new GameEnding();
			var id:Number = 0;
			var rule:Rule = new Rule;
			var pred:Predicate = new Predicate;
			
			// Get Liz & James back together
			newEnding.id = id++;
			pred.type = Predicate.STATUS;
			pred.status = Status.IS_DATING;
			pred.primary = "Liz";
			pred.secondary = "James";
			rule.predicates.push(pred);
			newEnding.state = rule;
			newEnding.endingText = "James now free of Violet and happy with Liz helps free you from Violet's evil plans.";
			
			this.endings.push(newEnding);
			
			// Convince Violet to elope with James
			newEnding = new GameEnding();
			rule = new Rule;
			pred = new Predicate;
			newEnding.id = id++;
			pred.type = Predicate.STATUS;
			pred.status = Status.ELOPED_WITH;
			pred.primary = "Violet";
			pred.secondary = "James";
			rule.predicates.push(pred);
			newEnding.state = rule;
			newEnding.endingText = "Violet realizes she loves James more than she'd let herself believe and she gives up the cult to go elope with him.";
			
			this.endings.push(newEnding);
			
			//Fix up Thomas & Colonel's relationship
			newEnding = new GameEnding();
			rule = new Rule;
			pred = new Predicate;
			newEnding.id = id++;
			pred.type = Predicate.NETWORK;
			pred.networkType = SocialNetwork.FAMILYBOND;
			pred.comparator = "greaterthan";
			pred.networkValue = 75;
			pred.primary = "Colonel";
			pred.secondary = "Thomas";
			rule.predicates.push(pred);
			newEnding.state = rule;
			newEnding.endingText = "The Colonel realizes that he has no reason to be disappointed in Thomas and their family bond has become much stronger.";
			
			this.endings.push(newEnding);
			
			//Make Colonel hate Violet
			newEnding = new GameEnding();
			rule = new Rule;
			pred = new Predicate;
			newEnding.id = id++;
			pred.type = Predicate.NETWORK;
			pred.networkType = SocialNetwork.FAMILYBOND;
			pred.comparator = "lessthan";
			pred.networkValue = 25;
			pred.primary = "Colonel";
			pred.secondary = "Violet";
			rule.predicates.push(pred);
			newEnding.state = rule;
			newEnding.endingText = "The Colonel finally sees that Violet has been manipulating him this whole time and he is no longer under her spell.";
			
			this.endings.push(newEnding);
			
			//Convince Violet to sacrifice Thomas instead (romance)
			newEnding = new GameEnding();
			rule = new Rule;
			pred = new Predicate;
			newEnding.id = id++;
			pred.type = Predicate.NETWORK;
			pred.networkType = SocialNetwork.ROMANCE;
			pred.comparator = "greaterthan";
			pred.networkValue = 75;
			pred.primary = "Violet";
			pred.secondary = "Player";
			rule.predicates.push(pred);

			pred = new Predicate;
			pred.type = Predicate.NETWORK;
			pred.networkType = SocialNetwork.FAMILYBOND;
			pred.comparator = "lessthan";
			pred.networkValue = 25;
			pred.primary = "Violet";
			pred.secondary = "Thomas";
			rule.predicates.push(pred);

			newEnding.state = rule;
			newEnding.endingText = "Realizing her love for the player and her distaste for her brother Violet is convinced to sacrifice Thomas instead of the player.";
			
			this.endings.push(newEnding);
			
		}
		
		public function getPosTraits(): Vector.<String>
		{
			var resultVector:Vector.<String> = new Vector.<String>();
			
			for (var i:Number = 0; i <= Trait.LAST_POS_TRAIT; i++)
			{
				resultVector.push(Trait.getNameByNumber(i));
			}
			
			return resultVector;
		}
		
		public function getNegTraits(): Vector.<String>
		{
			var resultVector:Vector.<String> = new Vector.<String>();
			
			for (var i:Number = Trait.LAST_POS_TRAIT + 1; i <= Trait.LAST_NEG_TRAIT; i++)
			{
				resultVector.push(Trait.getNameByNumber(i));
			}
			
			return resultVector;
		}
		
		public function itemListToXML():XML {
			var outXML:XML = <ItemList/>;
			for each(var item:GrailItem in this.itemList) {
				outXML.appendChild(item.toXML());
			}
			return outXML;
		}
		
		public function knowledgeListToXML():XML {
			var outXML:XML = <KnowledgeList/>;
			for each(var know:GrailKnowledge in this.knowledgeList) {
				outXML.appendChild(know.cifKnowledge.toXML());
			}
			return outXML;
		}
		
		public function castListToXML():XML {
			var outXML:XML = <Cast/>;
			for each(var char:GrailCharacter in this.charList) {
				outXML.appendChild(char.toXML());
			}
			return outXML;
		}
		
		public function parseGameState(stateXML:XML):void {
			ParseXML.parseGameState(stateXML);
		}
		
		public function gameStateToXMLString():String {
			var xmlString:String = "";
			xmlString += this.itemListToXML().toXMLString();
			xmlString += this.knowledgeListToXML().toXMLString();
			xmlString += this.castListToXML().toXMLString();
			xmlString += cif.sfdb.toXMLString();
			xmlString += cif.ckb.toXMLString();
			xmlString += cif.buddyNetwork.toXMLString();
			xmlString += cif.trustNetwork.toXMLString();
			xmlString += cif.familyBondNetwork.toXMLString();
			xmlString += cif.romanceNetwork.toXMLString();
			xmlString += this.plotPointPool.toXMLString();
			xmlString = "<CiFState>\n" + xmlString + "\n</CiFState>";
			xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n" + xmlString;
			return xmlString;
		}

	}

}