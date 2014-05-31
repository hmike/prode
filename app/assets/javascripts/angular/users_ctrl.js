// angular.module('UsersCtrl', ['ng-rails-csrf', 'Devise']).
//     config(function(AuthProvider) {
//         // Configure Auth service with AuthProvider
//     }).
app.controller('UsersCtrl', function(Auth) {

		// var credentials = {
  //           email: 'admin@admin.com',
  //           password: '123456'
  //       };

  //       Auth.login(credentials).then(function(user) {
  //           console.log(user); // => {id: 1, ect: '...'}
  //       }, function(error) {
  //           // Authentication failed...
  //       })


        // // Use your configured Auth service.
        // Auth.currentUser().then(function(user) {
        //     // User was logged in, or Devise returned
        //     // previously authenticated session.
        //     console.log(user); // => {id: 1, ect: '...'}
        // }, function(error) {
        //     // unauthenticated error
        // });

        // console.log(Auth.isAuthenticated());


var credentials = {
            email: 'admin@admin.com',
            password: 'password1',
            password_confirmation: 'password1'
        };

        Auth.register(credentials).then(function(registeredUser) {
            console.log(registeredUser); // => {id: 1, ect: '...'}
        }, function(error) {
            // Registration failed...
        });

    });