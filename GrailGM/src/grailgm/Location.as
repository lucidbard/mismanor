package grailgm 
{
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class Location 
	{
		public var name:String = new String();
		public var charactersInLocation:Vector.<GrailCharacter> = new Vector.<GrailCharacter>();
		public var itemsInLocation:Vector.<GrailItem> = new Vector.<GrailItem>();
		
		public function Location() 
		{
			
		}
		
		public function clean(): void {
			name = null;
			
			if (charactersInLocation)
			{
				for each (var char:GrailCharacter in charactersInLocation)
				{
					char.clean();
					char = null;
				}
				charactersInLocation = null;
			}
			
			if (itemsInLocation)
			{
				for each (var item:GrailItem in itemsInLocation)
				{
					item.clean();
					item = null;
				}
				itemsInLocation = null;
			}
		}
	}

}