app.controller('UserGroupsCtrl', ['$scope', 'growl', 'UserGroup', function($scope, growl, UserGroup, $filter) {
	$scope.user_groups = UserGroup.all();

	$scope.addSpecialWarnMessage = function() {
        // growl.addWarnMessage("This adds a warn message");
        // growl.addInfoMessage("This adds a info message");
        // growl.addSuccessMessage("This adds a success message");
        // growl.addErrorMessage("This adds a error message");
    }


	$scope.createUserGroup = function() {
		var attr = {};
		attr.name = $scope.newName;
		var newUserGroup = UserGroup.create(attr);
   		$scope.user_groups.push(newUserGroup);
		$scope.newUserGroup = "";
		$scope.newName = "";
	};

	$scope.deleteUserGroup = function(id, idx) {
		UserGroup.delete(id);
		$scope.user_groups.splice(idx, 1);
	};

	$scope.searchUserGroup = function() {
		searchedUserGroups = UserGroup.search($scope.searchName);
		$scope.user_groups = searchedUserGroups;
	};

	$scope.inviteMember = function(id, idx) {
		newMemberEmail = $scope.user_groups[idx].newMemberEmail;
		var ret= UserGroup.inviteMember(id, newMemberEmail);
		ret.$promise.then(
			// success
			function(result){
				$scope.user_groups[idx].members = result
				$scope.user_groups[idx].newMemberEmail = "";
			},
			// error
			function(error){
		    	// handle some error exception
			}
		);
	};
	
}]);
