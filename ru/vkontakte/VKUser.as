package ru.vkontakte
{
	public class VKUser 
	{
		private var m_app:VKApp;
		private var m_id:int;
		
		public function VKUser(app:VKApp, user_id:int)
		// set user_id to zero to specify own instance 
		{
			m_app = app;
			m_id = id;
		}
		
		public function get id() : int
		{
			return m_id;
		}
				
		public function getVariable(key:int, cb:Function):void
		{
			if (m_id && ((key < 1280) || (key > 1791)))
				trace("WARNING can read other user variables only in range 1280-1791'")
			if ((key < 1024) || (key > 2047))
				trace("WARNING user variables, unboundled to session only in range 1024-2047'")
			var params:Object = {method: 'getVariable', key: String(key)};
			if (m_id)
				params.user_id = String(m_id);
			m_app.execute(params, cb);
		}

		public function putVariable(key:int, value:String, cb:Function):void
		{
			if (!m_id)
				trace("WARNING all putVariable runs only on own variable scope");
			var params:Object = {method: 'putVariable', key: String(key), value: value};
			m_app.execute(params, cb);
		}

		public function getUserInfo(cb:Function):void
		{
			var params:Object = {method: 'getUserInfo'};
			if (m_id)
				params.user_id = String(m_id);
			m_app.execute(params, cb);
		}
	}	
}