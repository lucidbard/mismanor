package grailgm 
{
	import CiF.CiFSingleton;
	import CiF.GameObject;
	import CiF.Knowledge;
	import CiF.InfluenceRuleSet;
	import CiF.Instantiation;
	import CiF.LineOfDialogue;
	import CiF.Rule;
	import CiF.Status;
	import CiF.Trait;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class PlotPoint extends GrailKnowledge
	{
		// Plot points that must have been triggered before this one can be active (Story DAG representation) (hard constraint)
		public var storyPreConditions:Vector.<PlotPoint> = new Vector.<PlotPoint>(); 

/*		// Social state pre-conditions (hard constraint) (Handled elsewhere?)
		public var preconditions:Vector.<Rule> = new Vector.<Rule>(); 

		// Rules for when it'd be best to have the plot point show up (soft constraint) (handled elsewhere)
		public var timingIRS:InfluenceRuleSet = new InfluenceRuleSet(); 
*/
		// whether a plot point has been used/shown the player
		public var activated:Boolean = false; 
		public var weight:Number = 0;
		
		public var instantiations:Vector.<GrailInstantiation> = new Vector.<GrailInstantiation>();
		
		public function PlotPoint() 
		{
			
		}
		
		override public function clean(): void {
			if (cifKnowledge)
				cifKnowledge.clean();
			cifKnowledge = null;
			
			if (storyPreConditions)
			{
				for each (var plotpoint:PlotPoint in this.storyPreConditions)
				{
					plotpoint.clean();
					plotpoint = null;
				}
				this.storyPreConditions = null;
			}
			
			if (instantiations)
			{
				for each (var inst:GrailInstantiation in this.instantiations)
				{
					inst.clean();
					inst = null;
				}
				this.instantiations = null;
			}
		}
		
		// used to evaluate the storyPreconditions
		// if every pre-condition has been activated, then this plot point must be available
		public function evaluateStoryReqs(): Boolean
		{
			// if it's already been activated, then not available
			if (activated)
				return false;
				
			for each (var pp:PlotPoint in storyPreConditions)
			{
				if (!pp.activated)
					return false;
			}
			return true;
		}
		
		// return the number of pre-conditions
		public function traversePreCons(numPreCons:Number = 0):Number
		{
			var result:Number = numPreCons;
			for each (var plotPoint:PlotPoint in this.storyPreConditions)
			{
				result++;
				result = plotPoint.traversePreCons(result);
			}
			return result;
		}
		
		// TODO: this should be removed after the demo, this is just a workaround for the xml not working yet
		public function setKnowledgeTrait(type:Number): void
		{
			this.cifKnowledge.setTrait(type);
		}
		
		// TODO: this should be removed after a demo, this is just a workaround for the xml not working yet
		public function setKnowledgeStatus(type:Number): void
		{
			this.cifKnowledge.addStatus(type);
		}
		
		// is this plot point marked as an end game plot point?
		public function isEndGame(): Boolean
		{
			return this.cifKnowledge.hasTrait(Trait.ENDGAME);
		}
		
		// helper functions
		public function getInstantiationsByType(type:Number): Vector.<GrailInstantiation>
		{
			var instantiationResults:Vector.<GrailInstantiation> = new Vector.<GrailInstantiation>();
			
			for each(var instantiation:GrailInstantiation in instantiations)
			{
				if (instantiation.instantiationType == type)
					instantiationResults.push(instantiation);
			}
			return instantiationResults;
		}
		
		public function getInstantiationsBySpeaker(speaker:GameObject): Vector.<GrailInstantiation>
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();
			var instantiationResults:Vector.<GrailInstantiation> = new Vector.<GrailInstantiation>();
			
			for each(var instantiation:GrailInstantiation in instantiations)
			{
				var instSpeaker:GameObject = cif.getGameObjByName(instantiation.speaker);
				if (instSpeaker == speaker)
					instantiationResults.push(instantiation);
			}
			return instantiationResults;
		}
		
		public function getInstantiationBySpeakerAndType(speaker:String, type:Number): GrailInstantiation
		{
			for each (var instantiation:GrailInstantiation in instantiations)
			{
				if (instantiation.speaker == speaker && instantiation.instantiationType == type)
					return instantiation;
			}
			return null;
		}
		
		// Utility Functions
		// (April) Done so that the design tool works
		public function setKnowledgeByName(name:String): void
		{
			var cif:CiFSingleton = CiFSingleton.getInstance();
			cifKnowledge = cif.knowledgeList.getKnowledgeByName(name);
		}
		
		public function setPlotPointName(name:String): void
		{
			cifKnowledge.name = name;
		}

		public function get name(): String
		{
			return cifKnowledge.name;
		}
		
		public function toXMLString():String {
			var returnXML:XML;
			var ppPreConXML:XML;
			var ppTraitXML:XML;
			var instXML:XML;
			returnXML = <PlotPoint id={this.id} knowledge={this.cifKnowledge.name}/>;
			//Preconditions list
			ppPreConXML = <Preconditions />;
			for each (var ppPreCon:PlotPoint in this.storyPreConditions){
				ppPreConXML.appendChild( <Precondition id = {ppPreCon.id} /> );
			}
			returnXML.appendChild(ppPreConXML);
			// Instantiations
			instXML = <Instantiations />;
			for each (var inst:GrailInstantiation in this.instantiations)
			{
				instXML.appendChild(inst.toXML());
			}
			returnXML.appendChild(instXML);
			return returnXML.toXMLString();
		}
		
		// Prints out all the info about the plot point
		public function toString(): String {
			return ("plot point toString() function needs to be updated to be real");
			var totalString:String = cifKnowledge.name + "\n";
			for each (var t:Number in cifKnowledge.traits) {
				totalString += "\t";
				totalString += Trait.getNameByNumber(t);
				totalString += "\n";
			}
			for each (var status:Status in cifKnowledge.statuses)
			{
				totalString += "\t";
				totalString += Status.getStatusNameByNumber(status.type);
				if (status.isDirected) totalString += " by " + status.directedToward;
				totalString += "\n";
			}
			return totalString;
		}
		
		public function clone():PlotPoint
		{
			var pp:PlotPoint = new PlotPoint();
			pp.setPlotPointName(this.cifKnowledge.name);
			// TODO: Put these back when preconditions on plot points are added
//			for each (var precon:Rule in this.preconditions) {
//				pp.preconditions.push(precon.clone());
//			}
			// NOTE: If a PP ever contains itself in story preconditions, this will be an infinite loop
			for each (var plotP:PlotPoint in this.storyPreConditions) {
				pp.storyPreConditions.push(plotP.clone());
			}
			// TODO: When this gets figured out, we will need to put this back
//			pp.timingIRS = this.timingIRS.clone();
			pp.activated = this.activated;
			for each (var inst:GrailInstantiation in this.instantiations) {
				pp.instantiations.push(inst.clone());
			}
			
			pp.cifKnowledge = this.cifKnowledge.clone();
			
			return pp;
		}
	}

}