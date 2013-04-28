package mismanor 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import grailgm.GrailGM;
	import grailgm.Quest;
	import grailgm.QuestLib;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GameState 
	{
		// TODO: Maybe move game state into grailGM? Most of this stuff needs to be used by grail
		
		private static var _instance:GameState = new GameState();
		public var player:Player;
		//public var cast:Cast;
		public var curItem:GameItem; // the current item the player is interacting with
		public var midAction:Boolean = false; // Is the player in the middle of an action?
		public var curCharacter:GameCharacter; // The current character the player is interacting with
		private var grailGM:GrailGM = GrailGM.getInstance();

		public function GameState() 
		{
			if (_instance != null) {
				throw new Error("GameState (Constructor): " + "Cast can only be accessed through GameState.getInstance()");
			}
		}
		
		public function clean():void {
			if (player)
				player.clean();
			player = null;
			
			if (curItem)
				curItem.clean();
			curItem = null;
			
			if (curCharacter)
				curCharacter.clean();
			curCharacter = null;
						
		}
		
		public static function getInstance():GameState {
			return _instance;
		}
		
		public function getItemByName(name:String):GameItem
		{
			for each (var item:GameItem in grailGM.itemList)
			{
				if (item.name.toLowerCase() == name.toLowerCase())
					return item;
			}
			
			return null;
		}
		
		public function getItemByLoader(loader:Loader):GameItem
		{
			for each (var item:GameItem in grailGM.itemList)
			{
				if (item.graphicLoader == loader)
					return item;
			}
			
			return null;
		}
		public function getCharByLoader(loader:Loader):GameCharacter
		{
			for each (var char:GameCharacter in grailGM.charList)
			{
				if (char.graphicLoader == loader)
					return char;
			}
			return null;
		}
		
		public function getCharByContainer(container:Sprite):GameCharacter
		{
			for each (var char:GameCharacter in grailGM.charList)
			{
				if (char.characterContainer == container)
					return char;
			}
			trace ("Character not found");
			return null;
		}
		
		public function getItemByContainer(container:Sprite):GameItem
		{
			for each (var item:GameItem in grailGM.itemList)
			{
				if (item.itemContainer == container)
					return item;
			}
			trace ("Item not found");
			return null;
		}
		
	}

}