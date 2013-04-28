package mismanor 
{
	import CiF.Rule;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import grailgm.GrailCharacter;
	import grailgm.GrailItem;
	import grailgm.GrailKnowledge;
	import grailgm.ParseXML;
	import grailgm.GrailGM;
	import grailgm.Quest;
	import grailgm.QuestLib;
	import grailgm.QuestType;
	
	/**
	 * This class is concerned with i/o for XML
	 * 
	 * @author Anne Sullivan
	 */
	public class XMLIO 
	{
		
		public function XMLIO() 
		{
			
		}
		
		public static function parseLibrary(libraryXML:XML): void
		{
			ParseXML.parseLibrary(libraryXML);
		}
		
		public static function parseGameState(stateXML:XML): GameState
		{
			var loadedState:GameState = GameState.getInstance();
			var stateComponents:XMLList = stateXML.children();
			var grailGM:GrailGM = GrailGM.getInstance();
			
			ParseXML.parseGameState(stateXML);
			
			for each (var component:XML in stateComponents) {
				if (component.name() == "ItemList")
				{
					grailGM.itemList = parseItemList(component);
				}
				else if (component.name() == "Cast")
				{
					grailGM.charList = parseCast(loadedState, component);
				}
				else if (component.name() == "QuestLib")
				{
					grailGM.questLib = ParseXML.parseQuestLib(component);
				}
			}
			
			return loadedState;
		}
		
		public static function parseItemList(itemListXML:XML): Vector.<GrailItem>
		{
			var itemList:Vector.<GrailItem> = new Vector.<GrailItem>();
			var listXML:XMLList = itemListXML.children();
			
			for each (var itemXML:XML in listXML)
			{
				var item:GameItem = parseItem(itemXML);
				itemList.push(item as GrailItem);
			}
			return itemList;
		}
		
		public static function parseCast(curState:GameState, castXML:XML): Vector.<GrailCharacter>
		{
			var charList:Vector.<GrailCharacter> = new Vector.<GrailCharacter>();
			var charListXML:XMLList = castXML.children();
			
			for each (var characterXML:XML in charListXML)
			{
				var character:GameCharacter = parseCharacter(curState, characterXML);
				// Need to initialize the cif stuff here - go through grailGM
				charList.push(character as GrailCharacter);
			}
			return charList;
		}
		
		public static function parseItem(itemXML:XML): GameItem
		{
			var workingItem:GameItem = new GameItem();
			ParseXML.loadItemInfo(workingItem, itemXML);
			
			// load graphic
			workingItem.graphicFileName = itemXML..img.@src;
			workingItem.setCurLocation(Map.getRoomTypeByName(itemXML..Location.@room));
			workingItem.x = itemXML..Location.@x;
			workingItem.y = itemXML..Location.@y;
			
			return workingItem;
		}
		
		public static function parseCharacter(curState:GameState, charXML:XML): GameCharacter
		{
			var ggm:GrailGM = GrailGM.getInstance();
			
			if (charXML.@name.toLowerCase() == "player")
			{
				var player:Player = new Player();
				grailgm.ParseXML.loadCharInfo(player, charXML);
				player.setCurLocation(Map.getRoomTypeByName(charXML..Location.@room));
				player.yOffset = charXML..Location.@yOffset;
				player.graphicFileName = charXML..img.@src;
				return player;
			}
			else
			{
				var workingChar:GameCharacter = new GameCharacter();
				grailgm.ParseXML.loadCharInfo(workingChar, charXML);
				
				// load graphic
				workingChar.graphicFileName = charXML..img.@src;
				workingChar.roomSide = charXML..Location.@roomSide;
				workingChar.yOffset = charXML..Location.@yOffset;
				workingChar.setCurLocation(Map.getRoomTypeByName(charXML..Location.@room));

				var itemList:XMLList = charXML..Inventory.children();

				for each (var itemXML:XML in itemList)
				{
					var workingItem:GameItem = curState.getItemByName(itemXML.@name);
					workingChar.inventory.addItem(workingChar, workingItem);
				}

				var knowList:XMLList = charXML..Memory.children();
				
				for each (var knowledgeXML:XML in knowList)
				{
					var workingKnowledge:GrailKnowledge = ggm.getKnowledgeByName(knowledgeXML.@name);
					if (workingKnowledge)
						workingChar.addKnowledge(workingKnowledge);
				}
				return workingChar;
			}		
		}

	}

}