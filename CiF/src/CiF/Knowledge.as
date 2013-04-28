package CiF 
{
	import flash.utils.Dictionary;
	/**
	 * The Knowledge class stores the basic information knowledge needs to
	 * operate in CiF. Knowledge has a set of permanent traits, 
	 * a name, and changable statuses.
	 *
	 * 
	 * TODO: if a trait is already assigned to knowledge, make sure it doesn't appear twice.
	 */
	public class Knowledge extends GameObject
	{
		// Related to Daughter:
		public static const VIOLET_COLONEL_NOT_CLOSE:Number = 0; //-Violet is not very close with the Colonel
		public static const VIOLET_STABLEBOY_TOGETHER:Number = 1; //-Violet and the Stable Boy are together a lot
		public static const VIOLET_SCAR:Number = 2; //-Violet has a strange scar on her wrist
		public static const VIOLET_BADGER_ATTACK:Number = 3; //-(FALSE WUMMY) James saved Violet from a badger attack
		public static const VIOLET_CULT_MEMBER:Number = 4; // -Violet is a member of a cult

		//Related to Colonel:
		public static const COLONEL_WANTS_DAUGHTER_CLOSE:Number = 5; //-Colonel is not very close with his daughter, but wants to be
		public static const COLONEL_DOESNT_LIKE_STABLEBOY:Number = 6; //-Colonel really doesn’t like the stable boy, because he doesn’t want him to be involved with daughter
		public static const COLONEL_DOESNT_WANT_DAUGHTER_STABLEBOY_RELATIONSHIP:Number = 7;
		public static const COLONEL_DOESNT_KNOW_ABOUT_ROOMS:Number = 8; //-Colonel doesn’t know about some of the rooms in the manor

		//Related to Stable Boy:
		public static const JAMES_AROUND_VIOLET:Number = 9; //-James likes to be around Violet
		public static const JAMES_WEIRD_AROUND_COLONEL:Number = 10; //-James gets very submissive around the Colonel
		public static const JAMES_DOESNT_TALK_ABOUT_MANOR:Number = 11; //-James locks up when you try to talk to him about the weird things in the manor
		public static const JAMES_CULT_MEMBER:Number = 12; //-James is a member of a cult
		//Related to Cult:
		public static const STRANGE_STATUE:Number = 13; //-There is a bizarre statue covered in weird writing hidden in the stable
		public static const CULT_EXISTS:Number = 14; //-There is a cult
		public static const PLAYER_SACRIFICE:Number = 15; //-The player is the sacrifice for the cult!
		
		public static const KNOWLEDGE_COUNT:Number = 16;
		
		public var mentionedLocations:Vector.<String> = new Vector.<String>();
		public var mentionedCharacters:Vector.<String> = new Vector.<String>();
		
		public function Knowledge() {
			this.traits = new Vector.<Number>();
			this.name = "";
			this.networkID = -1;
			this.statuses = new Vector.<Status>();
			this.type = TYPE_KNOWLEDGE;
		}
		
		override public function clean(): void {
			var str:String;
			
			if (this.mentionedCharacters)
			{
				for each (str in mentionedCharacters)
					str = null;
			}
			this.mentionedCharacters = null;
			
			if (this.mentionedLocations)
			{
				for each (str in this.mentionedLocations)
					str = null;
			}
			this.mentionedLocations = null;

			this.traits = null;
			this.name = null;
			
			if (this.statuses)
			{
				for each (var status:Status in this.statuses)
				{
					status.clean();
					status = null;
				}
				this.statuses = null;
			}
		}
		
		/**
		 * Given the Number representation of Knowledge, this function
		 * returns the String representation of that knowledge. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * Knowledge.getNameByNumber(Knowledge.CULT_EXISTS); //returns "There is a cult"
		 * </listing>
		 * 
		 * @param	type The Knowledge type as a Number.
		 * @return The String representation of the Knowledge type.
		 */
		public static function getNameByNumber(type:Number):String {
			switch (type) {
				// Related to Daughter:
				case VIOLET_COLONEL_NOT_CLOSE:
					return "Violet is not very close with the Colonel";
				case VIOLET_STABLEBOY_TOGETHER:
					return "Violet and James are together a lot";
				case VIOLET_SCAR:
					return "Violet has a strange scar on her wrist";
				case VIOLET_BADGER_ATTACK:
					return "James once saved Violet from a badger attack";
				case VIOLET_CULT_MEMBER:
					return "Violet is a member of a cult";

				//Related to Colonel:
				case COLONEL_WANTS_DAUGHTER_CLOSE:
					return "Colonel wants to be closer to his daughter";
				case COLONEL_DOESNT_LIKE_STABLEBOY:
					return "Colonel really doesn’t like the stable boy";
				case COLONEL_DOESNT_WANT_DAUGHTER_STABLEBOY_RELATIONSHIP:
					return "Colonel doesn't want his daughter dating the stable boy";
				case COLONEL_DOESNT_KNOW_ABOUT_ROOMS:
					return "Colonel doesn’t know about some of the rooms in the manor";

				//Related to Stable Boy:
				case JAMES_AROUND_VIOLET:
					return "James likes to be around Violet";
				case JAMES_WEIRD_AROUND_COLONEL:
					return "James gets very submissive around the Colonel";
				case JAMES_DOESNT_TALK_ABOUT_MANOR:
					return "James locks up when you try to talk to him about the weird things in the manor";
				case JAMES_CULT_MEMBER:
					return "James is a member of a cult";

				//Related to Cult
				case STRANGE_STATUE:
					return "There is a bizarre statue covered in weird writing hidden in the stable";
				case CULT_EXISTS:
					return "There is a cult that meets in the manor";
				case PLAYER_SACRIFICE:
					return "The player is the sacrifice for the cult's next ritual";
			
				default:
					return "knowledge not found";				
			}
		}
		
		/**
		 * Given the String representation of Knowledge, this function
		 * returns the Number representation of that knowledge. This is intended to
		 * be used in UI elements of the design tool.
		 * 
		 * @example <listing version="3.0">
		 * Knowledge.getNumberByName("there is a cult that meets in the manor"); //returns Knowledge.CULT_EXISTS
		 * </listing>
		 * 
		 * @param	type The knowledge type as a String.
		 * @return The Number representation of the knowledge type.
		 */
		public static function getNumberByName(name:String):Number {
			switch (name.toLowerCase()) {
				// Related to Daughter:
				case "violet is not very close with the colonel":
					return VIOLET_COLONEL_NOT_CLOSE;
				case "violet and james are together a lot":
					return VIOLET_STABLEBOY_TOGETHER;
				case "violet has a strange scar on her wrist":
					return VIOLET_SCAR;
				case "james once saved violet from a badger attack":
					return VIOLET_BADGER_ATTACK;
				case "violet is a member of a cult":
					return VIOLET_CULT_MEMBER;

				//Related to Colonel:
				case "colonel wants to be closer to his daughter":
					return COLONEL_WANTS_DAUGHTER_CLOSE;
				case "colonel really doesn’t like the stable boy":
					return COLONEL_DOESNT_LIKE_STABLEBOY;
				case "colonel doesn't want his daughter dating the stable boy":
					return COLONEL_DOESNT_WANT_DAUGHTER_STABLEBOY_RELATIONSHIP;
				case "colonel doesn’t know about some of the rooms in the manor":
					return COLONEL_DOESNT_KNOW_ABOUT_ROOMS;

				//Related to Stable Boy:
				case "james likes to be around violet":
					return JAMES_AROUND_VIOLET;
				case "james gets very submissive around the colonel":
					return JAMES_WEIRD_AROUND_COLONEL;
				case "james locks up when you try to talk to him about the weird things in the manor":
					return JAMES_DOESNT_TALK_ABOUT_MANOR;
				case "james is a member of a cult":
					return JAMES_CULT_MEMBER;

				//Related to Cult
				case "there is a bizarre statue covered in weird writing hidden in the stable":
					return STRANGE_STATUE;
				case "there is a cult that meets in the manor":
					return CULT_EXISTS;
				case "the player is the sacrifice for the cult's next ritual":
					return PLAYER_SACRIFICE;
			
				default:
					return -1;
			}
		}
		
		
		
		/**********************************************************************
		 * Utility Functions
		 *********************************************************************/
		
		override public function toXML():XML {
			var returnXML:XML;
			var status:Status;
			returnXML = <Knowledge name={this.name} />;
			for each (var traitType:Number in this.traits) {
				returnXML.appendChild(<Trait type={Trait.getNameByNumber(traitType)} />);
			}
			for each (status in this.statuses) {
				if (status.isDirected){
					returnXML.appendChild(<Status type={Status.getStatusNameByNumber(status.type)} from={this.name} to={status.directedToward} />);
				} else {
					returnXML.appendChild(<Status type={Status.getStatusNameByNumber(status.type)} />);
				}
			}
			return returnXML;
		}
		 
		public function clone(): Knowledge {
			var know:Knowledge = new Knowledge();
			var status:Status;
			var cif:CiFSingleton = CiFSingleton.getInstance();
			know.name = this.name;
			know.traits = new Vector.<Number>();
			know.type = this.type;
			for each(var i:Number in this.traits) {
				know.traits.push(i);
			}
			for each (status in this.statuses) {
				//status = this.statuses[key] as Status;
				know.addStatus(status.type, cif.cast.getCharByName(status.directedToward));
			}
			return know;
		}
		
		public static function equals(x:Knowledge, y:Knowledge): Boolean {
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