package mismanor 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import grailgm.GrailItem;
	import grailgm.Inventory;

	/**
	 * ...
	 * @author April and anne
	 * 
	 * InventoryUI is concerned with drawing inventories in the correct place
	 */
	public class InventoryUI
	{
		public var itemBG:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat();
		public var showing:Boolean = false;
		
		public function InventoryUI() 
		{
			// inventory settings
			// set the text format for the text boxes on the screen
			textFormat.color = 0xFFFFFF;
			textFormat.size = 15;
			textFormat.font = "Calibri";
			textFormat.blockIndent = 15;
			itemBG.setTextFormat(textFormat);
			itemBG.defaultTextFormat = textFormat;
			//itemBG.defaultTextFormat = defaultTextFormat;
			itemBG.background = true;
			itemBG.alpha = 0.5;
			itemBG.backgroundColor = 0x000000;
			itemBG.multiline = true;
			itemBG.wordWrap = true;
			itemBG.text = "Inventory";
			itemBG.border = true;
			/*itemBG.width = questJournal.width;
			itemBG.height = questJournal.height;*/
			//itemBG.x = questJournal.x;
			itemBG.visible = false;
		}
		
		/***** Drawing *****/
		public function updateInventoryItemPositions(character:GameCharacter, x:Number, y:Number, padding:Number, width:Number = 0, height:Number = 0):void {
			var biggestWidth:Number = 50;
			var totalHeight:Number = padding / 2;
			var items:Vector.<GrailItem> = character.inventory.items;
			
			if (items)
			{
				var prevHeight:Number = 0; 
				
				for (var i:Number = 0; i < items.length; i++) {
					var item:GameItem = items[i] as GameItem;
					if (character.name != "player" && item.isHidden() == false) {
						item.graphic.visible = true;
						item.graphic.x = x + (padding / 2);
						item.graphic.y = y + (padding / 2);
						if (i > 0) item.graphic.y += prevHeight + padding / 2;
						if (item.graphic.width > biggestWidth) biggestWidth = item.graphic.width;
						totalHeight += item.graphic.height + (padding / 2);
						prevHeight += item.graphic.height;
						//items[i].graphic.width = width - padding;
						//items[i].graphic.height = height - padding;
					}
				}
			}
			itemBG.width = biggestWidth + padding;
			itemBG.height = totalHeight;
		}
		
		// When the mouse enters an NPC graphic, COLLISION!
		public function drawNPCInventory(character:GameCharacter, e:MouseEvent):void {
			itemBG.visible = true;
			itemBG.x = e.stageX+25;
			itemBG.y = e.stageY;
			updateInventoryItemPositions(character, e.stageX + 25, e.stageY+12, 50);
			//trace(this);
		}
		
		// When the mouse leaves an NPC graphic, hide!
		public function hideNPCInventory(char:GameCharacter):void {
			for each (var item:GameItem in char.inventory.items)
			{
				item.graphic.visible = false;
			}
			itemBG.visible = false;
		}
		
		// When the mouse moves within a graphic, update the position!
		public function moveNPCInventory(character:GameCharacter, e:MouseEvent):void {
			if (showing) {
				itemBG.x = e.stageX+25;
				itemBG.y = e.stageY;
				updateInventoryItemPositions(character, e.stageX + 25, e.stageY+12, 50);
			}
		}
		
	}

}