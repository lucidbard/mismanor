
/**
 * This is a generated class and is not intended for modification.  
 */
package valueObjects
{
import com.adobe.fiber.styles.IStyle;
import com.adobe.fiber.styles.Style;
import com.adobe.fiber.valueobjects.AbstractEntityMetadata;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IModelType;
import mx.events.PropertyChangeEvent;

use namespace model_internal;

[ExcludeClass]
internal class _LineOfDialogueVOEntityMetadata extends com.adobe.fiber.valueobjects.AbstractEntityMetadata
{
    private static var emptyArray:Array = new Array();

    model_internal static var allProperties:Array = new Array("id", "instantiationID", "lineNumber", "initiatorLine", "responderLine", "otherLine", "primarySpeaker", "time", "initiatorIsThought", "responderIsThought", "otherIsThought", "initiatorIsDelayed", "responderIsDelayed", "otherIsDelayed", "initiatorIsPicture", "responderIsPicture", "otherIsPicture", "initiatorAddressing", "responderAddressing", "otherAddressing", "otherApproach", "otherExit", "isOtherChorus");
    model_internal static var allAssociationProperties:Array = new Array();
    model_internal static var allRequiredProperties:Array = new Array();
    model_internal static var allAlwaysAvailableProperties:Array = new Array("id", "instantiationID", "lineNumber", "initiatorLine", "responderLine", "otherLine", "primarySpeaker", "time", "initiatorIsThought", "responderIsThought", "otherIsThought", "initiatorIsDelayed", "responderIsDelayed", "otherIsDelayed", "initiatorIsPicture", "responderIsPicture", "otherIsPicture", "initiatorAddressing", "responderAddressing", "otherAddressing", "otherApproach", "otherExit", "isOtherChorus");
    model_internal static var guardedProperties:Array = new Array();
    model_internal static var dataProperties:Array = new Array("id", "instantiationID", "lineNumber", "initiatorLine", "responderLine", "otherLine", "primarySpeaker", "time", "initiatorIsThought", "responderIsThought", "otherIsThought", "initiatorIsDelayed", "responderIsDelayed", "otherIsDelayed", "initiatorIsPicture", "responderIsPicture", "otherIsPicture", "initiatorAddressing", "responderAddressing", "otherAddressing", "otherApproach", "otherExit", "isOtherChorus");
    model_internal static var sourceProperties:Array = emptyArray
    model_internal static var nonDerivedProperties:Array = new Array("id", "instantiationID", "lineNumber", "initiatorLine", "responderLine", "otherLine", "primarySpeaker", "time", "initiatorIsThought", "responderIsThought", "otherIsThought", "initiatorIsDelayed", "responderIsDelayed", "otherIsDelayed", "initiatorIsPicture", "responderIsPicture", "otherIsPicture", "initiatorAddressing", "responderAddressing", "otherAddressing", "otherApproach", "otherExit", "isOtherChorus");
    model_internal static var derivedProperties:Array = new Array();
    model_internal static var collectionProperties:Array = new Array();
    model_internal static var collectionBaseMap:Object;
    model_internal static var entityName:String = "LineOfDialogueVO";
    model_internal static var dependentsOnMap:Object;
    model_internal static var dependedOnServices:Array = new Array();
    model_internal static var propertyTypeMap:Object;


    model_internal var _instance:_Super_LineOfDialogueVO;
    model_internal static var _nullStyle:com.adobe.fiber.styles.Style = new com.adobe.fiber.styles.Style();

    public function _LineOfDialogueVOEntityMetadata(value : _Super_LineOfDialogueVO)
    {
        // initialize property maps
        if (model_internal::dependentsOnMap == null)
        {
            // dependents map
            model_internal::dependentsOnMap = new Object();
            model_internal::dependentsOnMap["id"] = new Array();
            model_internal::dependentsOnMap["instantiationID"] = new Array();
            model_internal::dependentsOnMap["lineNumber"] = new Array();
            model_internal::dependentsOnMap["initiatorLine"] = new Array();
            model_internal::dependentsOnMap["responderLine"] = new Array();
            model_internal::dependentsOnMap["otherLine"] = new Array();
            model_internal::dependentsOnMap["primarySpeaker"] = new Array();
            model_internal::dependentsOnMap["time"] = new Array();
            model_internal::dependentsOnMap["initiatorIsThought"] = new Array();
            model_internal::dependentsOnMap["responderIsThought"] = new Array();
            model_internal::dependentsOnMap["otherIsThought"] = new Array();
            model_internal::dependentsOnMap["initiatorIsDelayed"] = new Array();
            model_internal::dependentsOnMap["responderIsDelayed"] = new Array();
            model_internal::dependentsOnMap["otherIsDelayed"] = new Array();
            model_internal::dependentsOnMap["initiatorIsPicture"] = new Array();
            model_internal::dependentsOnMap["responderIsPicture"] = new Array();
            model_internal::dependentsOnMap["otherIsPicture"] = new Array();
            model_internal::dependentsOnMap["initiatorAddressing"] = new Array();
            model_internal::dependentsOnMap["responderAddressing"] = new Array();
            model_internal::dependentsOnMap["otherAddressing"] = new Array();
            model_internal::dependentsOnMap["otherApproach"] = new Array();
            model_internal::dependentsOnMap["otherExit"] = new Array();
            model_internal::dependentsOnMap["isOtherChorus"] = new Array();

            // collection base map
            model_internal::collectionBaseMap = new Object();
        }

        // Property type Map
        model_internal::propertyTypeMap = new Object();
        model_internal::propertyTypeMap["id"] = "int";
        model_internal::propertyTypeMap["instantiationID"] = "int";
        model_internal::propertyTypeMap["lineNumber"] = "int";
        model_internal::propertyTypeMap["initiatorLine"] = "String";
        model_internal::propertyTypeMap["responderLine"] = "String";
        model_internal::propertyTypeMap["otherLine"] = "String";
        model_internal::propertyTypeMap["primarySpeaker"] = "String";
        model_internal::propertyTypeMap["time"] = "int";
        model_internal::propertyTypeMap["initiatorIsThought"] = "Boolean";
        model_internal::propertyTypeMap["responderIsThought"] = "Boolean";
        model_internal::propertyTypeMap["otherIsThought"] = "Boolean";
        model_internal::propertyTypeMap["initiatorIsDelayed"] = "Boolean";
        model_internal::propertyTypeMap["responderIsDelayed"] = "Boolean";
        model_internal::propertyTypeMap["otherIsDelayed"] = "Boolean";
        model_internal::propertyTypeMap["initiatorIsPicture"] = "Boolean";
        model_internal::propertyTypeMap["responderIsPicture"] = "Boolean";
        model_internal::propertyTypeMap["otherIsPicture"] = "Boolean";
        model_internal::propertyTypeMap["initiatorAddressing"] = "int";
        model_internal::propertyTypeMap["responderAddressing"] = "int";
        model_internal::propertyTypeMap["otherAddressing"] = "int";
        model_internal::propertyTypeMap["otherApproach"] = "Boolean";
        model_internal::propertyTypeMap["otherExit"] = "Boolean";
        model_internal::propertyTypeMap["isOtherChorus"] = "Boolean";

        model_internal::_instance = value;
    }

    override public function getEntityName():String
    {
        return model_internal::entityName;
    }

    override public function getProperties():Array
    {
        return model_internal::allProperties;
    }

    override public function getAssociationProperties():Array
    {
        return model_internal::allAssociationProperties;
    }

    override public function getRequiredProperties():Array
    {
         return model_internal::allRequiredProperties;   
    }

    override public function getDataProperties():Array
    {
        return model_internal::dataProperties;
    }

    public function getSourceProperties():Array
    {
        return model_internal::sourceProperties;
    }

    public function getNonDerivedProperties():Array
    {
        return model_internal::nonDerivedProperties;
    }

    override public function getGuardedProperties():Array
    {
        return model_internal::guardedProperties;
    }

    override public function getUnguardedProperties():Array
    {
        return model_internal::allAlwaysAvailableProperties;
    }

    override public function getDependants(propertyName:String):Array
    {
       if (model_internal::nonDerivedProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a data property of entity LineOfDialogueVO");
            
       return model_internal::dependentsOnMap[propertyName] as Array;  
    }

    override public function getDependedOnServices():Array
    {
        return model_internal::dependedOnServices;
    }

    override public function getCollectionProperties():Array
    {
        return model_internal::collectionProperties;
    }

    override public function getCollectionBase(propertyName:String):String
    {
        if (model_internal::collectionProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a collection property of entity LineOfDialogueVO");

        return model_internal::collectionBaseMap[propertyName];
    }
    
    override public function getPropertyType(propertyName:String):String
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a property of LineOfDialogueVO");

        return model_internal::propertyTypeMap[propertyName];
    }

    override public function getAvailableProperties():com.adobe.fiber.valueobjects.IPropertyIterator
    {
        return new com.adobe.fiber.valueobjects.AvailablePropertyIterator(this);
    }

    override public function getValue(propertyName:String):*
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " does not exist for entity LineOfDialogueVO");
        }

        return model_internal::_instance[propertyName];
    }

    override public function setValue(propertyName:String, value:*):void
    {
        if (model_internal::nonDerivedProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " is not a modifiable property of entity LineOfDialogueVO");
        }

        model_internal::_instance[propertyName] = value;
    }

    override public function getMappedByProperty(associationProperty:String):String
    {
        switch(associationProperty)
        {
            default:
            {
                return null;
            }
        }
    }

    override public function getPropertyLength(propertyName:String):int
    {
        switch(propertyName)
        {
            default:
            {
                return 0;
            }
        }
    }

    override public function isAvailable(propertyName:String):Boolean
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " does not exist for entity LineOfDialogueVO");
        }

        if (model_internal::allAlwaysAvailableProperties.indexOf(propertyName) != -1)
        {
            return true;
        }

        switch(propertyName)
        {
            default:
            {
                return true;
            }
        }
    }

    override public function getIdentityMap():Object
    {
        var returnMap:Object = new Object();

        return returnMap;
    }

    [Bindable(event="propertyChange")]
    override public function get invalidConstraints():Array
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_invalidConstraints;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_invalidConstraints;        
        }
    }

    [Bindable(event="propertyChange")]
    override public function get validationFailureMessages():Array
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_validationFailureMessages;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_validationFailureMessages;
        }
    }

    override public function getDependantInvalidConstraints(propertyName:String):Array
    {
        var dependants:Array = getDependants(propertyName);
        if (dependants.length == 0)
        {
            return emptyArray;
        }

        var currentlyInvalid:Array = invalidConstraints;
        if (currentlyInvalid.length == 0)
        {
            return emptyArray;
        }

        var filterFunc:Function = function(element:*, index:int, arr:Array):Boolean
        {
            return dependants.indexOf(element) > -1;
        }

        return currentlyInvalid.filter(filterFunc);
    }

    /**
     * isValid
     */
    [Bindable(event="propertyChange")] 
    public function get isValid() : Boolean
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_isValid;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_isValid;
        }
    }

    [Bindable(event="propertyChange")]
    public function get isIdAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isInstantiationIDAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isLineNumberAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isInitiatorLineAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isResponderLineAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherLineAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isPrimarySpeakerAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isTimeAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isInitiatorIsThoughtAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isResponderIsThoughtAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherIsThoughtAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isInitiatorIsDelayedAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isResponderIsDelayedAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherIsDelayedAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isInitiatorIsPictureAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isResponderIsPictureAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherIsPictureAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isInitiatorAddressingAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isResponderAddressingAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherAddressingAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherApproachAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherExitAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isIsOtherChorusAvailable():Boolean
    {
        return true;
    }


    /**
     * derived property recalculation
     */

    model_internal function fireChangeEvent(propertyName:String, oldValue:Object, newValue:Object):void
    {
        this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, propertyName, oldValue, newValue));
    }

    [Bindable(event="propertyChange")]   
    public function get idStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get instantiationIDStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get lineNumberStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get initiatorLineStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get responderLineStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherLineStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get primarySpeakerStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get timeStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get initiatorIsThoughtStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get responderIsThoughtStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherIsThoughtStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get initiatorIsDelayedStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get responderIsDelayedStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherIsDelayedStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get initiatorIsPictureStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get responderIsPictureStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherIsPictureStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get initiatorAddressingStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get responderAddressingStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherAddressingStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherApproachStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get otherExitStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get isOtherChorusStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }


     /**
     * 
     * @inheritDoc 
     */ 
     override public function getStyle(propertyName:String):com.adobe.fiber.styles.IStyle
     {
         switch(propertyName)
         {
            default:
            {
                return null;
            }
         }
     }
     
     /**
     * 
     * @inheritDoc 
     *  
     */  
     override public function getPropertyValidationFailureMessages(propertyName:String):Array
     {
         switch(propertyName)
         {
            default:
            {
                return emptyArray;
            }
         }
     }

}

}
