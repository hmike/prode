app.controller('UserGroupsCtrl', ['$scope', 'growl', 'UserGroup', function($scope, growl, UserGroup, $filter) {
	$scope.user_groups = UserGroup.all();
	$scope.my_bets = new Array();
	

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
		var ret = UserGroup.inviteMember(id, newMemberEmail);
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

	$scope.getBetLang = function(bet) {
		if (bet == 0){
			return 'empate';
		} else if (bet == 1){
			return 'local';
		} else {
			return 'visitante';
		}
	}

	$scope.betMatch = function(id, matchId, bet) {
		var ret = UserGroup.betMatch(id, matchId, bet);

		ret.$promise.then(
			// success
			function(result){
				$scope.my_bets[matchId].bet = bet;

			},
			// error
			function(error){
		    	// handle some error exception
		    	$scope.my_bets[matchId].bet = '';
			}
		);
	};

	//@todo: hmike: get UserGroup id
	ret = UserGroup.myBets(33);
	ret.$promise.then(
			// success
			function(result){
				myBets = result;
				for (var i = 0; i < myBets.length; i++) {
					var bet = myBets[i]
					if (bet.bet != null){
						$scope.my_bets[bet.match] = { bet: bet.bet.bet.bet };
					} else {
						$scope.my_bets[bet.match] = { bet: '' };
					}
				}
			},
			// error
			function(error){
		    	// handle some error exception
			}
		);
}]);
