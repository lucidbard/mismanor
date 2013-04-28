/**
 * This is a generated sub-class of _SocialGameVO.as and is intended for behavior
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

import CiF.SocialGame;

import com.adobe.fiber.core.model_internal;

public class SocialGameVO extends _Super_SocialGameVO
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
        _Super_SocialGameVO.model_internal::initRemoteClassAliasSingle(valueObjects.SocialGameVO);
        _Super_SocialGameVO.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_SocialGameVO.model_internal::initRemoteClassAliasSingle(valueObjects.SocialGameVO);
    }
    
    {
        _Super_SocialGameVO.model_internal::initRemoteClassAliasSingle(valueObjects.SocialGameVO);
    }
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/    
	
	/**
	 * Initializes the game with the properties of the socialgame.
	 */
	public function init(sg:SocialGame, uid:int):void {
		author = uid;
		game_name = sg.name;
		requiresOther = sg.requiresOther;
		responderType = sg.responderType;
		otherType = sg.otherType;
		needsSecondOther = sg.needsSecondOther;
		thirdPartyTalkAboutSomeone = sg.thirdPartyTalkAboutSomeone;
		thirdPartyGetSomeoneToDoSomethingForYou = sg.thirdPartyGetSomeoneToDoSomethingForYou;
	}
	
	public function load(sg:SocialGame):void {
		sg.name=game_name;
		sg.requiresOther = requiresOther;
		sg.responderType = responderType;
		sg.otherType = otherType;
		sg.needsSecondOther = needsSecondOther;
		sg.thirdPartyTalkAboutSomeone = thirdPartyTalkAboutSomeone;
		sg.thirdPartyGetSomeoneToDoSomethingForYou =thirdPartyGetSomeoneToDoSomethingForYou;
	}
}

}