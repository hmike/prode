var app = angular.module("Prode", ['angular-loading-bar', 'ngResource', 'ngAnimate', 'angular-growl']);

app.config(['growlProvider', '$httpProvider', 'cfpLoadingBarProvider', function(growlProvider, $httpProvider, cfpLoadingBarProvider) {
	// cfpLoadingBarProvider.includeSpinner = true;
	// cfpLoadingBarProvider.includeBar = true;
	cfpLoadingBarProvider.latencyThreshold = 0;
	growlProvider.globalTimeToLive(5000);
	//growlProvider.messagesKey("messages");
	//growlProvider.messageTextKey("text");
	//growlProvider.messageSeverityKey("type");
	$httpProvider.responseInterceptors.push(growlProvider.serverMessagesInterceptor);
}])