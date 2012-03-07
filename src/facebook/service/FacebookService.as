package facebook.service
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	
	import mx.collections.ArrayCollection;

	public class FacebookService
	{
		public function FacebookService(){}
		
		
		
		/**
		 * 
		 * @param callback callback function
		 * 
		 */		
		public function getAlbumPhotos(callback:Function):void{
			var fql:String = "select name, aid, cover_pid, size from album where owner = me()";
			Facebook.fqlQuery(fql, callback);
		}
		
		
		
		/**
		 * 
		 * @param pids 
		 * @param callback
		 * 
		 * Getting Album covers
		 * 
		 */		
		public function getPhotoURL(pids:Vector.<String>, callback:Function):void
		{
			var fql:String = "select aid, pid, src_big, src_small from photo where pid = '" + pids[0] + "'";
			if (pids.length > 1)
			{
				var len:int = pids.length; 
				for (var i:int = 0; i < len; i++)
					fql = fql + " OR pid = '" + pids[i] + "'";
			}
			
			Facebook.fqlQuery(fql, callback);
		}
		
		/**
		 * 
		 * Getting photos from a specific album
		 * 
		 */		
		public function getPhotos(aid:String, returnHandler:Function):void
		{
			var fql:String = "select src_big, src_small from photo where aid = '" + aid + "'";
			Facebook.fqlQuery(fql, returnHandler);
		}
		
		
		/*********************** FRIENDS PHOTOS ************************/
		
		public function loadFriends(returnHandler:Function):void
		{
			Facebook.api("/me/friends", returnHandler);
		}
		
		public function getFriendImageUrls(friendIds:Array, returnHandler:Function):void
		{
			var fql:String = "SELECT pic_small FROM user WHERE uid IN (" + friendIds.join(",") + ")";
			Facebook.fqlQuery(fql, returnHandler);
		}
	}
}