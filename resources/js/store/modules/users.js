import dataSource from '../../api/dataSource';

const state = {
	all: [],
	usersTypes: [],
	userDepartments: [],
}

const actions = {
	
	getAllUsers({ commit }, ck = null) {
		const loader =  this._vm.$loading.show({
			container: this.fullPage ? null : this._vm.$refs.formContainer,
			canCancel: true,
			onCancel: this.onCancel,
			backgroundColor: '#000',
			opacity: 0.9,
			color: '#fff'
		});
		this._vm.$IGeneral.asyncRequest("users/__loadUsers", null, [response => {
			loader.hide();
			if (response) {
				dataSource.getUsers(users => { commit('setUsers', response.users) })
				if (ck) {
					ck();
				}
			}
		}]);
	},
	loadUsersTypes({ commit }) {
		this._vm.$IGeneral.asyncRequest("usersTypes/__loadUserProfiles", null, [response => {
			if (response) {
				commit('setUsersTypes', response.userProfiles);
			}
		}]);
	},
	loadUserDepartments({ commit }) {
		this._vm.$IGeneral.asyncRequest("users/__loadUserDepartments", null, [response => {
			if (response) {
				commit('setUsersDepartments', response.userDepartments);
			}
		}]);
	},
}

const mutations = {
	setUsers(state, users) {
		state.all = users
	},
	setUsersTypes(state, usersTypes) {
		state.usersTypes = usersTypes
	},
	setUsersDepartments(state, userDepartments) {
		state.userDepartments = userDepartments
	},
}

const getters = {
	getUsers: state => {
		return state.all;
	},
	getUsersTypes: state => {
		return state.usersTypes;
	},
	getUsersDepartments: state => {
		return state.userDepartments;
	},
}

export default {
	namespaced: true,
	state,
	actions,
	mutations,
	getters

}