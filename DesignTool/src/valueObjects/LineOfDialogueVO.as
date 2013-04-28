/**
 * This is a generated sub-class of _LineOfDialogueVO.as and is intended for behavior
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

import CiF.LineOfDialogue;

import com.adobe.fiber.core.model_internal;

public class LineOfDialogueVO extends _Super_LineOfDialogueVO
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
        _Super_LineOfDialogueVO.model_internal::initRemoteClassAliasSingle(valueObjects.LineOfDialogueVO);
        _Super_LineOfDialogueVO.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_LineOfDialogueVO.model_internal::initRemoteClassAliasSingle(valueObjects.LineOfDialogueVO);
    }
    
    {
        _Super_LineOfDialogueVO.model_internal::initRemoteClassAliasSingle(valueObjects.LineOfDialogueVO);
    }
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/    
	
	public function init(lod:LineOfDialogue, instId:int):void
	{
		instantiationID = instId;
		lineNumber = lod.lineNumber;
		initiatorLine = lod.initiatorLine;
		responderLine = lod.responderLine;
		otherLine = lod.otherLine;
		primarySpeaker = lod.primarySpeaker;
		time = lod.time;
		initiatorIsThought = lod.initiatorIsThought;
		responderIsThought = lod.responderIsThought;
		otherIsThought = lod.otherIsThought;
		initiatorIsDelayed = lod.initiatorIsDelayed;
		responderIsDelayed = lod.responderIsDelayed;
		otherIsDelayed = lod.otherIsDelayed;
		initiatorIsPicture = lod.initiatorIsPicture;
		responderIsPicture = lod.responderIsPicture;
		otherIsPicture = lod.otherIsPicture;
		switch(lod.initiatorAddressing) {
			case "initiator": 
				initiatorAddressing = 1;
				break;
			case "responder":
				initiatorAddressing = 2;
				break;
			case "other":
				initiatorAddressing = 3;
				break;
		}
		switch(lod.responderAddressing) {
			case "initiator": 
				responderAddressing = 1;
				break;
			case "responder":
				responderAddressing = 2;
				break;
			case "other":
				responderAddressing = 3;
				break;
		}
		switch(lod.otherAddressing) {
			case "initiator": 
				otherAddressing = 1;
				break;
			case "responder":
				otherAddressing = 2;
				break;
			case "other":
				otherAddressing = 3;
				break;
		}
		otherApproach = lod.otherApproach;
		otherExit = lod.otherExit;
		isOtherChorus = lod.isOtherChorus;
		
		
	}
	
	public function load(lod:LineOfDialogue):void
	{
		lod.lineNumber = lineNumber;
		lod.initiatorLine = initiatorLine;
		lod.responderLine = responderLine;
		lod.otherLine = otherLine;
		lod.primarySpeaker = primarySpeaker;
		lod.time = time;
		lod.initiatorIsThought = initiatorIsThought;
		lod.responderIsThought = responderIsThought;
		lod.otherIsThought = otherIsThought;
		lod.initiatorIsDelayed = initiatorIsDelayed;
		lod.responderIsDelayed = responderIsDelayed;
		lod.otherIsDelayed = otherIsDelayed;
		lod.initiatorIsPicture = initiatorIsPicture;
		lod.responderIsPicture = responderIsPicture;
		lod.otherIsPicture = otherIsPicture;
		switch(initiatorAddressing) {
			case 1: 
				lod.initiatorAddressing = "initiator";
				break;
			case 2:
				lod.initiatorAddressing = "responder";
				break;
			case 3:
				lod.initiatorAddressing = "other";
				break;
		}
		switch(responderAddressing) {
			case 1: 
				lod.responderAddressing = "initiator";
				break;
			case 2:
				lod.responderAddressing = "responder";
				break;
			case 3:
				lod.responderAddressing = "other";
				break;
		}
		switch(otherAddressing) {
			case 1: 
				lod.otherAddressing = "initiator";
				break;
			case 2:
				lod.otherAddressing = "responder";
				break;
			case 3:
				lod.otherAddressing = "other";
				break;
		}
		lod.otherApproach = otherApproach;
		lod.otherExit = otherExit;
		lod.isOtherChorus = isOtherChorus;
		
	}
}

}