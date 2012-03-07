package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	
	import facebook.login.FacebookLogin;
	import facebook.service.FacebookService;
	import facebook.service.FacebookServiceDataHandler;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	
	
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="520", height="600")]
	public class ZooFacebook extends Sprite
	{
		private var startFacebookLogin:FacebookLogin = new FacebookLogin();
		private var facebookService:FacebookService = new FacebookService();
		private var facebookServiceHandler:FacebookServiceDataHandler = new FacebookServiceDataHandler();
		private var photoAlbums:ArrayCollection;
		private var photos:ArrayCollection;
		
		
		
		public function ZooFacebook()
		{
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "version .3");
			startFacebookLogin.loginToFacebook();
			startFacebookLogin.addEventListener(Event.COMPLETE, loggedin);
		}
		
		
		/**
		 * 
		 * Dispatched once the system is logged into facebook
		 * 
		 */		
		private function loggedin(e:Event):void{
			//parseAlbums();
			parseFriends();
		}
		
		
		/*********************** ALBUM COVERS AND PHOTOS ************************/
		
		/**
		 * 
		 * Parse the album cover information
		 * 
		 */		
		private function parseAlbums():void{
			facebookService.getAlbumPhotos(facebookServiceHandler.handleAlbumPhotos);
			facebookServiceHandler.addEventListener(Event.COMPLETE, getAlbumCovers);
		}
		
		/**
		 * 
		 * This method is responsible for getting the albums id (aid);
		 * 
		 */		
		private function getAlbumCovers(e:Event):void{
			photoAlbums = facebookServiceHandler._facebookPhotoAlbums;
			/*for(var i:int = 0; i < photoAlbums.length; i++){
				MonsterDebugger.trace(this, photoAlbums[i].aid)
			}*/
			facebookService.getPhotos(photoAlbums[0].aid, getAlbumPhotos);
		}
		
		/**
		 * 
		 * @param _photos
		 * @param fail
		 * 
		 * This method is responsible for getting the photos into the specific album id (aid);
		 * 
		 */		
		private function getAlbumPhotos(_photos:Object, fail:Object):void{
			if(_photos != null){
				photos = new ArrayCollection(_photos as Array);
				for(var i:int = 0; i < photos.length; i++){
					MonsterDebugger.trace(this, photos[i].src_big);
				}
			} else {
				MonsterDebugger.trace(this, "This album has no photos");
			}
			
		}
		
		
		/*********************** FRIENDS PHOTOS ************************/
		
		private function parseFriends():void{
			MonsterDebugger.trace(this, "friends Parsing");
			facebookService.loadFriends(facebookServiceHandler.handleFriendsLoaded);
			facebookServiceHandler.addEventListener(Event.COMPLETE, friendsLoaded);
		}
		
		private function friendsLoaded(e:Event):void{
			
			var len:uint = facebookServiceHandler._friends.length;
			for (var i:uint = 0; i < len; i++)
			{
				//_friends[i].imageUrl = friendImages[i].pic_small;
				//MonsterDebugger.trace(this, facebookServiceHandler._friends[i].pic_small);
			}
			
			
			//MonsterDebugger.trace(this, "friends Loaded: " + facebookServiceHandler._friends);
			
		}
		
		
		
	}
}