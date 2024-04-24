<script>
	$(document).ready(function(){
		webSocketInit();
	});
	
	Notification.requestPermission();
	 	
	var webSocket;
		 
	function webSocketInit() {
		if(webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
		 	console.log("WebSokcet is already opened.");
		 	return;
		}
		
		var accountId = '<%=session.getAttribute("accountId")%>';
		webSocket = new WebSocket("wss://admin.menuplus.kr/websocket/" + accountId);
		console.log("webSocket.readyState[" + webSocket.readyState + "]");
		
		webSocket.onopen = function(e) {
			if(e.data === undefined) return;
		 	console.log(e.data);
		}
			
		webSocket.onmessage = function(e) {
			notify(e.data);
		}
	 		
		webSocket.onclose = function(e) {
			console.log("Connection closed");
		 	setTimeout(webSocketInit, 300);
		 }
	}
	
	function notify(data) {
		menuplusApp.toastOn();
	}
</script>