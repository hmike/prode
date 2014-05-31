var app = angular.module("Prode", ['ngResource', 'ngAnimate', 'angular-growl', 'angular-loading-bar', 'ng-rails-csrf', 'Devise']);

app.config(['growlProvider', '$httpProvider', 'cfpLoadingBarProvider', 'AuthProvider', function(growlProvider, $httpProvider, cfpLoadingBarProvider, AuthProvider) {
	// cfpLoadingBarProvider.includeSpinner = true;
	// cfpLoadingBarProvider.includeBar = true;
	cfpLoadingBarProvider.latencyThreshold = 0;
	growlProvider.globalTimeToLive(5000);
	//growlProvider.messagesKey("messages");
	//growlProvider.messageTextKey("text");
	//growlProvider.messageSeverityKey("type");
	$httpProvider.responseInterceptors.push(growlProvider.serverMessagesInterceptor);

	AuthProvider.loginPath('/login.json');
	AuthProvider.loginMethod('GET');
	AuthProvider.logoutPath('/logout.json');
	AuthProvider.logoutMethod('POST');
	AuthProvider.registerPath('/signup.json');
	AuthProvider.registerMethod('GET');

	 // var paths = {
  //       login: '/users/sign_in.json',
  //       logout: '/users/sign_out.json',
  //       register: '/users.json'
  //     };
  //      var methods = {
  //       login: 'POST',
  //       logout: 'DELETE',
  //       register: 'POST'
  //     };

	// Customize user parsing
	// NOTE: **MUST** return a truth-y expression
	AuthProvider.parse(function(response) {
		console.log(response);
		return response;
	    // return new User(response.data);
	});

}])