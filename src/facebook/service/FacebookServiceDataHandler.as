package facebook.service
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class FacebookServiceDataHandler extends EventDispatcher
	{
		
		private var fbService:FacebookService = new FacebookService();
		public var _facebookPhotoAlbums:ArrayCollection;
		public var _facebookPhotos:ArrayCollection;
		public var _covers:Array = new Array();
		public var _friends:Array = new Array();
		
		public function FacebookServiceDataHandler(){}
		
		
		
		/*********************** ALBUM PHOTOS ************************/
		
		/**
		 * 
		 * @param albums
		 * @param fail
		 * 
		 */		
		public function handleAlbumPhotos(albums:Object, fail:Object):void{
			if(albums != null){
				_facebookPhotoAlbums = new ArrayCollection(albums as Array);
				var pids:Vector.<String> = new Vector.<String>();
				var len:int = _facebookPhotoAlbums.length;
				for (var i:int = 0; i < len; i++)
					pids.push(_facebookPhotoAlbums[i].cover_pid);
				
				fbService.getPhotoURL(pids, handlePhotoURL);
			} else {
				MonsterDebugger.trace(this, "You have no albums to display");
			}
			
		}
		
		private function handlePhotoURL(photos:Array, fail:Object):void
		{
			var covers:Array = photos;
			var len:int = _facebookPhotoAlbums.length - 1; 
			for (var i:int = len; i >= 0; i--)
				if (_facebookPhotoAlbums[i].size == 0) 
					_facebookPhotoAlbums.removeItemAt(i);
			
			for (var j:int = 0; j < covers.length; j++)
				_facebookPhotoAlbums[j].src_small = covers[j].src_small;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function handleGetPhotos(photos:Object, fail:Object):void
		{
			if (photos != null)
			{
				_facebookPhotos = new ArrayCollection(photos as Array);
			}
			else
			{
				MonsterDebugger.trace(this, "There are now images in this album!");
			}
		}
		
		
		
		
		
		
		/*********************** FRIENDS PHOTOS ************************/
		
		
		
		
		
		public function handleFriendsLoaded(response:Object, fail:Object):void
		{
			var friends:Array = response as Array;
			friends.sortOn("name");
			var friendIds:Array = [];
			
			var len:uint = friends.length;
			for (var i:uint = 0; i < len; i++){
				friendIds.push(friends[i].id);
				//MonsterDebugger.trace(this, friends[i].name);
			}
			
			fbService.getFriendImageUrls(friendIds, handleLoadFriendImageUrls);
		}
		
		private function handleLoadFriendImageUrls(response:Object, fail:Object):void
		{
			var friendImages:Array = response as Array;
			_friends = friendImages;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
	}
}