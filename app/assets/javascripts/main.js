// var app = angular.module("Prode", ['ngResource', 'ngAnimate', 'angular-growl']);

// app.config(['growlProvider', '$httpProvider', function(growlProvider, $httpProvider) {
// 	growlProvider.globalTimeToLive(5000);
// 	// growlProvider.messagesKey("messages");
//  //    growlProvider.messageTextKey("text");
//  //    growlProvider.messageSeverityKey("type");
//     $httpProvider.responseInterceptors.push(growlProvider.serverMessagesInterceptor);
// }])



//****************************************************
//****************************************************
//****************************************************
//****************************************************
//****************************************************
'use strict';

// Declare app level module which depends on filters, and services
// var app = angular.module('myApp', ['mongolabResourceHttp', 'data.services']);
var app = angular.module("Prode", ['ngResource', 'ngAnimate', 'angular-growl']);

app.constant('_START_REQUEST_', '_START_REQUEST_');
app.constant('_END_REQUEST_', '_END_REQUEST_');

app.config(['$httpProvider', '_START_REQUEST_', '_END_REQUEST_', function ($httpProvider, _START_REQUEST_, _END_REQUEST_) {
    var $http,
        interceptor = ['$q', '$injector', function ($q, $injector) {
            var rootScope;

            function success(response) {
                // get $http via $injector because of circular dependency problem
                $http = $http || $injector.get('$http');
                // don't send notification until all requests are complete
                if ($http.pendingRequests.length < 1) {
                    // get $rootScope via $injector because of circular dependency problem
                    rootScope = rootScope || $injector.get('$rootScope');
                    // send a notification requests are complete
                    rootScope.$broadcast(_END_REQUEST_);
                }
                return response;
            }

            function error(response) {
                // get $http via $injector because of circular dependency problem
                $http = $http || $injector.get('$http');
                // don't send notification until all requests are complete
                if ($http.pendingRequests.length < 1) {
                    // get $rootScope via $injector because of circular dependency problem
                    rootScope = rootScope || $injector.get('$rootScope');
                    // send a notification requests are complete
                    rootScope.$broadcast(_END_REQUEST_);
                }
                return $q.reject(response);
            }

            return function (promise) {
                // get $rootScope via $injector because of circular dependency problem
                rootScope = rootScope || $injector.get('$rootScope');
                // send notification a request has started
                rootScope.$broadcast(_START_REQUEST_);
                return promise.then(success, error);
            }
        }];

    $httpProvider.responseInterceptors.push(interceptor);
}]);

app.directive('loadingWidget', ['_START_REQUEST_', '_END_REQUEST_', function (_START_REQUEST_, _END_REQUEST_) {
    return {
        restrict: "A",
        link: function (scope, element) {
        	console.log("arranca", element);
            // hide the element initially
            element.show();

            scope.$on(_START_REQUEST_, function () {
                // got the request start notification, show the element
                console.log("start");
                element.show();
            });

            scope.$on(_END_REQUEST_, function () {
                // got the request end notification, hide the element
                console.log("end");
                element.hide();
            });
        }
    };
}]);

app.filter('startFrom', function () {
    return function (input, start) {
        start = +start; //parse to int
        return input.slice(start);
    }
});

// app.controller('myController', ['$scope', 'YeastResource', function ($scope, YeastResource) {
//     $scope.yeasts = [];
//     $scope.currentPage = 0;
//     $scope.pageSize = 10;

//     $scope.numberOfPages = function () {
//         return Math.ceil($scope.yeasts.length / $scope.pageSize);
//     };

//     $scope.init = function () {
//         YeastResource.query({}, {sort: {Type: 1, Name: 1}}).then(function (yeast) {
//             $scope.yeasts = yeast;
//         });
//     };

//     $scope.init();
// }]);


//****************************************************
//****************************************************
//****************************************************
//****************************************************
//****************************************************