app.controller('UserGroupsCtrl', ['$scope', 'growl', 'UserGroup', 'cfpLoadingBar', function($scope, growl, UserGroup, $filter, cfpLoadingBar) {
	$scope.user_groups = UserGroup.all();
	$scope.my_bets = new Array();
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

	$scope.start = function() {
		// cfpLoadingBar.start();
		// ret = UserGroup.query(64);
		ret = UserGroup.matches(64, 1);
		console.log(ret);
	};

	$scope.init = function(id){

    // fake the initial load so first time users can see it right away:
    // $scope.start();
    // $scope.fakeIntro = true;
    // $timeout(function() {
    //   $scope.complete();
    //   $scope.fakeIntro = false;
    // }, 750);




		// console.log(id);
		// $scope.current_group = UserGroup.view(id)
		// console.log($scope.current_group);
		$scope.id = id

		ret = UserGroup.query(id);
		ret.$promise.then(
			// success
			function(result){
				$scope.current_group = result;
				$scope.matches = new Array();

				// $scope.current_group.league.dates_count = 1;

				for (var i=1; i<=$scope.current_group.league.dates_count; i++) {
					$scope.matches[i] = UserGroup.matches(id, i);
				};
			}
		);

		ret = UserGroup.myBets(id);
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
	};

}]);
