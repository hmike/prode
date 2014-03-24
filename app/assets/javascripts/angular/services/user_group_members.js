app.factory('UserGroupMember', ['$resource', function($resource) {
	function UserGroupMember() {
		this.service = $resource('/api/user_group_members/:userGroupMemberId', {userGroupMemberId: '@id'});
	};
	UserGroup.prototype.all = function() {
		return this.service.query();
	};
	UserGroup.prototype.delete = function(stId) {
		this.service.remove({UserGroupMemberId: stId});
	};
	UserGroup.prototype.create = function(attr) {
		return this.service.save(attr)
	}
	return new UserGroupMember;
}]);
