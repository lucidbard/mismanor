package core.util
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	
	public class CompareValidator extends Validator
	{
		public var valueToCompare:Object;
		public var errorMessage:String = "Value does not match.";
		
		public function CompareValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array {
			var results:Array = [];
			var srcVal:Object = this.getValueFromSource();
			
			if (srcVal != valueToCompare) {
				results.push(new ValidationResult(true, null, "Match",errorMessage));
			}
			return results;
			
		}
	}
}