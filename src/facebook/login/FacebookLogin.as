package facebook.login
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	
	import facebook.config.FacebookConfig;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	public class FacebookLogin extends EventDispatcher
	{
		public function FacebookLogin(){}
		
		public function loginToFacebook():void{
			Facebook.init(FacebookConfig.APP_ID, loginHandler);
		}
		
		private function loginHandler(success:Object, fail:Object):void{
			if(success)
				Facebook.api("/me", getMeHandler);
			else
				if(ExternalInterface.available)
					ExternalInterface.call("redirect", FacebookConfig.APP_ID, FacebookConfig.PERMISSIONS_LIST, FacebookConfig.FACEBOOK_URL + FacebookConfig.APP_NAMESPACE + "/");
			
		}
		
		public function login():void{
			if(Facebook.getLoginStatus() == null)
				Facebook.login(getMeHandler, FacebookConfig.PERMISSIONS);
		}
		
		private function getMeHandler(success:Object, fail:Object):void{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}