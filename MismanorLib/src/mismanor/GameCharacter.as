package mismanor 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import grailgm.GrailCharacter;
	import grailgm.GrailItem;
	
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GameCharacter extends GrailCharacter
	{
		// graphics/interface
		public var graphic:Bitmap;
		public var graphicLoader:Loader;
		public var graphicFileName:String;
		public var roomSide:String;
		public var yOffset:Number;
		public var characterContainer:Sprite = new Sprite();
		public var inventoryUI:InventoryUI;
		private var visible:Boolean = true;
		
		public function GameCharacter() 
		{
			super();
			initInventory();
		}
		
		public function enable():void
		{
			
			this.graphic.visible = true;
			this.characterContainer.buttonMode = true;
		}
		
		public function visibility():void
		{
			visible = !visible;
			if (visible)
			{
			this.graphic.alpha = 1;
			}
			else
			{
				this.graphic.alpha = 0;
			}
			//this.characterContainer.buttonMode = visible;
			
		}
		
		public function hide():void
		{
			visible = false;
			this.graphic.alpha = 0;
			this.characterContainer.buttonMode = false;
			this.characterContainer.mouseEnabled = false;
		}
		
		public function show():void
		{
			visible = true;
			this.graphic.alpha = 1;
			this.characterContainer.buttonMode = true;
			this.characterContainer.mouseEnabled = true;
			
		}
		
		public function disable():void
		{
			this.graphic.visible = false;
			this.characterContainer.buttonMode = false;
		}
		
		public override function initInventory(): void {
			inventoryUI = new InventoryUI();
			/*
			characterContainer.addEventListener(MouseEvent.MOUSE_OVER, drawNPCInventory);
			characterContainer.addEventListener(MouseEvent.MOUSE_OUT, hideNPCInventory);
			characterContainer.addEventListener(MouseEvent.MOUSE_MOVE, moveNPCInventory);
			*/
			characterContainer.addChild(inventoryUI.itemBG);
			super.initInventory();
		}
		
		public function drawNPCInventory(e:MouseEvent):void {
			showInventory();
			inventoryUI.drawNPCInventory(this, e);
		}
		
		public function hideNPCInventory(e:MouseEvent):void {
			hideInventory();
			inventoryUI.hideNPCInventory(this);
		}
		
		public function moveNPCInventory(e:MouseEvent):void {
			inventoryUI.moveNPCInventory(this, e);
		}
		
		public function showInventory():void {
			for each (var item:GameItem in inventory.items) {
				if (this.name == "player" || !item.isHidden()) item.graphic.visible = true;
			}
			inventoryUI.showing = true;
		}
		
		public function hideInventory():void {
			for each (var item:GameItem in inventory.items) {
				item.graphic.visible = false;
			}
			inventoryUI.showing = false;
		}
		
		public function removeInventoryItemByName(char:GameCharacter, item:String):void 
		{
			var toRemove:GameItem = null;
			for each(var it:GameItem in inventory.items) {
				if (it.name == item && toRemove == null) toRemove = it;
			}
			if (toRemove != null) {
				toRemove.moveToPositionInRoom();
				inventory.removeItem(char as GrailCharacter, toRemove as GrailItem);
			}
			else trace("Inventory.removeInventoryItemByName(): Item with name " + item + "not found in this inventory");
	
		}
		
		override public function toString(): String
		{
			var totalString:String = super.toString();
						
			totalString += this.inventory;
			
			return totalString;
		}
	}

}