/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - PredicateVO.as.
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
public class _Super_PredicateVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("PredicateVO") == null)
            {
                flash.net.registerClassAlias("PredicateVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("PredicateVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _PredicateVOEntityMetadata;
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
    private var _internal_description : String;
    private var _internal_type : int;
    private var _internal_trait : int;
    private var _internal_first : int;
    private var _internal_second : int;
    private var _internal_third : int;
    private var _internal_comparator : String;
    private var _internal_operator : String;
    private var _internal_knowledge : int;
    private var _internal_negated : Boolean;
    private var _internal_statusDuration : int;
    private var _internal_name : String;
    private var _internal_intent : Boolean;
    private var _internal_intentType : int;
    private var _internal_isSFDB : Boolean;
    private var _internal_sfdbOrder : int;
    private var _internal_window : int;
    private var _internal_numTimesUniquelyTrueFlag : Boolean;
    private var _internal_numTimesUniquelyTrue : int;
    private var _internal_numTimesRoleSlot : String;
    private var _internal_effectId : int;
    private var _internal_networkType : int;
    private var _internal_networkValue : int;
    private var _internal_status : int;
    private var _internal_firstSubjective : String;
    private var _internal_secondSubjective : String;
    private var _internal_sfdbLabel : int;
    private var _internal_ruleId : int;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_PredicateVO()
    {
        _model = new _PredicateVOEntityMetadata(this);

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
    public function get description() : String
    {
        return _internal_description;
    }

    [Bindable(event="propertyChange")]
    public function get type() : int
    {
        return _internal_type;
    }

    [Bindable(event="propertyChange")]
    public function get trait() : int
    {
        return _internal_trait;
    }

    [Bindable(event="propertyChange")]
    public function get first() : int
    {
        return _internal_first;
    }

    [Bindable(event="propertyChange")]
    public function get second() : int
    {
        return _internal_second;
    }

    [Bindable(event="propertyChange")]
    public function get third() : int
    {
        return _internal_third;
    }

    [Bindable(event="propertyChange")]
    public function get comparator() : String
    {
        return _internal_comparator;
    }

    [Bindable(event="propertyChange")]
    public function get operator() : String
    {
        return _internal_operator;
    }

    [Bindable(event="propertyChange")]
    public function get knowledge() : int
    {
        return _internal_knowledge;
    }

    [Bindable(event="propertyChange")]
    public function get negated() : Boolean
    {
        return _internal_negated;
    }

    [Bindable(event="propertyChange")]
    public function get statusDuration() : int
    {
        return _internal_statusDuration;
    }

    [Bindable(event="propertyChange")]
    public function get name() : String
    {
        return _internal_name;
    }

    [Bindable(event="propertyChange")]
    public function get intent() : Boolean
    {
        return _internal_intent;
    }

    [Bindable(event="propertyChange")]
    public function get intentType() : int
    {
        return _internal_intentType;
    }

    [Bindable(event="propertyChange")]
    public function get isSFDB() : Boolean
    {
        return _internal_isSFDB;
    }

    [Bindable(event="propertyChange")]
    public function get sfdbOrder() : int
    {
        return _internal_sfdbOrder;
    }

    [Bindable(event="propertyChange")]
    public function get window() : int
    {
        return _internal_window;
    }

    [Bindable(event="propertyChange")]
    public function get numTimesUniquelyTrueFlag() : Boolean
    {
        return _internal_numTimesUniquelyTrueFlag;
    }

    [Bindable(event="propertyChange")]
    public function get numTimesUniquelyTrue() : int
    {
        return _internal_numTimesUniquelyTrue;
    }

    [Bindable(event="propertyChange")]
    public function get numTimesRoleSlot() : String
    {
        return _internal_numTimesRoleSlot;
    }

    [Bindable(event="propertyChange")]
    public function get effectId() : int
    {
        return _internal_effectId;
    }

    [Bindable(event="propertyChange")]
    public function get networkType() : int
    {
        return _internal_networkType;
    }

    [Bindable(event="propertyChange")]
    public function get networkValue() : int
    {
        return _internal_networkValue;
    }

    [Bindable(event="propertyChange")]
    public function get status() : int
    {
        return _internal_status;
    }

    [Bindable(event="propertyChange")]
    public function get firstSubjective() : String
    {
        return _internal_firstSubjective;
    }

    [Bindable(event="propertyChange")]
    public function get secondSubjective() : String
    {
        return _internal_secondSubjective;
    }

    [Bindable(event="propertyChange")]
    public function get sfdbLabel() : int
    {
        return _internal_sfdbLabel;
    }

    [Bindable(event="propertyChange")]
    public function get ruleId() : int
    {
        return _internal_ruleId;
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

    public function set description(value:String) : void
    {
        var oldValue:String = _internal_description;
        if (oldValue !== value)
        {
            _internal_description = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "description", oldValue, _internal_description));
        }
    }

    public function set type(value:int) : void
    {
        var oldValue:int = _internal_type;
        if (oldValue !== value)
        {
            _internal_type = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "type", oldValue, _internal_type));
        }
    }

    public function set trait(value:int) : void
    {
        var oldValue:int = _internal_trait;
        if (oldValue !== value)
        {
            _internal_trait = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "trait", oldValue, _internal_trait));
        }
    }

    public function set first(value:int) : void
    {
        var oldValue:int = _internal_first;
        if (oldValue !== value)
        {
            _internal_first = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "first", oldValue, _internal_first));
        }
    }

    public function set second(value:int) : void
    {
        var oldValue:int = _internal_second;
        if (oldValue !== value)
        {
            _internal_second = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "second", oldValue, _internal_second));
        }
    }

    public function set third(value:int) : void
    {
        var oldValue:int = _internal_third;
        if (oldValue !== value)
        {
            _internal_third = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "third", oldValue, _internal_third));
        }
    }

    public function set comparator(value:String) : void
    {
        var oldValue:String = _internal_comparator;
        if (oldValue !== value)
        {
            _internal_comparator = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "comparator", oldValue, _internal_comparator));
        }
    }

    public function set operator(value:String) : void
    {
        var oldValue:String = _internal_operator;
        if (oldValue !== value)
        {
            _internal_operator = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "operator", oldValue, _internal_operator));
        }
    }

    public function set knowledge(value:int) : void
    {
        var oldValue:int = _internal_knowledge;
        if (oldValue !== value)
        {
            _internal_knowledge = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "knowledge", oldValue, _internal_knowledge));
        }
    }

    public function set negated(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_negated;
        if (oldValue !== value)
        {
            _internal_negated = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "negated", oldValue, _internal_negated));
        }
    }

    public function set statusDuration(value:int) : void
    {
        var oldValue:int = _internal_statusDuration;
        if (oldValue !== value)
        {
            _internal_statusDuration = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "statusDuration", oldValue, _internal_statusDuration));
        }
    }

    public function set name(value:String) : void
    {
        var oldValue:String = _internal_name;
        if (oldValue !== value)
        {
            _internal_name = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "name", oldValue, _internal_name));
        }
    }

    public function set intent(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_intent;
        if (oldValue !== value)
        {
            _internal_intent = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intent", oldValue, _internal_intent));
        }
    }

    public function set intentType(value:int) : void
    {
        var oldValue:int = _internal_intentType;
        if (oldValue !== value)
        {
            _internal_intentType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intentType", oldValue, _internal_intentType));
        }
    }

    public function set isSFDB(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_isSFDB;
        if (oldValue !== value)
        {
            _internal_isSFDB = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isSFDB", oldValue, _internal_isSFDB));
        }
    }

    public function set sfdbOrder(value:int) : void
    {
        var oldValue:int = _internal_sfdbOrder;
        if (oldValue !== value)
        {
            _internal_sfdbOrder = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sfdbOrder", oldValue, _internal_sfdbOrder));
        }
    }

    public function set window(value:int) : void
    {
        var oldValue:int = _internal_window;
        if (oldValue !== value)
        {
            _internal_window = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "window", oldValue, _internal_window));
        }
    }

    public function set numTimesUniquelyTrueFlag(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_numTimesUniquelyTrueFlag;
        if (oldValue !== value)
        {
            _internal_numTimesUniquelyTrueFlag = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "numTimesUniquelyTrueFlag", oldValue, _internal_numTimesUniquelyTrueFlag));
        }
    }

    public function set numTimesUniquelyTrue(value:int) : void
    {
        var oldValue:int = _internal_numTimesUniquelyTrue;
        if (oldValue !== value)
        {
            _internal_numTimesUniquelyTrue = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "numTimesUniquelyTrue", oldValue, _internal_numTimesUniquelyTrue));
        }
    }

    public function set numTimesRoleSlot(value:String) : void
    {
        var oldValue:String = _internal_numTimesRoleSlot;
        if (oldValue !== value)
        {
            _internal_numTimesRoleSlot = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "numTimesRoleSlot", oldValue, _internal_numTimesRoleSlot));
        }
    }

    public function set effectId(value:int) : void
    {
        var oldValue:int = _internal_effectId;
        if (oldValue !== value)
        {
            _internal_effectId = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "effectId", oldValue, _internal_effectId));
        }
    }

    public function set networkType(value:int) : void
    {
        var oldValue:int = _internal_networkType;
        if (oldValue !== value)
        {
            _internal_networkType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "networkType", oldValue, _internal_networkType));
        }
    }

    public function set networkValue(value:int) : void
    {
        var oldValue:int = _internal_networkValue;
        if (oldValue !== value)
        {
            _internal_networkValue = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "networkValue", oldValue, _internal_networkValue));
        }
    }

    public function set status(value:int) : void
    {
        var oldValue:int = _internal_status;
        if (oldValue !== value)
        {
            _internal_status = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "status", oldValue, _internal_status));
        }
    }

    public function set firstSubjective(value:String) : void
    {
        var oldValue:String = _internal_firstSubjective;
        if (oldValue !== value)
        {
            _internal_firstSubjective = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "firstSubjective", oldValue, _internal_firstSubjective));
        }
    }

    public function set secondSubjective(value:String) : void
    {
        var oldValue:String = _internal_secondSubjective;
        if (oldValue !== value)
        {
            _internal_secondSubjective = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "secondSubjective", oldValue, _internal_secondSubjective));
        }
    }

    public function set sfdbLabel(value:int) : void
    {
        var oldValue:int = _internal_sfdbLabel;
        if (oldValue !== value)
        {
            _internal_sfdbLabel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sfdbLabel", oldValue, _internal_sfdbLabel));
        }
    }

    public function set ruleId(value:int) : void
    {
        var oldValue:int = _internal_ruleId;
        if (oldValue !== value)
        {
            _internal_ruleId = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ruleId", oldValue, _internal_ruleId));
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
    public function get _model() : _PredicateVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _PredicateVOEntityMetadata) : void
    {
        var oldValue : _PredicateVOEntityMetadata = model_internal::_dminternal_model;
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
