app.controller('UserGroupsCtrl', ['$scope', 'UserGroup', function($scope, UserGroup, $filter) {
	$scope.user_groups = UserGroup.all();

	$scope.createUserGroup = function() {
		var attr = {};
		// attr.name = $filter('uppercase')($scope.newSymbol);
		attr.name = $scope.newName;
		var newUserGroup = UserGroup.create(attr);
		console.log(newUserGroup);
   		$scope.user_groups.push(newUserGroup);
		$scope.newUserGroup = "";
		$scope.newName = "";
		// $scope.error = true;



		// //Create the forum object to send to the back-end
  //       var newUserGroup = new UserGroup($scope.newName);
		// //Save the forum object
		// newUserGroup.$save(function() {
		// 	//Redirect us back to the main page
		// 	// $location.path('/');
		// 	$scope.user_groups.push(userGroup);

		// }, function(response) {
		// 	//Post response objects to the view
		// 	// $scope.errors = response.data.errors;
  //           $scope.error = true;
		// });
	};

	$scope.deleteUserGroup = function(id, idx) {
		UserGroup.delete(id);
		$scope.user_groups.splice(idx, 1);
	};

	$scope.searchUserGroup = function() {
		searchedUserGroups = UserGroup.search($scope.searchName);
		console.log(searchedUserGroups);
		$scope.user_groups = searchedUserGroups;
	};
}]);