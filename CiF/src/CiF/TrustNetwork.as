package CiF 
{
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class TrustNetwork extends SocialNetwork 
	{
		
		public static var _instance:TrustNetwork = new TrustNetwork();
		
		public static function getInstance():TrustNetwork {
			return _instance;
		}

		public function TrustNetwork() 
		{
			if (_instance != null) {
				throw new Error("TrustNetwork (Constructor): TrustNetwork can only be accessed through TrustNetwork.getInstance()");
			}
			 this.type = TRUST;			
		}

		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		public static function equals(x:TrustNetwork, y:TrustNetwork): Boolean {
			if (x.network != y.network) return false;
			if (x.type != y.type) return false;
			return true;
		}
		
		//Returns an XML formatted String representation of this TrustNetwork.
		
		public override function toXMLString():String {
			var returnstr:String = new String();
			var theCast:Cast;
			theCast = Cast.getInstance();
			returnstr += "<Network type=\"trust\" numChars=\"" + this.network.length + "\">\n";
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