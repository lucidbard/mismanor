package CiF 
{
	
	/**
	 * The SFDBContext interface class denotes the minimum implementation a 
	 * class needs to have to be a context in the SFDB.
	 * 
	 * @see CiF.SocialFactsDB
	 */
	public interface SFDBContext
	{
		function getTime():int;
		
		function getChange():Rule;
		
		function clean(): void;
		/**
		 * The number of SFDBContext types.
		 */
		function isSocialGame():Boolean;
		
		function isTrigger():Boolean;
		
		function isStatus():Boolean;
		
		function isPredicateInChange(p:Predicate, x:GameObject, y:GameObject, z:GameObject):Boolean;
		
		function toXMLString():String;
		
		function toXML():XML;
	}

}