app.factory('UserGroup', ['$resource', function($resource) {

	function UserGroup() {
		this.service = $resource('/api/user_groups/:userGroupId', 
									{userGroupId: '@id'}
									// {'query': {isArray: true}}
								);
	};
	UserGroup.prototype.query = function(id) {
		return this.service.get({userGroupId: id});
	};
	UserGroup.prototype.all = function() {
		return this.service.query();
	};
	UserGroup.prototype.delete = function(stId) {
		this.service.remove({userGroupId: stId});
	};
	UserGroup.prototype.create = function(attr) {
		return this.service.save(attr)
	}
	UserGroup.prototype.search = function(name) {
		return this.service.search(name)
	}
	UserGroup.prototype.myGroups = function() {
		var service = $resource('/api/user_groups/my_groups', {}, 
							{'my_groups': {method: 'GET', isArray: true}}
						);
		return service.my_groups();
	}
	UserGroup.prototype.inviteUser = function(id, email) {
		var service = $resource('/api/user_groups/:userGroupId/invite_user/', {userGroupId: id}, 
							{'invite_user': {method: 'POST', isArray: true}}
						);
		return service.invite_user({email: email});
	}
	UserGroup.prototype.betMatch = function(id, matchId, bet) {
		var service = $resource('/api/user_groups/:userGroupId/bet_match/', {userGroupId: id}, 
							{'bet_match': {method: 'POST', isArray: false}}
						);
		return service.bet_match({match_id: matchId, bet: bet});
	}
	UserGroup.prototype.myBets = function(id) {
		var service = $resource('/api/user_groups/:userGroupId/my_bets/', {userGroupId: id}, 
							{'my_bets': {method: 'GET', isArray: true}}
						);
		return service.my_bets();
	}
	UserGroup.prototype.matches = function(id, leagueDate) {
		var service = $resource('/api/user_groups/:userGroupId/matches/:leagueDate', {userGroupId: id, leagueDate: leagueDate}, 
							{'matches': {method: 'GET', isArray: true}}
						);
		return service.matches();
	}
	UserGroup.prototype.acceptInvitation = function(id) {
		var service = $resource('/api/user_groups/:userGroupId/accept_invitation', {userGroupId: id}, 
							{'accept_invitation': {method: 'POST', isArray: false}}
						);
		return service.accept_invitation();
	}
	UserGroup.prototype.rejectInvitation = function(id) {
		var service = $resource('/api/user_groups/:userGroupId/reject_invitation', {userGroupId: id}, 
							{'reject_invitation': {method: 'POST', isArray: false}}
						);
		return service.reject_invitation();
	}
	UserGroup.prototype.notifications = function() {
		var service = $resource('/api/user_groups/notifications', {}, 
							{'notifications': {method: 'GET', isArray: true}}
						);
		return service.notifications();
	}
	return new UserGroup;
}]);