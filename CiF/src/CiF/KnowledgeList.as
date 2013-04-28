package CiF 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author April
	 */
	public class KnowledgeList 
	{
		private static var _instance:KnowledgeList = new KnowledgeList();
		
		/**
		 * The knowledge in the KnowledgeList.
		 */
		public var knowledges:Vector.<Knowledge> = new Vector.<Knowledge>();
		
		/**
		 * A hash matching Character class references with the key of the character's name as a String.
		 */
		private var knowledgesByName:Dictionary;
		
		public static function getInstance():KnowledgeList {
			return _instance;
		}
		
		public function KnowledgeList() {
			if (_instance != null) {
				throw new Error("KnowledgeList (Constructor): " + "KnowledgeList can only be accessed through KnowledgeList.getInstance()");
			}
			this.knowledges = new Vector.<Knowledge>();
			this.knowledgesByName = new Dictionary();
		}
		
		public function reset():void {
			if (this.knowledges)
			{
				for each (var knowledge:Knowledge in knowledges)
				{
					knowledge.clean();
					knowledge = null;
				}
				this.knowledges = null;
			}
			this.knowledgesByName = null;
			
			this.knowledges = new Vector.<Knowledge>();
			this.knowledgesByName = new Dictionary();
		}
		
		/**
		 * Accessor to the number of characters currently in the class.
		 */
		public function get length():Number {return this.knowledges.length;}
		
		/**
		 * Returns the Character class associated with a String character name.
		 * @param	name The name of the character.
		 * @return	The instantiation of the Character class corresponding to 
		 * the name.
		 */
		public function getKnowledgeByName(name:String):Knowledge {
			for each (var know:Knowledge in this.knowledges) {
				if (know.name.toLowerCase() == name.toLowerCase())
					return know;
			}
			Debug.debug(this, "getKnowledgeByName() knowledge with name " + name + " is not in the KnowledgeList",2);		
			return null;
		}
		
		public function getKnowledgeByID(id:int):Knowledge {
			for each (var know:Knowledge in this.knowledges) {
				if (know.networkID == id)
					return know;
			}
			Debug.debug(this, "getKnowledgeByID() knowledge with id " + id + " is not in the KnowledgeList",2);		
			return null;
		}
		
		public function addKnowledge(k:Knowledge):void {
			this.knowledges.push(k);
			this.knowledgesByName[k.name] = k;
			this.knowledgesByName[k.name.toLowerCase()] = k;
		}
		
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		 
		public function clone(): KnowledgeList {
			var k:KnowledgeList = new KnowledgeList();
			k.knowledges = new Vector.<Knowledge>();
			for each(var know:Knowledge in this.knowledges) {
				k.addKnowledge(know.clone());
			}
			return k;
		}
		
		public function toXML():XML {
			var outXML:XML = <KnowledgeList />;
			for each(var know:Knowledge in this.knowledges) {
				outXML.appendChild(know.toXML());
			}
			return outXML;
		}
		
		/*
		 * Returns a String in properly formatted XML representing the KnowledgeList.
		 * */
		public function toXMLString():String {
			return this.toXML().toXMLString();
			//var output:String = new String();
			//output = "<KnowledgeList>\n";
			//for (var i:int = 0; i < this.characters.length; i++) {
				//output += this.characters[i].toXMLString();
				//output += "\n";
			//}
			//output += "</KnowledgeList>\n";
			//return output;
		}
		
		public static function equals(x:KnowledgeList, y:KnowledgeList): Boolean {
			if (x.knowledges.length != y.knowledges.length) return false;
			var i:Number;
			for (i = 0; i < x.knowledges.length; ++i) {
				if (!Knowledge.equals(x.knowledges[i], y.knowledges[i])) return false;
			}
			return true;
		}
		
	}

}