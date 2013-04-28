package CiF {
	
	import flash.utils.*;
	
	/**
	 * Adds some debug utility to CiF.
	 * 
	 * 
	 * @author Josh McCoy
	 */
	public class Debug{
		
		public static var level:Number = 1;
		
		public function Debug() {
			
		}
	
		public static function debug(obj:Object, msg:String, debugLevel:Number = 1 ):void {
			if(Debug.level >= debugLevel)
				trace(getQualifiedClassName(obj) + ": " + msg);
		}

		public static function errorPrint(obj:Object, msg:String, errorLevel:Number = 1):void {
			trace("ERROR " + getQualifiedClassName(obj) + ": " + msg);
			throw Error;
		}
	

	
		public static function CallStack(prefix:String=""):void {
			var e:Error = new Error("Current call stack:");
			var s:String = e.getStackTrace();
			var lines:Array = s.split("\n");
			// Remove the "Error:..." line.
			lines.shift();
			// Remove this function's entry in the stack.
			lines.shift();
			// Put 'em in top down order?
			//lines.reverse();
			
			var output:String = "";
			var m:Object;
			for each (var line:String in lines) {
				m = line.match(/^\s*at (.*)$/);
				output += "\t" + m[1] + "\n";
			}
			s = lines.join("\n");
			
			if (prefix != "") prefix += "\n";
			trace(prefix + output);
		}
	}
}