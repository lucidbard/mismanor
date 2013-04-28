package grailgm 
{
	import CiF.Debug;
	import CiF.Locution;
	import CiF.SocialGame;
	import CiF.SocialGameContext;
	import CiF.Status;
	import CiF.Trait;
	import flash.events.Event;
	import flash.geom.Vector3D;/*
	import flash.net.FileReference;
	import flash.net.sendToURL;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;*/
	import flash.net.*;
	import flash.utils.ByteArray;
	import flash.text.TextField;
	import flash.text.TextFormat;
	//import flash.files
	
	/**
	 * ...
	 * @author April Grow
	 */
	public class Diagnostics extends Debug 
	{
		public function Diagnostics() 
		{
			
		}
		
		public function clean(): void {
			
		}
		
		// statuses, traits, networks, name, ID, location(room), inventory, knowledge
		public static function saveChars(chars:Vector.<GrailCharacter>):String {
			var str:String = "**** Characters: \n";
			for each(var char:GrailCharacter in chars) {
				//str += "** " + char.name + "\n";
				//str += "ID: " + char.cifCharacter.networkID
				//str += "Traits: ";
				//for each (var trait:Number in char.cifCharacter.traits) {
					//str += Trait.getNameByNumber(trait) + ", ";
				//}
				//str += "\n";
				//str += "Statuses: ";
				//for each (var status:Status in char.cifCharacter.statuses) {
					//str += Status.getStatusNameByNumber(status.type) + ", ";
				//}
				//str += "\n";
				str += "**" + char;
			}
			return str;
		}
		
		// statuses, traits, name, ID, location (room, x, y?)
		public static function saveItems(items:Vector.<GrailItem>):String {
			var str:String = "**** Items: \n";
			for each(var item:GrailItem in items) {
				str += item;
			}
			return str;
		}
		
		// knowledge (statuses, traits, name, ID), preconditions
		public static function saveKnowsPP(pps:Vector.<PlotPoint>):String {
			var str:String = "**** Knowledge: \n";
			for each (var know:PlotPoint in pps) {
				str += know;
			}
			return str;
		}
		
		public static function getObjsString(ggm:GrailGM):String {
			var str:String = "";
			str += saveChars(ggm.charList);
			str += saveItems(ggm.itemList);
			str += saveKnowsPP(ggm.plotPointPool.plotPoints);
			return str;
		}
		
		public static function saveObjsFile(ggm:GrailGM):void {
			var str:String = "";
			str += saveChars(ggm.charList);
			str += saveItems(ggm.itemList);
			str += saveKnowsPP(ggm.plotPointPool.plotPoints);
			
			var file:FileReference = new FileReference();
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(str);
			file.save(bytes,'Objtest.txt');
		}
		
		public static function savePlayFile(str:String):void {
			var file:FileReference = new FileReference();
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(str);
			file.save(bytes,'Playtest.txt');

		}
		
		public static function traceSocialMove(context:SocialGameContext):String {
			var playTrace:String = "";
			
			playTrace += addTimeStamp() + "*** Playing Social Move: " + context.gameName + " at time " + context.time + "\n";
			playTrace += context.initiator + "(" + context.initiatorScore + ") with ";
			playTrace += context.responder + "(" + context.responderScore + ")";
			if (context.other != "") playTrace += " involving " + context.other;
			playTrace += "\n";
			playTrace += "Effect ID: " + context.effectID + "\n";
			if (context.chosenItemCKB != null && context.chosenItemCKB != "") playTrace += "Chosen CKB Item: " + context.chosenItemCKB + "\n";
			if (context.label != "") playTrace += "Label: " + context.label + "\n";
			playTrace += "\n";
			
			return playTrace;
		}
		
		public static function traceDialogue(str:String):String {
			var playTrace:String = "";
			
			playTrace += addTimeStamp() + "Realization: \n" + str + "\n\n";
			
			return playTrace;
		}
		
		public static function traceFormatless(str:String):String {
			return addTimeStamp() + str;
		}
		
		public static function tracePlayerMoveRoom(moveFrom:Location, moveTo:Location):String {
			var playTrace:String = "";
			
			playTrace += addTimeStamp() + "@@@ Player moved from the " + moveFrom.name;
			playTrace += " to the " + moveTo.name + "\n\n";
			
			return playTrace;
		}
		
		public static function traceClickOnObj(str:String):String {
			var playTrace:String = "";
			playTrace += addTimeStamp() + "!!! player clicked on " + str + "\n\n";
			return playTrace;
		}
		
		public static function traceItemMovement(str:String):String {
			var playTrace:String = "";
			playTrace += addTimeStamp() + "^^^ " + str + "\n\n";
			return playTrace;
		}
		
		public static function traceCustomString(str:String):String {
			var playTrace:String = "";
			
			playTrace += addTimeStamp() + "%%% " + str + "\n\n";
			
			return playTrace;
		}
		
		public static function addTimeStamp():String {
			var date:Date = new Date();
			return date.getHours().toString() + ":" + date.getMinutes().toString() + ":" + date.getSeconds().toString() + ": ";
		}
		
		// name, id, time, requires other, types, intent, influence rules, chosen effect (if... then) + ID, chosen instantiation + ID
		//public function saveSocialMove():void {
			//
		//}
		
		public static function saveObjs(userStr:String, userNum:Number, data:String, version:String = "", error:Error = null): void {
			saveFileToServer(userStr + "Objs", userNum, data, version, error);
		}
		
		public static function saveState(userStr:String, userNum:Number, data:String, version:String = "", error:Error = null): void {
			saveFileToServer(userStr + "State", userNum, data, version, error);
		}
		
		public static function saveError(userStr:String, userNum:Number, data:String, version:String = "", error:Error = null): void {
			saveFileToServer(userStr + "ERROR", userNum, data, version, error);
		}
		
		private static function onFinishWritingError(e:Error):void {
			trace (e.getStackTrace());
			throw e;
		}
		
		public static function saveFileToServer(userStr:String, userNum:Number, data:String, version:String = "", error:Error = null):void {
			var date:Date = new Date();
			var name:String = userStr + version + "_" + date.getDate().toString() + date.getMonth().toString() + 
							  date.getFullYear().toString() + "_" + userNum + ".txt";
			var dataStr:String = "USER: " + userStr + " " + userNum + "\nDATE: " + date + "\n\n" + data;

			trace("Saving file " + name);
			
			var myData:URLRequest = new URLRequest("http://users.soe.ucsc.edu/~agrow/mismanor/savePlayTrace.php");
			myData.method = URLRequestMethod.POST;
			
			var variables:URLVariables = new URLVariables();
			variables.Name = name;
			variables.Data = dataStr;
			myData.data = variables;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(myData);
			
			// When the function is being used to print an error, make sure the error is finished saving before throwing it
			if (error != null) loader.addEventListener(Event.COMPLETE, function(e:Event):void { onFinishWritingError(error) });
		}
		
	}

}