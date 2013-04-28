/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - EffectVO.as.
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
public class _Super_EffectVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("EffectVO") == null)
            {
                flash.net.registerClassAlias("EffectVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("EffectVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _EffectVOEntityMetadata;
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
    private var _internal_gameID : int;
    private var _internal_referenceAsNaturalLanguage : String;
    private var _internal_isAccept : Boolean;
    private var _internal_instantiationID : int;
    private var _internal_rejectID : int;
    private var _internal_conditionRuleID : int;
    private var _internal_changeRuleID : int;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_EffectVO()
    {
        _model = new _EffectVOEntityMetadata(this);

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
    public function get gameID() : int
    {
        return _internal_gameID;
    }

    [Bindable(event="propertyChange")]
    public function get referenceAsNaturalLanguage() : String
    {
        return _internal_referenceAsNaturalLanguage;
    }

    [Bindable(event="propertyChange")]
    public function get isAccept() : Boolean
    {
        return _internal_isAccept;
    }

    [Bindable(event="propertyChange")]
    public function get instantiationID() : int
    {
        return _internal_instantiationID;
    }

    [Bindable(event="propertyChange")]
    public function get rejectID() : int
    {
        return _internal_rejectID;
    }

    [Bindable(event="propertyChange")]
    public function get conditionRuleID() : int
    {
        return _internal_conditionRuleID;
    }

    [Bindable(event="propertyChange")]
    public function get changeRuleID() : int
    {
        return _internal_changeRuleID;
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

    public function set gameID(value:int) : void
    {
        var oldValue:int = _internal_gameID;
        if (oldValue !== value)
        {
            _internal_gameID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "gameID", oldValue, _internal_gameID));
        }
    }

    public function set referenceAsNaturalLanguage(value:String) : void
    {
        var oldValue:String = _internal_referenceAsNaturalLanguage;
        if (oldValue !== value)
        {
            _internal_referenceAsNaturalLanguage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "referenceAsNaturalLanguage", oldValue, _internal_referenceAsNaturalLanguage));
        }
    }

    public function set isAccept(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_isAccept;
        if (oldValue !== value)
        {
            _internal_isAccept = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isAccept", oldValue, _internal_isAccept));
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

    public function set rejectID(value:int) : void
    {
        var oldValue:int = _internal_rejectID;
        if (oldValue !== value)
        {
            _internal_rejectID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rejectID", oldValue, _internal_rejectID));
        }
    }

    public function set conditionRuleID(value:int) : void
    {
        var oldValue:int = _internal_conditionRuleID;
        if (oldValue !== value)
        {
            _internal_conditionRuleID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "conditionRuleID", oldValue, _internal_conditionRuleID));
        }
    }

    public function set changeRuleID(value:int) : void
    {
        var oldValue:int = _internal_changeRuleID;
        if (oldValue !== value)
        {
            _internal_changeRuleID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "changeRuleID", oldValue, _internal_changeRuleID));
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
    public function get _model() : _EffectVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _EffectVOEntityMetadata) : void
    {
        var oldValue : _EffectVOEntityMetadata = model_internal::_dminternal_model;
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
