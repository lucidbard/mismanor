/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - SocialGameVO.as.
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
public class _Super_SocialGameVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("SocialGameVO") == null)
            {
                flash.net.registerClassAlias("SocialGameVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("SocialGameVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _SocialGameVOEntityMetadata;
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
    private var _internal_gid : int;
    private var _internal_vid : int;
    private var _internal_game_name : String;
    private var _internal_lock : Boolean;
    private var _internal_lockBy : int;
    private var _internal_lockDate : String;
    private var _internal_author : int;
    private var _internal_requiresOther : Boolean;
    private var _internal_responderType : int;
    private var _internal_otherType : int;
    private var _internal_needsSecondOther : Boolean;
    private var _internal_thirdPartyTalkAboutSomeone : Boolean;
    private var _internal_thirdPartyGetSomeoneToDoSomethingForYou : Boolean;
    private var _internal_lastupdated : int;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_SocialGameVO()
    {
        _model = new _SocialGameVOEntityMetadata(this);

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
    public function get gid() : int
    {
        return _internal_gid;
    }

    [Bindable(event="propertyChange")]
    public function get vid() : int
    {
        return _internal_vid;
    }

    [Bindable(event="propertyChange")]
    public function get game_name() : String
    {
        return _internal_game_name;
    }

    [Bindable(event="propertyChange")]
    public function get lock() : Boolean
    {
        return _internal_lock;
    }

    [Bindable(event="propertyChange")]
    public function get lockBy() : int
    {
        return _internal_lockBy;
    }

    [Bindable(event="propertyChange")]
    public function get lockDate() : String
    {
        return _internal_lockDate;
    }

    [Bindable(event="propertyChange")]
    public function get author() : int
    {
        return _internal_author;
    }

    [Bindable(event="propertyChange")]
    public function get requiresOther() : Boolean
    {
        return _internal_requiresOther;
    }

    [Bindable(event="propertyChange")]
    public function get responderType() : int
    {
        return _internal_responderType;
    }

    [Bindable(event="propertyChange")]
    public function get otherType() : int
    {
        return _internal_otherType;
    }

    [Bindable(event="propertyChange")]
    public function get needsSecondOther() : Boolean
    {
        return _internal_needsSecondOther;
    }

    [Bindable(event="propertyChange")]
    public function get thirdPartyTalkAboutSomeone() : Boolean
    {
        return _internal_thirdPartyTalkAboutSomeone;
    }

    [Bindable(event="propertyChange")]
    public function get thirdPartyGetSomeoneToDoSomethingForYou() : Boolean
    {
        return _internal_thirdPartyGetSomeoneToDoSomethingForYou;
    }

    [Bindable(event="propertyChange")]
    public function get lastupdated() : int
    {
        return _internal_lastupdated;
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

    public function set gid(value:int) : void
    {
        var oldValue:int = _internal_gid;
        if (oldValue !== value)
        {
            _internal_gid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "gid", oldValue, _internal_gid));
        }
    }

    public function set vid(value:int) : void
    {
        var oldValue:int = _internal_vid;
        if (oldValue !== value)
        {
            _internal_vid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "vid", oldValue, _internal_vid));
        }
    }

    public function set game_name(value:String) : void
    {
        var oldValue:String = _internal_game_name;
        if (oldValue !== value)
        {
            _internal_game_name = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "game_name", oldValue, _internal_game_name));
        }
    }

    public function set lock(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_lock;
        if (oldValue !== value)
        {
            _internal_lock = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lock", oldValue, _internal_lock));
        }
    }

    public function set lockBy(value:int) : void
    {
        var oldValue:int = _internal_lockBy;
        if (oldValue !== value)
        {
            _internal_lockBy = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lockBy", oldValue, _internal_lockBy));
        }
    }

    public function set lockDate(value:String) : void
    {
        var oldValue:String = _internal_lockDate;
        if (oldValue !== value)
        {
            _internal_lockDate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lockDate", oldValue, _internal_lockDate));
        }
    }

    public function set author(value:int) : void
    {
        var oldValue:int = _internal_author;
        if (oldValue !== value)
        {
            _internal_author = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "author", oldValue, _internal_author));
        }
    }

    public function set requiresOther(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_requiresOther;
        if (oldValue !== value)
        {
            _internal_requiresOther = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "requiresOther", oldValue, _internal_requiresOther));
        }
    }

    public function set responderType(value:int) : void
    {
        var oldValue:int = _internal_responderType;
        if (oldValue !== value)
        {
            _internal_responderType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "responderType", oldValue, _internal_responderType));
        }
    }

    public function set otherType(value:int) : void
    {
        var oldValue:int = _internal_otherType;
        if (oldValue !== value)
        {
            _internal_otherType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "otherType", oldValue, _internal_otherType));
        }
    }

    public function set needsSecondOther(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_needsSecondOther;
        if (oldValue !== value)
        {
            _internal_needsSecondOther = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "needsSecondOther", oldValue, _internal_needsSecondOther));
        }
    }

    public function set thirdPartyTalkAboutSomeone(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_thirdPartyTalkAboutSomeone;
        if (oldValue !== value)
        {
            _internal_thirdPartyTalkAboutSomeone = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "thirdPartyTalkAboutSomeone", oldValue, _internal_thirdPartyTalkAboutSomeone));
        }
    }

    public function set thirdPartyGetSomeoneToDoSomethingForYou(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_thirdPartyGetSomeoneToDoSomethingForYou;
        if (oldValue !== value)
        {
            _internal_thirdPartyGetSomeoneToDoSomethingForYou = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "thirdPartyGetSomeoneToDoSomethingForYou", oldValue, _internal_thirdPartyGetSomeoneToDoSomethingForYou));
        }
    }

    public function set lastupdated(value:int) : void
    {
        var oldValue:int = _internal_lastupdated;
        if (oldValue !== value)
        {
            _internal_lastupdated = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lastupdated", oldValue, _internal_lastupdated));
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
    public function get _model() : _SocialGameVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _SocialGameVOEntityMetadata) : void
    {
        var oldValue : _SocialGameVOEntityMetadata = model_internal::_dminternal_model;
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
