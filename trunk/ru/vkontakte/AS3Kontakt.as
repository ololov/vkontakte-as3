package ru.vkontakte
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.core.Application;
	
	public class AS3Kontakt
	{
		private var app:Application;
		private var api_id:int;
		private var api_secret:String;
		private var test_mode:Boolean;
		
		public function AS3Kontakt(app:Application, api_id:int, api_secret:String, test_mode:Boolean) 
		{
			this.app = app;
			this.api_id = api_id;
			this.api_secret = api_secret;
			this.test_mode = test_mode;
		}
		
		public function get viewer_id(): int
		{
			return Number(app.parameters.viewer_id);
		}

		public function get user_id(): int
		{
			return Number(app.parameters.user_id);
		}

		public function get group_id(): int
		{
			return Number(app.parameters.group_id);
		}
		
		public function get me():Boolean
		{
			return ((this.user_id == this.viewer_id) || ((this.user_id == 0) && (this.group_id == 0)));
		}
		
		private function signature(params:Object):String 
		{
			var keys:Array = new Array();
			for (var k:String in params)
				keys.push(k);
			keys.sort();
			var sig:String = String(this.viewer_id);			
			for (var i:int = 0; i < keys.length; i++)
				sig = sig + keys[i] + "=" + params[keys[i]];
			sig = sig + this.api_secret;
			return MD5.encrypt(sig);
		}
		
		public function execute(params:Object, cb:Function):void
		{
			params.api_id = String(api_id);
			if (test_mode)
				params.test_mode = "1";
			params.sig = signature(params);
			var request:URLRequest = new URLRequest("http://api.vkontakte.ru/api.php");
			request.method = URLRequestMethod.GET;
			request.data = new URLVariables();
			for (var k:String in params)
				request.data[k] = params[k];

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, function(event:Event):void {
				if (cb != null)	cb(XML(loader.data));
			})
			loader.load(request);
		}
		
		public function getVariable(key:int, cb:Function):void
		{
			var params:Object = {method: 'getVariable', key: String(key)};
			this.execute(params, cb);
		}

		public function putVariable(key:int, value:String, cb:Function):void
		{
			var params:Object = {method: 'putVariable', key: String(key), value: value};
			this.execute(params, cb);
		}

		public function getUserVariable(user_id:int, key:int, cb:Function):void
		{
			var params:Object = {method: 'getVariable', key: String(key), user_id : String(user_id)};
			this.execute(params, cb);
		}
		
		public function getHighScores(cb:Function):void
		{
			var params:Object = {method: 'getHighScores'};
			this.execute(params, cb);
		}
		
		public function setHighScore(score:int, cb:Function):void
		{
			var params:Object = {method: 'getHighScores', score: String(score)};
			this.execute(params, cb);
		}
		
		public function getServerTime(cb:Function):void
		{
			var params:Object = {method: 'getServerTime'};
			this.execute(params, cb);
		}

		public function getUserInfo(cb:Function):void
		{
			var params:Object = {method: 'getUserInfo'};
			this.execute(params, cb);
		}
		
	}
}