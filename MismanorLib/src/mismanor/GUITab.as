package mismanor 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class GUITab 
	{
		[Embed(source='../img/tab.png')]
		public var tabClass:Class;
		public var graphic:Bitmap = new tabClass();
		public var tabContainer:Sprite = new Sprite();		
		public var tabLabel:String;
		
		public function GUITab() 
		{
		}
		
	}

}