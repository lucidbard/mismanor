/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - LineOfDialogueVO.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_LineOfDialogueVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("LineOfDialogueVO") == null)
            {
                flash.net.registerClassAlias("LineOfDialogueVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("LineOfDialogueVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _LineOfDialogueVOEntityMetadata;
    model_internal var _changedObjects:mx.collections.ArrayCollection = new ArrayCollection();

    public function getChangedObjects() : Array
    {
        _changedObjects.addItemAt(this,0);
        return _changedObjects.source;
    }

    public function clearChangedObjects() : void
    {
        _changedObjects.removeAll();
    }

    /**
     * properties
     */
    private var _internal_id : int;
    private var _internal_instantiationID : int;
    private var _internal_lineNumber : int;
    private var _internal_initiatorLine : String;
    private var _internal_responderLine : String;
    private var _internal_otherLine : String;
    private var _internal_primarySpeaker : String;
    private var _internal_time : int;
    private var _internal_initiatorIsThought : Boolean;
    private var _internal_responderIsThought : Boolean;
    private var _internal_otherIsThought : Boolean;
    private var _internal_initiatorIsDelayed : Boolean;
    private var _internal_responderIsDelayed : Boolean;
    private var _internal_otherIsDelayed : Boolean;
    private var _internal_initiatorIsPicture : Boolean;
    private var _internal_responderIsPicture : Boolean;
    private var _internal_otherIsPicture : Boolean;
    private var _internal_initiatorAddressing : int;
    private var _internal_responderAddressing : int;
    private var _internal_otherAddressing : int;
    private var _internal_otherApproach : Boolean;
    private var _internal_otherExit : Boolean;
    private var _internal_isOtherChorus : Boolean;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_LineOfDialogueVO()
    {
        _model = new _LineOfDialogueVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get id() : int
    {
        return _internal_id;
    }

    [Bindable(event="propertyChange")]
    public function get instantiationID() : int
    {
        return _internal_instantiationID;
    }

    [Bindable(event="propertyChange")]
    public function get lineNumber() : int
    {
        return _internal_lineNumber;
    }

    [Bindable(event="propertyChange")]
    public function get initiatorLine() : String
    {
        return _internal_initiatorLine;
    }

    [Bindable(event="propertyChange")]
    public function get responderLine() : String
    {
        return _internal_responderLine;
    }

    [Bindable(event="propertyChange")]
    public function get otherLine() : String
    {
        return _internal_otherLine;
    }

    [Bindable(event="propertyChange")]
    public function get primarySpeaker() : String
    {
        return _internal_primarySpeaker;
    }

    [Bindable(event="propertyChange")]
    public function get time() : int
    {
        return _internal_time;
    }

    [Bindable(event="propertyChange")]
    public function get initiatorIsThought() : Boolean
    {
        return _internal_initiatorIsThought;
    }

    [Bindable(event="propertyChange")]
    public function get responderIsThought() : Boolean
    {
        return _internal_responderIsThought;
    }

    [Bindable(event="propertyChange")]
    public function get otherIsThought() : Boolean
    {
        return _internal_otherIsThought;
    }

    [Bindable(event="propertyChange")]
    public function get initiatorIsDelayed() : Boolean
    {
        return _internal_initiatorIsDelayed;
    }

    [Bindable(event="propertyChange")]
    public function get responderIsDelayed() : Boolean
    {
        return _internal_responderIsDelayed;
    }

    [Bindable(event="propertyChange")]
    public function get otherIsDelayed() : Boolean
    {
        return _internal_otherIsDelayed;
    }

    [Bindable(event="propertyChange")]
    public function get initiatorIsPicture() : Boolean
    {
        return _internal_initiatorIsPicture;
    }

    [Bindable(event="propertyChange")]
    public function get responderIsPicture() : Boolean
    {
        return _internal_responderIsPicture;
    }

    [Bindable(event="propertyChange")]
    public function get otherIsPicture() : Boolean
    {
        return _internal_otherIsPicture;
    }

    [Bindable(event="propertyChange")]
    public function get initiatorAddressing() : int
    {
        return _internal_initiatorAddressing;
    }

    [Bindable(event="propertyChange")]
    public function get responderAddressing() : int
    {
        return _internal_responderAddressing;
    }

    [Bindable(event="propertyChange")]
    public function get otherAddressing() : int
    {
        return _internal_otherAddressing;
    }

    [Bindable(event="propertyChange")]
    public function get otherApproach() : Boolean
    {
        return _internal_otherApproach;
    }

    [Bindable(event="propertyChange")]
    public function get otherExit() : Boolean
    {
        return _internal_otherExit;
    }

    [Bindable(event="propertyChange")]
    public function get isOtherChorus() : Boolean
    {
        return _internal_isOtherChorus;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set id(value:int) : void
    {
        var oldValue:int = _internal_id;
        if (oldValue !== value)
        {
            _internal_id = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }
    }

    public function set instantiationID(value:int) : void
    {
        var oldValue:int = _internal_instantiationID;
        if (oldValue !== value)
        {
            _internal_instantiationID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "instantiationID", oldValue, _internal_instantiationID));
        }
    }

    public function set lineNumber(value:int) : void
    {
        var oldValue:int = _internal_lineNumber;
        if (oldValue !== value)
        {
            _internal_lineNumber = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lineNumber", oldValue, _internal_lineNumber));
        }
    }

    public function set initiatorLine(value:String) : void
    {
        var oldValue:String = _internal_initiatorLine;
        if (oldValue !== value)
        {
            _internal_initiatorLine = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "initiatorLine", oldValue, _internal_initiatorLine));
        }
    }

    public function set responderLine(value:String) : void
    {
        var oldValue:String = _internal_responderLine;
        if (oldValue !== value)
        {
            _internal_responderLine = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "responderLine", oldValue, _internal_responderLine));
        }
    }

    public function set otherLine(value:String) : void
    {
        var oldValue:String = _internal_otherLine;
        if (oldValue !== value)
        {
            _internal_otherLine = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherLine", oldValue, _internal_otherLine));
        }
    }

    public function set primarySpeaker(value:String) : void
    {
        var oldValue:String = _internal_primarySpeaker;
        if (oldValue !== value)
        {
            _internal_primarySpeaker = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "primarySpeaker", oldValue, _internal_primarySpeaker));
        }
    }

    public function set time(value:int) : void
    {
        var oldValue:int = _internal_time;
        if (oldValue !== value)
        {
            _internal_time = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "time", oldValue, _internal_time));
        }
    }

    public function set initiatorIsThought(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_initiatorIsThought;
        if (oldValue !== value)
        {
            _internal_initiatorIsThought = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "initiatorIsThought", oldValue, _internal_initiatorIsThought));
        }
    }

    public function set responderIsThought(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_responderIsThought;
        if (oldValue !== value)
        {
            _internal_responderIsThought = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "responderIsThought", oldValue, _internal_responderIsThought));
        }
    }

    public function set otherIsThought(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_otherIsThought;
        if (oldValue !== value)
        {
            _internal_otherIsThought = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherIsThought", oldValue, _internal_otherIsThought));
        }
    }

    public function set initiatorIsDelayed(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_initiatorIsDelayed;
        if (oldValue !== value)
        {
            _internal_initiatorIsDelayed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "initiatorIsDelayed", oldValue, _internal_initiatorIsDelayed));
        }
    }

    public function set responderIsDelayed(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_responderIsDelayed;
        if (oldValue !== value)
        {
            _internal_responderIsDelayed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "responderIsDelayed", oldValue, _internal_responderIsDelayed));
        }
    }

    public function set otherIsDelayed(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_otherIsDelayed;
        if (oldValue !== value)
        {
            _internal_otherIsDelayed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherIsDelayed", oldValue, _internal_otherIsDelayed));
        }
    }

    public function set initiatorIsPicture(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_initiatorIsPicture;
        if (oldValue !== value)
        {
            _internal_initiatorIsPicture = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "initiatorIsPicture", oldValue, _internal_initiatorIsPicture));
        }
    }

    public function set responderIsPicture(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_responderIsPicture;
        if (oldValue !== value)
        {
            _internal_responderIsPicture = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "responderIsPicture", oldValue, _internal_responderIsPicture));
        }
    }

    public function set otherIsPicture(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_otherIsPicture;
        if (oldValue !== value)
        {
            _internal_otherIsPicture = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherIsPicture", oldValue, _internal_otherIsPicture));
        }
    }

    public function set initiatorAddressing(value:int) : void
    {
        var oldValue:int = _internal_initiatorAddressing;
        if (oldValue !== value)
        {
            _internal_initiatorAddressing = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "initiatorAddressing", oldValue, _internal_initiatorAddressing));
        }
    }

    public function set responderAddressing(value:int) : void
    {
        var oldValue:int = _internal_responderAddressing;
        if (oldValue !== value)
        {
            _internal_responderAddressing = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "responderAddressing", oldValue, _internal_responderAddressing));
        }
    }

    public function set otherAddressing(value:int) : void
    {
        var oldValue:int = _internal_otherAddressing;
        if (oldValue !== value)
        {
            _internal_otherAddressing = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherAddressing", oldValue, _internal_otherAddressing));
        }
    }

    public function set otherApproach(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_otherApproach;
        if (oldValue !== value)
        {
            _internal_otherApproach = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherApproach", oldValue, _internal_otherApproach));
        }
    }

    public function set otherExit(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_otherExit;
        if (oldValue !== value)
        {
            _internal_otherExit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherExit", oldValue, _internal_otherExit));
        }
    }

    public function set isOtherChorus(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_isOtherChorus;
        if (oldValue !== value)
        {
            _internal_isOtherChorus = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isOtherChorus", oldValue, _internal_isOtherChorus));
        }
    }

    /**
     * Data/source property setter listeners
     *
     * Each data property whose value affects other properties or the validity of the entity
     * needs to invalidate all previously calculated artifacts. These include:
     *  - any derived properties or constraints that reference the given data property.
     *  - any availability guards (variant expressions) that reference the given data property.
     *  - any style validations, message tokens or guards that reference the given data property.
     *  - the validity of the property (and the containing entity) if the given data property has a length restriction.
     *  - the validity of the property (and the containing entity) if the given data property is required.
     */


    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();
        var validationFailureMessages:Array = new Array();

        var propertyValidity:Boolean = true;

        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && propertyValidity;
    }

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
        var oldValue:Boolean = model_internal::_isValid;
        if (oldValue !== value)
        {
            model_internal::_isValid = value;
            _model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }
    }

    /**
     * derived property getters
     */

    [Transient]
    [Bindable(event="propertyChange")]
    public function get _model() : _LineOfDialogueVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _LineOfDialogueVOEntityMetadata) : void
    {
        var oldValue : _LineOfDialogueVOEntityMetadata = model_internal::_dminternal_model;
        if (oldValue !== value)
        {
            model_internal::_dminternal_model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }
    }

    /**
     * methods
     */


    /**
     *  services
     */
    private var _managingService:com.adobe.fiber.services.IFiberManagingService;

    public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
    {
        _managingService = managingService;
    }

    model_internal function set invalidConstraints_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_invalidConstraints;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;
            _model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);
        }
    }

    model_internal function set validationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_validationFailureMessages;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;
            _model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);
        }
    }


}

}
