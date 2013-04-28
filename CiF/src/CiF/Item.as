package CiF 
{
	/**
	 * The Item class stores the basic information items need to
	 * operate in CiF. Items have a set of permanent traits, 
	 * a name, and changable statuses (gotten from GameObject)
	 *
	 * 
	 * TODO: if a trait is already assigned to an item, make sure it doesn't appear twice.
	 */
	public class Item extends GameObject
	{
		public function Item() {
			this.traits = new Vector.<Number>();
			this.name = "";
			this.networkID = -1;
			this.statuses = new Vector.<Status>();
			this.type = TYPE_ITEM;
		}
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		override public function toXML():XML {
			var returnXML:XML;
			var status:Status;
			returnXML = <Item name={this.name} networkID={this.networkID} type={this.type}/>;
			for each (var traitType:Number in this.traits) {
				returnXML.appendChild(<Trait type={Trait.getNameByNumber(traitType)} />);
			}
			for each(status in this.statuses) {
				if (status.isDirected){
					if (status.type != Status.IS_HOLDING && status.type != Status.HELD_BY) 
						returnXML.appendChild(<Status type={Status.getStatusNameByNumber(status.type)} from={this.name} to={status.directedToward} />);
				} else {
					returnXML.appendChild(<Status type={Status.getStatusNameByNumber(status.type)} />);
				}
			}
			return returnXML;
		}
		
		override public function toXMLString():String {
			return this.toXML().toXMLString();
		}
		 
		public function clone(): Item {
			var item:Item = new Item();
			var status:Status;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			item.name = this.name;
			item.traits = new Vector.<Number>();
			item.type = this.type;
			for each(var i:Number in this.traits) {
				item.traits.push(i);
			}
			for each (status in this.statuses) {
				//status = this.statuses[key] as Status;
				item.addStatus(status.type, cif.cast.getCharByName(status.directedToward));
			}
			return item;
		}
		
		public static function equals(x:Item, y:Item): Boolean {
			if (x.traits.length !=y.traits.length) return false;
			for (var i:Number = 0; i < x.traits.length; ++i) {
				if ((x.traits[i] != y.traits[i])) return false;
			}
			if (x.name != y.name) return false;
			if (x.networkID != y.networkID) return false;
			return true;
		}
	}
}