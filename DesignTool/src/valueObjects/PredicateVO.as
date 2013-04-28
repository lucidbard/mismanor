/**
 * This is a generated sub-class of _PredicateVO.as and is intended for behavior
 * customization.  This class is only generated when there is no file already present
 * at its target location.  Thus custom behavior that you add here will survive regeneration
 * of the super-class. 
 *
 * NOTE: Do not manually modify the RemoteClass mapping unless
 * your server representation of this class has changed and you've 
 * updated your ActionScriptGeneration,RemoteClass annotation on the
 * corresponding entity 
 **/ 
 
package valueObjects
{

import CiF.Predicate;
import CiF.Trait;

import com.adobe.fiber.core.model_internal;

public class PredicateVO extends _Super_PredicateVO
{
    /** 
     * DO NOT MODIFY THIS STATIC INITIALIZER - IT IS NECESSARY
     * FOR PROPERLY SETTING UP THE REMOTE CLASS ALIAS FOR THIS CLASS
     *
     **/
     
    /**
     * Calling this static function will initialize RemoteClass aliases
     * for this value object as well as all of the value objects corresponding
     * to entities associated to this value object's entity.  
     */     
    public static function _initRemoteClassAlias() : void
    {
        _Super_PredicateVO.model_internal::initRemoteClassAliasSingle(valueObjects.PredicateVO);
        _Super_PredicateVO.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_PredicateVO.model_internal::initRemoteClassAliasSingle(valueObjects.PredicateVO);
    }
    
    {
        _Super_PredicateVO.model_internal::initRemoteClassAliasSingle(valueObjects.PredicateVO);
    }
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/    
	
	public function init(pred:Predicate, ruleID:int):void
	{
		name=pred.name;
		description = pred.description;
		ruleId = ruleID;
		type = pred.type;
		switch(pred.primary) {
			case "initiator":
				first=0;
				break;
			case "responder":
				first=1;
				break
			case "other":
				first=2;
				break;
		}
		switch(pred.secondary) {
			case "initiator":
				second=0;
				break;
			case "responder":
				second=1;
				break
			case "other":
				second=2;
				break;
		}
		switch(pred.tertiary) {
			case "initiator":
				third=0;
				break;
			case "responder":
				third=1;
				break
			case "other":
				third=2;
				break;
		}
		comparator = pred.comparator;
		negated = pred.negated;
		statusDuration = pred.statusDuration;
		intent = pred.intent;
		intentType = pred.intentType;
		isSFDB = pred.isSFDB;
		sfdbOrder = pred.sfdbOrder;
		window = pred.window;
		numTimesUniquelyTrueFlag = pred.numTimesUniquelyTrueFlag;
		numTimesUniquelyTrue = pred.numTimesUniquelyTrue;
		numTimesRoleSlot = pred.numTimesRoleSlot;
		networkType = pred.networkType;
		networkValue = pred.networkValue;
		status = pred.status;
		firstSubjective = pred.firstSubjectiveLink;
		secondSubjective =  pred.secondSubjectiveLink;
		operator = pred.operator;
		knowledge = pred.knowledge;
		sfdbLabel = pred.sfdbLabel;
		
	}
	
	public function load(pred:Predicate):void
	{
		pred.name=name;
		pred.description = description;
		pred.comparator = comparator;
		pred.operator = operator;
		var primary:String, secondary:String, tertiary:String;
		switch(first) {
			case 0:
				primary = "initiator";
				break;
			case 1:
				primary="responder";
				break
			case 2:
				primary ="other";
				break;
		}
		switch(second) {
			case 0:
				secondary = "initiator";
				break;
			case 1:
				secondary = "responder";
				break
			case 2:
				secondary = "other";
				break;
		}
		switch(third) {
			case 0:
				tertiary = "initiator";
				break;
			case 1:
				tertiary = "responder";
				break
			case 2:
				tertiary = "other";
				break;
		}
		if(type == Predicate.TRAIT) {
			pred.setTraitPredicate(primary, trait, negated, isSFDB);
		} else if (type == Predicate.NETWORK) {
			pred.setNetworkPredicate(primary, secondary, operator, networkValue, networkType, negated, isSFDB);
		} else if (type == Predicate.STATUS) {
			pred.setStatusPredicate(primary, secondary,status,negated,statusDuration,isSFDB);
		}/* else if (type == Predicate.CKBENTRY) {
			pred.setCKBPredicate(primary, secondary, firstSubjective,secondSubjective,sfdbLabel, negated);
		}*/ else if (type == Predicate.SFDBLABEL) {
			pred.setSFDBLabelPredicate(primary,secondary,sfdbLabel,negated,window);
		}
		if(intent){ 
			pred.intent = true;
			pred.intentType = intentType;
		}
		
		pred.numTimesUniquelyTrueFlag = numTimesUniquelyTrueFlag;
		pred.numTimesUniquelyTrue = numTimesUniquelyTrue;
		pred.sfdbOrder = sfdbOrder;
		
	}
}

}