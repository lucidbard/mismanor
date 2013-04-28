/**
 * This is a generated sub-class of _SocialgamesService.as and is intended for behavior
 * customization.  This class is only generated when there is no file already present
 * at its target location.  Thus custom behavior that you add here will survive regeneration
 * of the super-class. 
 **/
 
package services
{

public class SocialgamesService extends _Super_SocialgamesService
{
    /**
     * Override super.init() to provide any initialization customization if needed.
     */
    protected override function preInitializeService():void
    {
        super.preInitializeService();
        // Initialization customization goes here
		//_serviceControl.endpoint = "http://localhost/expressive.ai/designtool/gateway.php";
		_serviceControl.endpoint = "http://54.245.105.219/gateway.php";
    }
               
}

}
