package grailgm 
{
	import CiF.Instantiation;
	import CiF.LineOfDialogue;
	import CiF.Trait;
	/**
	 * ...
	 * @author Anne Sullivan
	 */
	public class PlotPointPool 
	{
		public var plotPoints:Vector.<PlotPoint> = new Vector.<PlotPoint>();

		// plot points that are possible based on the DAG
		// this is updated every time a plot point is activated (used)
		public var possiblePlotPoints:Vector.<PlotPoint> = new Vector.<PlotPoint>();
		public var activePlotPoints:Vector.<PlotPoint> = new Vector.<PlotPoint>(); // empty list means none active
		public var selectedPlotPoint:PlotPoint;
		
		// weights
		public var storyCohesion:Number = 0.1;
		public var plotMixing:Number = 0.6;
		public var plotConcentration:Number = 0.3;
		public var linesFound:Vector.<Number> = new Vector.<Number>();
		public var totalPlotPoints:Number;
		
		// keeps track of how long since last plot point - used for weighting quest availability
		public var movesSinceLast:Number = 0; 
		
		public function PlotPointPool() 
		{
			
		}
		
		public function clean(): void {
			var plotpoint:PlotPoint;
			
			if (this.plotPoints)
			{
				for each (plotpoint in this.plotPoints)
				{
					plotpoint.clean();
					plotpoint = null;
				}
				this.plotPoints = null;
			}
			
			if (this.possiblePlotPoints)
			{
				for each (plotpoint in this.possiblePlotPoints)
				{
					plotpoint.clean();
					plotpoint = null;
				}
				this.possiblePlotPoints = null;
			}
			
			if (this.activePlotPoints)
			{
				for each (plotpoint in this.activePlotPoints)
				{
					plotpoint.clean();
					plotpoint = null;
				}
				this.activePlotPoints = null;
			}
			
			if (this.selectedPlotPoint)
				this.selectedPlotPoint.clean();
			selectedPlotPoint = null;
			
			linesFound = null;		
		}
		
		public function getPlotPointByName(plotPointName:String): PlotPoint
		{
			var lowerName:String = plotPointName.toLowerCase();
			
			for each (var pp: PlotPoint in this.plotPoints)
			{
				if (pp.name.toLowerCase() == lowerName)
					return pp;
			}
			
			trace("plot point " + plotPointName + " not found\n");
			return null;
		}

		// Mark selected plot point as used
		public function plotPointUsed(): void
		{
			var ggm:GrailGM = GrailGM.getInstance();
			
			// if a plot point has been selected
			if (this.selectedPlotPoint)
			{
				// mark it as activated and remove it from the active plot point list
				selectedPlotPoint.activated = true;
				ggm.plotPointFound = true;
				ggm.plotPointUsedName = selectedPlotPoint.name;
				
				var index:int = this.activePlotPoints.indexOf(selectedPlotPoint);
				
				if (index >= 0)
					this.activePlotPoints.splice(index, 1);
					
				// null it out as nothing is now selected
				this.selectedPlotPoint = null;
				
				// update plotmixing and plotconcentration weights (they change as the story progresses)
				if (plotMixing > 0.3)
				{
					plotMixing -= 2 / totalPlotPoints;
					plotConcentration += 2 / totalPlotPoints;
					
				}
			}

		}
		
		// update the list of active plot points
		public function updateActive(): void
		{
			// TODO: Maybe shouldn't clear it out every time? If not, then when making possible plot points, check if they're in active so you don't get duplicates
			this.activePlotPoints = new Vector.<PlotPoint>();
			
			for each (var plotPoint:PlotPoint in possiblePlotPoints)
			{
				var cohesion:Number = 0;
				
				// Story Cohesion - Higher weights on story elements with the most pre-reqs met
				// Traverse the pre-conditions of the plot points, adding one point for every pre-condition met. Don't have to check activated because if it's a possible plot point
				// that means the preconditions have been met
				cohesion = plotPoint.traversePreCons();
				cohesion *= storyCohesion;
				
				var mixing:Number = 0;
				var concentration:Number = 0;
				
				// Storyline Mixing - Higher weights on plot points from different LINE traits (stronger weights at the beginning of the game)
				// Keep track of which *_LINE plot points have been coming from. 
				// Storyline Concentration - Higher weights on plot points from same LINE traits (stronger weights at the end of the game)
				// Keep track of which *_LINE plot points have been coming from. 1 point if covered last turn, .5 in 2 turns, .25 in 3 turns.
				
				var traitLines:Vector.<Number> = new Vector.<Number>();
				for each (var trait:Number in plotPoint.cifKnowledge.traits)
				{
					if (trait >= Trait.FIRST_LINE_TRAIT && trait <= Trait.LAST_LINE_TRAIT)
					{
						traitLines.push(trait);
						
						// see if line is already in linesFound and keep track of the position
						var position:Number = 0;
						for each (var line:Number in linesFound)
						{
							if (line == trait)
							{
								concentration = mixing += Math.pow(0.5, position);
							}
							
							position++;
						}
					}
				}
				// normalize for number of *_LINE traits
				mixing = mixing / traitLines.length;
				mixing *= -1; // negative weight
				mixing *= plotMixing;
				
				concentration = concentration / traitLines.length;
				concentration *= plotConcentration;
				
				plotPoint.weight = cohesion + mixing + concentration;
			}	 

			// returning -1, 0, 1
			var plotPointSort:Function = function (a:PlotPoint, b:PlotPoint) : int
			{
				var result:int;
				if (a.weight > b.weight) {
					result = -1;
				} else if (a.weight < b.weight) {
					result =  1;    
				} else {
					result 0;
				}
				return result;
			}
			
			this.possiblePlotPoints.sort(plotPointSort);
			
			// take the top 3 highest rated plot points
			while (this.activePlotPoints.length < 3 && this.possiblePlotPoints.length > 0)
			{
				this.activePlotPoints.push(this.possiblePlotPoints[0]);
				this.possiblePlotPoints.splice(0, 1);
			}
		}
		
		// global mix-in called, insert plot point dialogue if available
		public function plotPointMixIn(initiator:String, responder:String, lod:LineOfDialogue, lineNumber:Number, piece:String, dialog:Instantiation):void
		{
			var instantiation:GrailInstantiation;
			var matchedLine:Boolean = false;
			var plod:LineOfDialogue;
			var instID:Number;
			var resultStr:String = "";
			
			// TODO: Put in some logic so that plot points don't happen every move
			
			// search for one of the plot point string markers
			instID = GrailInstantiation.getIDByName(piece);
			
			if (instID >= 0)
			{
				matchedLine = true;
				
				// if there are any active plot points
				if (activePlotPoints.length > 0 && GrailGM.getInstance().movesSincePlotPoint > 5)
				{
					// get one that matches the speaker and type of instantiation
					instantiation = this.getInstantiation(responder, instID);
					
					// if we find one that matches the speaker and type of instantiation, mix it into the dialogue
					if (instantiation)
					{
						for each (plod in instantiation.cifInstantiation.lines)
							dialog.lines.splice(++lineNumber, 0, plod);
							
						GrailGM.getInstance().plotPointFound = true;
					}
				}

				// update dialog with our changes
				dialog.lines.splice(dialog.lines.indexOf(lod), 1);
			}
		}
		
		public function updatePool(): void
		{
			if (this.selectedPlotPoint && !this.selectedPlotPoint.isEndGame())
			{
				// keep track of which line the plot point was a part of
				for (var i:Number = 0; i < this.selectedPlotPoint.cifKnowledge.traits.length; i++)
				{
					if (this.selectedPlotPoint.cifKnowledge.traits[i] >= Trait.FIRST_LINE_TRAIT && 
						this.selectedPlotPoint.cifKnowledge.traits[i] <= Trait.LAST_LINE_TRAIT)
					{
						this.linesFound.push(this.selectedPlotPoint.cifKnowledge.traits[i]);
					}
				}
				// mark plot point as used
				this.plotPointUsed();
				// update the possible plot points
				this.updatePossible();
				// get a new active plot point on the roster if necessary
				this.updateActive();
			}
			else if (this.selectedPlotPoint && this.selectedPlotPoint.isEndGame())
			{
				this.plotPointUsed();
				GrailGM.getInstance().endGame = true;
			}
		
		}
		
		// go through active plot points, and find the highest weighted instantiation that matches
		public function getInstantiation(responder:String, type:Number):GrailInstantiation
		{
			var matchingInst:Vector.<GrailInstantiation> = new Vector.<GrailInstantiation>();
			var matchingPlotPoints:Vector.<PlotPoint> = new Vector.<PlotPoint>();
			
			for each (var pp:PlotPoint in this.activePlotPoints)
			{
				var instantiation:GrailInstantiation;
				
				instantiation = pp.getInstantiationBySpeakerAndType(responder, type);
				if (instantiation)
				{
					matchingInst.push(instantiation);
					matchingPlotPoints.push(pp);
				}
			}
			
			// TODO: Add some weighting instead of using random
			if (matchingInst.length > 0)
			{
				var rnd:int = Math.floor(Math.random() * (matchingInst.length));
				
				this.selectedPlotPoint = matchingPlotPoints[rnd];
				return matchingInst[rnd];
			}
			return null;
		}
		
		// should be called every time a plot point is activated
		public function updatePossible(): void
		{
			// start fresh
			possiblePlotPoints = new Vector.<PlotPoint>();
			
			// check the story pre-conditions of all plot points that have not already been activated
			// if pre-reqs are met, add to possiblePlotPoints list
			for each (var pp: PlotPoint in plotPoints)
			{
				
				// check if already activated
				if (!pp.activated)
				{
					// check pre-reqs
					if (pp.evaluateStoryReqs())
						possiblePlotPoints.push(pp);
				}
			}
		}
		
		public function toXMLString():String {
			var resultXML:String;
			
			resultXML = "<PlotPointList>\n";
			for each (var pp:PlotPoint in plotPoints) resultXML += pp.toXMLString();
			resultXML += "\n</PlotPointList>";
			
			return resultXML;
			
		}
		
	}

}