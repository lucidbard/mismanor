package grailgm 
{
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	import CiF.Character;
	import CiF.CiFSingleton;
	import CiF.Instantiation;
	import CiF.Item;
	import CiF.ParseXML;
	import CiF.Rule;
	import CiF.Trait;
	
	public class ParseXML 
	{
		public function ParseXML() 
		{
			
		}
		
		public static function parseLibrary(libraryXML:XML): void
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();

			// yes they use the same function for both state and library files
			cif.parseCiFState(libraryXML);
		}
		
		public static function parseGameState(stateXML:XML): void
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();
			var grail:GrailGM = GrailGM.getInstance();
			var grailComponents:XMLList = stateXML.children();
			
			cif.parseCiFState(stateXML, false);
			for each (var component:XML in grailComponents) {
				if (component.name() == "ItemList") {
					grail.itemList = new Vector.<GrailItem>();
					ParseXML.gameItemListParse(component);
				} else if (component.name() == "Cast") {
					grail.charList = new Vector.<GrailCharacter>();
					ParseXML.gameCastParse(component);
				}
				else if (component.name() == "KnowledgeList")
				{
					grail.knowledgeList = new Vector.<GrailKnowledge>();
					grail.knowledgeList = parseKnowledgeList(component);
				}
				else if (component.name() == "PlotPointList")
				{
					grail.plotPointPool = new PlotPointPool();
					grail.plotPointPool = ParseXML.parsePlotPointPool(component);
				}
			}
			
		}
		
		
		/** (April)
		 * Reads in the items in the item list portion of the stateXML file.
		 * Required a re-doing in Grail because of image and location information being lost in CiF
		 * @param	itemXML -- The component in the stateXML labeled "ItemList"
		 */
		public static function gameItemListParse(itemListXML:XML):void {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			var ggm:GrailGM = GrailGM.getInstance();
			var item:GrailItem;
			var itemXML:XML;
			
			
			for each(itemXML in itemListXML.Item) {
				item = new GrailItem();
				item.cifItem = cif.itemList.getItemByName(itemXML.@name);
				item.imgLocationString = itemXML..img.@src;
				item.curLocationString = itemXML..Location.@room;
				item.xString = itemXML..Location.@x;
				item.yString = itemXML..Location.@y;

				ggm.itemList.push(item);
			}
		}
		
		public static function parseKnowledgeList(knowledgelistXML:XML): Vector.<GrailKnowledge>
		{
			var knowledgeList:Vector.<GrailKnowledge> = new Vector.<GrailKnowledge>();
			var listXML:XMLList = knowledgelistXML.children();
			
			for each (var knowXML:XML in listXML)
			{
				var knowledge:GrailKnowledge = parseKnowledge(knowXML);
				knowledgeList.push(knowledge);
			}
			return knowledgeList;
		}
				
		public static function parseKnowledge(knowXML:XML): GrailKnowledge
		{
			var workingKnowledge:GrailKnowledge = new GrailKnowledge();
			ParseXML.loadKnowledgeInfo(workingKnowledge, knowXML);
			workingKnowledge.id = knowXML.@id;
			return workingKnowledge;
		}
		
		public static function gameCastParse(castXML:XML):void {
			var cif:CiFSingleton = CiFSingleton.getInstance();
			var ggm:GrailGM = GrailGM.getInstance();
			var char:GrailCharacter;
			var charXML:XML;
			
			for each(charXML in castXML.Character) {
				char = new GrailCharacter();
				char.cifCharacter = cif.cast.getCharByName(charXML.@name);
				char.initInventory();
				
				// load graphic
				char.imgString = charXML..img.@src;
				char.locationRoomSideString = charXML..Location.@roomSide;
				char.locationYOffsetString = charXML..Location.@yOffset;
				char.locationRoomString = charXML..Location.@room;

				var itemList:XMLList = charXML..Inventory.children();

				for each (var itemXML:XML in itemList)
				{
					var workingItem:GrailItem = ggm.getItemByName(itemXML.@name);
					char.inventory.addItem(char, workingItem);
				}

				ggm.charList.push(char);
			}	
		}
	
		public static function loadKnowledgeInfo(workingKnowledge:GrailKnowledge, knowXML:XML): void
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();
			workingKnowledge.cifKnowledge = cif.knowledgeList.getKnowledgeByName(knowXML.@name);
		}
		
		public static function loadItemInfo(workingItem:GrailItem, itemXML:XML): void
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();
			workingItem.cifItem = cif.itemList.getItemByName(itemXML.@name);
		}
		
		public static function loadCharInfo(workingChar:GrailCharacter, charXML:XML): void
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();
			workingChar.cifCharacter = cif.cast.getCharByName(charXML.@name);
			
		}
		
		public static function parsePlotPointPool(plotPointPoolXML:XML): PlotPointPool
		{
			var ppPool:PlotPointPool = new PlotPointPool;
			var plotPointListXML:XMLList = plotPointPoolXML.children();
			
			for each (var plotpointXML:XML in plotPointListXML)
			{
				var pp:PlotPoint = parsePlotPoint(ppPool, plotpointXML);
				ppPool.plotPoints.push(pp);
			}
			ppPool.totalPlotPoints = ppPool.plotPoints.length;
			
			return ppPool;
		}
		
		public static function parsePlotPoint(ppPool:PlotPointPool, plotPointXML:XML): PlotPoint
		{
			var workingPlotPoint:PlotPoint = new PlotPoint();
			var ggm:GrailGM = GrailGM.getInstance();
			
			workingPlotPoint.id = plotPointXML.@id;
			workingPlotPoint.cifKnowledge = ggm.getKnowledgeByName(plotPointXML.@knowledge).cifKnowledge;
			workingPlotPoint.cifKnowledge.traits.push(Trait.PLOTPOINT);
			
			var preconListXML:XMLList = plotPointXML.Preconditions.children();
			
			// story preconditions
			for each (var preconXML:XML in preconListXML)
			{
				// find the plot point it matches
				for each (var pp:PlotPoint in ppPool.plotPoints)
				{
					if (pp.id == preconXML.@id)
					{
						workingPlotPoint.storyPreConditions.push(pp);
						break;
					}
				}
			}
			// instantiations
			var instListXML:XMLList = plotPointXML.Instantiations.children();
			
			for each (var instXML:XML in instListXML)
			{
				// load the instantation
				var grailInst:GrailInstantiation = new GrailInstantiation;
				
				grailInst.cifInstantiation = CiF.ParseXML.parseInstantiation(instXML);
				grailInst.instantiationType = GrailInstantiation.getIDByName(instXML.@type);
				grailInst.speaker = instXML.@speaker;

				workingPlotPoint.instantiations.push(grailInst);
			}
			
			return workingPlotPoint;
		}
		
		public static function parseQuestLib(questLibXML:XML): QuestLib
		{
			var questLib:QuestLib = new QuestLib;
			var questList:Vector.<Quest> = questLib.quests;
			var questListXML:XMLList = questLibXML.children();
			
			for each (var questXML:XML in questListXML)
			{
				var quest:Quest = parseQuest(questXML);
				questList.push(quest);
			}
			questLib.totalQuests = questList.length;
			return questLib;
		}
		
		public static function parseQuest(questXML:XML): Quest
		{
			var workingQuest:Quest = new Quest();
			var ruleXML:XML;
			var workingRule:Rule = new Rule();
			
			workingQuest.name = questXML.@name;
			workingQuest.type = QuestType.getNumberByName(questXML.@type);
			
			if (questXML.@itemRequired == "true")
				workingQuest.itemRequired = true;
			else
				workingQuest.itemRequired = false;
				
			workingQuest.questGiver = questXML.@questGiver;
			workingQuest.questCompleter = questXML.@questCompleter;
			
			// Intents
			for each (ruleXML in questXML.Intents..Rule) {
				workingRule = CiF.ParseXML.ruleParse(ruleXML);
				workingQuest.intents.push(workingRule);
			}

			// Preconditions
			for each (ruleXML in questXML.Preconditions..Rule)
			{
				workingRule = CiF.ParseXML.ruleParse(ruleXML);
				workingQuest.preconditions.push(workingRule);
			}
			
			var stateXML:XML;
			var workingState:QuestState;
			
			// Starting States
			for each (stateXML in questXML.StartingStates..State)
			{
				workingState = parseState(stateXML);
				workingQuest.startingStates.push(workingState);
			}
			
			// Completion States
			for each (stateXML in questXML.CompletionStates..State)
			{
				workingState = parseState(stateXML);
				workingQuest.completionStates.push(workingState);
			}
			
			// Tags
			var tagXML:XML;
			var charTag:String;
			for each (tagXML in questXML.Tags..Character)
			{
				charTag = tagXML.@name;
				workingQuest.charsMentioned.push(charTag);
			}
			return workingQuest;
		}
		
		public static function parseState(stateXML:XML): QuestState
		{
			var workingState:QuestState = new QuestState();

			workingState.name = stateXML.@name;
			
			//state
			//there should be only one, but it's still a "list"
			var ruleXML:XML;
			for each (ruleXML in stateXML.Rule)
				workingState.state = CiF.ParseXML.ruleParse(ruleXML);
			
			//Scenes
			var workingScene:GrailScene;
			var sceneXML:XML;
			
			for each (sceneXML in stateXML..Scene)
			{
				workingScene = new GrailScene;
				workingScene.pairedStateID = Number(sceneXML.@pairedID);
				
				// should be only one, but still have to treat it like a list
				for each (var instXML:XML in sceneXML..Instantiation)
					workingScene.dialogue = CiF.ParseXML.parseInstantiation(instXML);
				
				for each (ruleXML in sceneXML..Rule)
					workingScene.socialChange = CiF.ParseXML.ruleParse(ruleXML);
				
				workingState.scenes.push(workingScene);
			}
			return workingState;
		}

	}

}