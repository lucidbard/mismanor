package CiF 
{
	/**
	 * Consists of a predicate and a time.
	 * Example XML:
	 * <StatusContext time>
	 *   <Predicate type="status"
	 *   first = "edward"
	 *   second = "karen"
	 *   status = "enmity"
	 *   isNegated = "false"
	 *   isSFDB = "false"
	 * </StatusContext>
	 */
	public class StatusContext implements SFDBContext
	{
		public var predicate:Predicate;
		public var time:int;
		
		public function StatusContext() 
		{
			this.predicate = new Predicate();
			this.time = -1;
		}

		public function clean(): void {
			if (this.predicate)
				predicate.clean();
			predicate = null;
		}
		/**********************************************************************
		 * SFDBContext Interface implementation.
		 *********************************************************************/
		public function getTime():int { return this.time; }
		 
		public function isSocialGame():Boolean { return false; }
		
		public function isTrigger():Boolean { return false; }
		
		public function isStatus():Boolean { return true; }
		
		public function getChange():Rule {
			var r:Rule = new Rule();
			r.predicates.push(this.predicate);
			return r;
			//return new Rule().predicates.push(this.predicate);
		}
		
		/**
		 * Determines if the StatusContext represents a status change consistent
		 * with the passed-in Predicate.
		 * 
		 * @param	p	Predicate to check for.
		 * @param	x	Primary character.
		 * @param	y	Secondary character.
		 * @param	z	Tertiary character.
		 * @return	True if the StatusContext's change is the same as the valuation
		 * of p. False if not.
		 */
		public function isPredicateInChange(p:Predicate, x:GameObject, y:GameObject, z:GameObject):Boolean {
			if (p.type != Predicate.STATUS) return false;
			if (p.negated != this.predicate.negated) return false;
			if (x.name != p.primary) return false;
			if(y)
				if (y.name != p.secondary) return false;
			if(z)
				if (z.name != p.tertiary) return false;
			return true;
		}
		
		/**********************************************************************
		 * Utility Functions
		 * *******************************************************************/
		
		public function toXML():XML {
			var outXML:XML = <StatusContext time = { this.time } > { new XML(predicate.toXMLString()) } </StatusContext>;
			//Debug.debug(this, "toXML()\n" + outXML.toXMLString());
			return outXML;
		}
		 
		public function toXMLString():String {
			return this.toXML().toString();
			//var returnString:String = new String();
			//returnString += "<StatusContext time=\"" + time + "\" >\n" + predicate.toXMLString() + "\n</StatusContext>";
			//return returnString;
		}
		
		public function clone(): StatusContext {
			var sc:StatusContext = new StatusContext();
			sc.time = this.time;
			sc.predicate = this.predicate.clone();
			return sc;
		}
		
		public static function equals(x:StatusContext, y:StatusContext): Boolean {
			if (!Predicate.equals(x.predicate, y.predicate)) return false;
			if (x.time != y.time) return false;
			return true;
		}
		
	}

}