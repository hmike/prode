var app = angular.module("Prode", ['ngResource', 'ngAnimate', 'angular-growl']);

app.config(['growlProvider', '$httpProvider', function(growlProvider, $httpProvider) {
	growlProvider.globalTimeToLive(5000);
	// growlProvider.messagesKey("messages");
 //    growlProvider.messageTextKey("text");
 //    growlProvider.messageSeverityKey("type");
    $httpProvider.responseInterceptors.push(growlProvider.serverMessagesInterceptor);
}])