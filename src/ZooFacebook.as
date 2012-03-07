package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	
	import facebook.login.FacebookLogin;
	import facebook.service.FacebookService;
	import facebook.service.FacebookServiceDataHandler;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	
	
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="520", height="600")]
	public class ZooFacebook extends Sprite
	{
		private var fbLogin:FacebookLogin = new FacebookLogin();
		private var fbService:FacebookService = new FacebookService();
		private var fbServiceHandler:FacebookServiceDataHandler = new FacebookServiceDataHandler();
		private var photoAlbums:ArrayCollection;
		private var photos:ArrayCollection;
		
		
		
		public function ZooFacebook()
		{
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "version .3");
			fbLogin.loginToFacebook();
			fbLogin.addEventListener(Event.COMPLETE, loggedin);
		}
		
		
		/**
		 * 
		 * Dispatched once the system is logged into facebook
		 * 
		 */		
		private function loggedin(e:Event):void{
			fbLogin.removeEventListener(Event.COMPLETE, loggedin);
			//stage.addEventListener(MouseEvent.CLICK, postPhoto);
			//requestAID();
			//requestFriends();
			//requestProfilePicture();
		}
		
		
		/*********************** ALBUM COVERS AND PHOTOS ************************/
		
		/**
		 * 
		 * Parse the album cover information
		 * 
		 */		
		private function requestAID():void{
			fbService.getAID(fbServiceHandler.handleAID);
			fbServiceHandler.addEventListener(Event.COMPLETE, getAlbumCovers);
		}
		
		/**
		 * 
		 * This method is responsible for getting the albums id (aid);
		 * photoAlbums is an ArrayCollection which gets all the aids from my albums
		 * 
		 */		
		private function getAlbumCovers(e:Event):void{
			photoAlbums = fbServiceHandler._facebookPhotoAlbums;
			for(var i:int = 0; i < photoAlbums.length; i++){
				MonsterDebugger.trace(this, photoAlbums[i].aid)
			}
			fbService.getPhotos(photoAlbums[0].aid, getAlbumPhotos);
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
		
		
		/*********************** FRIENDS PROFILE PHOTOS ************************/
		
		private function requestFriends():void{
			MonsterDebugger.trace(this, "friends Parsing");
			fbService.loadFriends(fbServiceHandler.handleFriendsLoaded);
			fbServiceHandler.addEventListener(Event.COMPLETE, friendsLoaded);
		}
		
		private function friendsLoaded(e:Event):void{
			
			var len:uint = fbServiceHandler._friends.length;
			for (var i:uint = 0; i < len; i++)
			{
				//_friends[i].imageUrl = friendImages[i].pic_small;
				MonsterDebugger.trace(this, facebookServiceHandler._friends[i].pic_small);
			}
			
			
		}
		
		
		/*********************** POSTING PHOTO ************************/
		
		
		/**lBack, _params, URLRequestMethod.POST);
			} catch (error:Error){
				MonsterDebugger.trace(this, "Error: " + error);
			}
		 * 
		 * To upload photos is required a mouse event for that.
		 * 
		 */		
		private function postPhoto(e:MouseEvent):void{
			
			var _params:Object = new Object();
			
			_params.access_token = Facebook.getAuthResponse().accessToken;
			_params.message      = "my album test";
			_params.image        = fakeBM();
			_params.fileName	= "test.jpg";
			
			try{
				Facebook.api("me/photos", imagePostCallBack, _params, URLRequestMethod.POST);
			} catch (error:Error){
				MonsterDebugger.trace(this, "Error: " + error);
			}
			
		}
		
		private function imagePostCallBack(success:Object, fail:Object):void{}
		
		private function fakeBM():Bitmap{
			var imgData:BitmapData = new BitmapData(100, 100, false, 0xFF00FF00);
			var bm:Bitmap = new Bitmap(imgData);
			return bm;
		}
		
		
		
		
		/*********************** REQUESTING PROFILE PHOTO ************************/
		
		private function requestProfilePicture():void{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(fbService.getProfilePicture("large")));
			addChild(loader);
		}
		
		
	}
}