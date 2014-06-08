app.controller('UserGroupsCtrl', ['$scope', 'growl', 'UserGroup', 'cfpLoadingBar', function($scope, growl, UserGroup, $filter, cfpLoadingBar) {
	$scope.user_groups = UserGroup.myGroups();
	// $scope.my_bets = new Array();
	// console.log($scope.user_groups);
	
	// ret.$promise.then(
	// 	// success
	// 	function(result){
	// 		console.log('success', result);
	// 		$scope.current_group = result;
	// 	},
	// 	// error
	// 	function(error){
	//     	// handle some error exception
	//     	console.log('error', error);
	//     }
	// );

	$scope.addSpecialWarnMessage = function() {
		// growl.addWarnMessage("This adds a warn message");
		// growl.addInfoMessage("This adds a info message");
		// growl.addSuccessMessage("This adds a success message");
		// growl.addErrorMessage("This adds a error message");
	}

	$scope.createUserGroup = function() {
		var attr = {};
		attr.name = $scope.newName;
		attr.league_id = $scope.newLeague;
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

	$scope.inviteUser = function(id, idx) {
		if (idx){
			newMemberEmail = $scope.user_groups[idx].newMemberEmail;
		} else {
			newMemberEmail = $scope.newMemberEmail;
		}
		
		var ret = UserGroup.inviteUser(id, newMemberEmail);
		ret.$promise.then(
			// success
			function(result){
				// $scope.user_groups[idx].members = result
				// $scope.user_groups[idx].newMemberEmail = "";
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
				$scope.my_bets[matchId].bet = { bet: bet };
			},
			// error
			function(error){
				// handle some error exception
				$scope.my_bets[matchId].bet = { bet: null };
			}
		);
	};

	$scope.acceptInvitation = function(id) {
		var ret = UserGroup.acceptInvitation(id);
		ret.$promise.then(function(result){
			
		});
	};

	$scope.rejectInvitation = function(id) {
		var ret = UserGroup.rejectInvitation(id);
		ret.$promise.then(function(result){

		});
	};

	$scope.init = function(id){
		$scope.id = id

		ret = UserGroup.query(id);
		ret.$promise.then(
			// success
			function(result){
				$scope.current_group = result;
				$scope.matches = new Array();

				for (var i=0; i<$scope.current_group.league.dates_count; i++) {
					$scope.matches[i] = UserGroup.matches(id, i+1);
				};
			}
		);

		$scope.my_bets = new Array();
		ret = UserGroup.myBets(id);
		ret.$promise.then(
			// success
			function(result){
				myBets = result;
				for (var i = 0; i < myBets.length; i++) {
					var match = myBets[i].match;
					var bet = myBets[i].bet;
					if (bet != null){
						$scope.my_bets[match.id] = { bet: bet };
					} else {
						$scope.my_bets[match.id] = { bet: null };
					}
				}
			},
			// error
			function(error){
				// handle some error exception
			}
		);
	};

}]);
