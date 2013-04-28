/**
 * This is a generated sub-class of _RuleVO.as and is intended for behavior
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

import CiF.InfluenceRule;
import CiF.Rule;

import com.adobe.fiber.core.model_internal;

public class RuleVO extends _Super_RuleVO
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
        _Super_RuleVO.model_internal::initRemoteClassAliasSingle(valueObjects.RuleVO);
        _Super_RuleVO.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_RuleVO.model_internal::initRemoteClassAliasSingle(valueObjects.RuleVO);
    }
    
    {
        _Super_RuleVO.model_internal::initRemoteClassAliasSingle(valueObjects.RuleVO);
    }
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/
	
	public static var INTENTS:int = 0;
	
	public function init(rule:Rule, pid:int):void {
		parent_id = pid;
		name = rule.name;
		description = rule.description;
		if(rule is InfluenceRule)
			weight = (rule as InfluenceRule).weight;
		else
			weight = -1;
	}
	
	public function load(newRule:Rule):void
	{
		newRule.id = id;
		newRule.name=name;
		newRule.description = description;
		if(newRule is InfluenceRule)
		(newRule as InfluenceRule).weight = weight;
	}
}

}