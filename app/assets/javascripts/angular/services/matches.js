app.factory('Match', ['$resource', function($resource) {

	function Match() {
		this.service = $resource('/api/matches/:matchId', {matchId: '@id'});
	};
	Match.prototype.all = function() {
		return this.service.query();
	};
	Match.prototype.delete = function(stId) {
		this.service.remove({userGroupId: stId});
	};
	Match.prototype.create = function(attr) {
		return this.service.save(attr)
	}
	// Match.prototype.search = function(name) {
	// 	return this.service.search(name)
	// }
	// Match.prototype.inviteUser = function(id, email) {
	// 	var service = $resource('/api/user_groups/:userGroupId/inviteUser/', {userGroupId: id}, 
	// 						{'inviteUser': {method: 'POST', isArray: true}}
	// 					);
	// 	return service.inviteUser({email: email});
	// }
	return new Match;
}]);