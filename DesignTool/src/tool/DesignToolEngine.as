package tool
{
	import CiF.*;
	
	import grailgm.GrailGM;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;

	public class DesignToolEngine
	{
		[Bindable]
		private static var _instance:DesignToolEngine;
		public var cif:CiFSingleton;
		public var ggm:GrailGM;

		//data providers that are relatively constant
		public var predTypes:ArrayCollection = new ArrayCollection(); // list of available predicates
		public var intentTypes:ArrayCollection = new ArrayCollection(); // list of predicates available for intent formation
		public var knowledgeTypes:ArrayCollection = new ArrayCollection(); // list of knowledge available for predicates
		public var statusTypes:ArrayCollection = new ArrayCollection(); // list of statuses available for predicates
		public var networkTypes:ArrayCollection = new ArrayCollection(); // list of relationships available for predicates
		public var roleTypes:ArrayCollection = new ArrayCollection(); // list of who can fit the role
		public var compTypes:ArrayCollection = new ArrayCollection(); // list of comparison types for networks
		public var traitTypes:ArrayCollection = new ArrayCollection(); // list of traits
		public var networkOpTypes:ArrayCollection = new ArrayCollection(); // list of operator types on networks
		public var sfdbLabelTypes:ArrayCollection = new ArrayCollection(); // List of SFDB Labels for predicates
		public var ckbTruthTypes:ArrayCollection = new ArrayCollection(); // List of CKB truths for predicates
		public var ckbSubjectiveTypes:ArrayCollection = new ArrayCollection(); // List of CKB subjective opinions for predicates
		public var instantiationListDP:ArrayCollection = new ArrayCollection();
		public var questTypes:ArrayCollection = new ArrayCollection();
		public var knowledgeTraitTypes:ArrayCollection = new ArrayCollection();
		
		public function DesignToolEngine(){
			if (_instance != null) {
				throw new Error("DesignToolEngine can only be accessed through DesignToolEngine.getInstance()");
			}
			this.cif = CiFSingleton.getInstance();
			this.ggm = GrailGM.getInstance();
			//this.cif.defaultState();
//			this.tabAndAccordianLinkBoxValue = true;
		}
		
		public static function getInstance():DesignToolEngine {
			if (_instance == null)
				_instance = new DesignToolEngine();
			
			return _instance;
		}
		
		public function initializeDataProviders():void {
			this.predTypes = this.generatePredListProvider();
			this.intentTypes = this.generateIntentListProvider();
			this.knowledgeTypes = this.generateKnowledgeListProvider();
			this.statusTypes = this.generateStatusListProvider();
			this.networkTypes = this.generateNetworkListProvider();	
			this.roleTypes = this.generateRoleListProvider();
			this.compTypes = this.generateCompListProvider();
			this.traitTypes = this.generateTraitListProvider();
			this.networkOpTypes = this.generateNetworkOpListProvider();
			this.sfdbLabelTypes = this.generateSFDBLabelListProvider();
			this.ckbTruthTypes = this.generateCKBTruthListProvider();
			this.ckbSubjectiveTypes = this.generateCKBSubjectiveListProvider();
		    this.questTypes = this.generateTypeListProvider();
			this.knowledgeTraitTypes = this.generateKnowledgeTraitListProvider();
			
		}
		
		public function generateKnowledgeTraitListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = Trait.KNOWLEDGE + 1; i < Trait.KNOWLEDGE + Trait.TRAIT_COUNT_KNOWLEDGE; i++) {
				result.addItem(Trait.getNameByNumber(i));
			}
			
			return result;
		}
		
		public function generateCKBSubjectiveListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < CulturalKB.SUBJECTIVE_LABEL_COUNT ; ++i){
				result.addItem(CulturalKB.getSubjectiveNameByNumber(i));
			}
			return result;
		}
		
		public function generateCKBTruthListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < CulturalKB.TRUTH_LABEL_COUNT ; ++i){
				result.addItem(CulturalKB.getTruthNameByNumber(i));
			}
			return result;
		}
		
		public function generateSFDBLabelListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < SocialFactsDB.LABEL_COUNT ; ++i){
				result.addItem(SocialFactsDB.getLabelByNumber(i));
			}
			return result;
		}
		
		public function generatePlotPointListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < ggm.plotPointPool.plotPoints.length ; ++i){
				result.addItem(ggm.plotPointPool.plotPoints[i].name);
			}
			return result;
		}
		
		public function generateNetworkOpListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < Predicate.OPERATOR_COUNT; ++i) {
				result.addItem(Predicate.getOperatorByNumber(i));
			}
			return result;
			
		}
		
		public function generateTraitListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < Trait.TRAIT_COUNT; ++i) {
				result.addItem(Trait.getNameByNumber(i));
			}
			return result;
		}

		public function generateCompListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < Predicate.COMPARATOR_COUNT; ++i) {
				result.addItem(Predicate.getCompatorByNumber(i));
			}
			return result;
		}

		public function generateStatusListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < Status.STATUS_COUNT; ++i) {
				result.addItem(Status.getStatusNameByNumber(i));
			}
			
			return result;			
		}

		public function generateNetworkListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < SocialNetwork.NETWORK_COUNT ; ++i) {
				result.addItem(SocialNetwork.getNameFromType(i));
			}
			
			return result;			
		}
		
		public function generateKnowledgeListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < cif.knowledgeList.knowledges.length; ++i) {
				result.addItem(cif.knowledgeList.knowledges[i].name);
			}
			
			return result;			
		}
		
		public function generatePredListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < Predicate.TYPE_COUNT; ++i) {
				result.addItem(Predicate.getNameByType(i));
			}
			return result;
		}
		
		public function generateGameObjectListProvider():ArrayCollection{
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int=0; i<GameObject.NUM_TYPES; ++i){
				result.addItem(GameObject.getNameByNumber(i));
			}
			return result;
		}
		
		public function generateTypeListProvider():ArrayCollection{
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < grailgm.QuestType.QUEST_COUNT; ++i){
				result.addItem(grailgm.QuestType.getNameByNumber(i));
			}
			return result;
		}
		
		public function generateIntentListProvider(): ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < Predicate.NUM_INTENT_TYPES; ++i) {
				result.addItem(Predicate.getIntentNameByNumber(i));
			}
			return result;
		}

		public function generateRoleListProvider():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			result.addItem("initiator");
			result.addItem("responder");
			result.addItem("other");
			return result; 
		}

	}
}