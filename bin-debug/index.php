<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
	 	<!-- Include support librarys first -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
		
		<!-- Include FBJSBridge to allow for SWF to Facebook communication. -->
		<script type="text/javascript" src="FBJSBridge.js"></script>
		
		<script type="text/javascript">
			function embedPlayer() {
				var flashvars = {};
				swfobject.embedSWF("ZooFacebook.swf", "flashContent", "494", "666", "10.0", null, null, null, {name:"flashContent"}); 
			}
			//Redirect for authorization for application loaded in an iFrame on Facebook.com 
			function redirect(id,perms,uri) {
				var params = window.location.toString().slice(window.location.toString().indexOf('?'));
				top.location = 'https://graph.facebook.com/oauth/authorize?client_id='+id+'&scope='+perms+'&redirect_uri='+uri+params;				 
			}
			embedPlayer();
		</script>

  </head>
  <body>
    <div id="fb-root"></div>
    <div id="flashContent">
        	<h1>You need at least Flash Player 10.0 to view this page.</h1>
                <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
    </div>
  </body>
</html>