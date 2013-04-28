package CiF 
{
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class FamilyBondNetwork extends SocialNetwork 
	{
		
		public static var _instance:FamilyBondNetwork = new FamilyBondNetwork();
		
		public static function getInstance():FamilyBondNetwork {
			return _instance;
		}

		public function FamilyBondNetwork() 
		{
			if (_instance != null) {
				throw new Error("FamilyBondNetwork(Constructor): FamilyBondNetwork can only be accessed through FamilyBondNetwork.getInstance()");
			}
			 this.type = FAMILYBOND;			
		}

		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		public static function equals(x:FamilyBondNetwork, y:FamilyBondNetwork): Boolean {
			if (x.network != y.network) return false;
			if (x.type != y.type) return false;
			return true;
		}
		
		//Returns an XML formatted String representation of this FamilyBondNetwork.
		
		public override function toXMLString():String {
			var returnstr:String = new String();
			var theCast:Cast;
			theCast = Cast.getInstance();
			returnstr += "<Network type=\"familybond\" numChars=\"" + this.network.length + "\">\n";
			for (var i:Number = 0; i < theCast.length; ++i) {
				for (var j:Number = 0; j < theCast.length; ++j) {
					if (i != j) {
						returnstr += "<edge from=\"" + theCast.characters[i].name + "\" to=\"" + theCast.characters[j].name + "\" value=\"" + this.network[i][j] + "\" />\n";
					}
				}
			}
			returnstr += "</Network>";
			return returnstr;
		}
		
	}

}