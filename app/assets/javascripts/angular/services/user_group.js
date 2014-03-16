app.factory('UserGroup', ['$resource', function($resource) {

	function UserGroup() {
		this.service = $resource('/api/user_groups/:userGroupId', {userGroupId: '@id'});
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
	UserGroup.prototype.inviteMember = function(id, email) {
		var service = $resource('/api/user_groups/:userGroupId/inviteMember/', {userGroupId: id}, 
							{'inviteMember': {method: 'POST', isArray: true}}
						);
		return service.inviteMember({email: email});
	}
	return new UserGroup;
}]);