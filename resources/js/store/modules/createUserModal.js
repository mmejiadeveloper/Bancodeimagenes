const state = {
	currentComponent: null,
	form: {
		name: "",
		email: "",
		password: "",
		phoneNumber: "",
		identificationNumber: "",
		profileId: "",
		userState: "",
		userId: '',
		file: null,
		loadedFileExistence: true,
		createdAt: ''
	},
	formMode: '',
	asyncRequests: {
		userIntegrity: 0,
		formStep: 0, //0 = pending, 1 = processed, 4 = Processing
		createUser: {
			status: 0, //0 = pending, 1 = processed
			message: "",
			data: []
		},
		updateUser: {
			status: 0 //0 = pending, 1 = processed
		}
	},
	loggedUser: window.loggedUser,
	url: null,
}

const actions = {
	setCurrentComponent({ commit } , component ) {
		commit('setComponent', component);
	},
	/* setFormMode( { commit }, mode ) {
		commit('setFormModeToNewUser', mode);
	} */
}

const mutations = {

	setLoggedUser (state, user) {
		state.loggedUser = user;
	},
	setUserData(state, user){ 
		//state.currentComponent.setUserDataToEdit(row);
		console.log('set', this._vm.$root.loggedUser, user);
		
		if (state.loggedUser != null) {
			state.form.name = state.loggedUser.name;
			state.form.email = state.loggedUser.email;
			state.form.identificationNumber =state.loggedUser.identificationNumber;
			state.form.password = state.loggedUser.passwordMask;
			state.form.phoneNumber = state.loggedUser.phoneNumber;
			state.form.userDepartmentId = state.loggedUser.userDepartmentId;
			state.form.userState = state.loggedUser.userState;
			state.form.profileId = state.loggedUser.profileId;
			state.form.userId = state.loggedUser.userId;
			state.url = 'endUserFiles/usersAvatar/' + state.loggedUser.userAvatarFileName;
			state.form.loadedFileExistence = state.loggedUser.photoProfileExistence;
			state.form.createdAt = state.loggedUser.created_at;
		}
		if(user) {
			state.form.name = user.name;
			state.form.email = user.email;
			state.form.identificationNumber = user.identificationNumber;
			state.form.password = user.passwordMask;
			state.form.phoneNumber = user.phoneNumber;
			state.form.userDepartmentId = user.userDepartmentId;
			state.form.userState = user.userState;
			state.form.profileId = user.profileId;
			state.form.userId = user.userId;
			state.url = 'endUserFiles/usersAvatar/' + user.userAvatarFileName;
			state.form.loadedFileExistence = user.loadedFileExistence;
			state.form.createdAt = user.created_at;
			console.log(user);
		}
	},
	setFormMode(state, mode) {
		state.formMode = mode;
	},

	setAsyncRequestField(state, payload){
		// console.log('set user integrity',  Object.values(payload));
		let index = Object.keys(payload)[0];
		let arr = index.split('.');
		if(arr.length <= 1) {
			state.asyncRequests[index] = Object.values(payload)[0];
		}
		if(arr.length > 1) {
			state.asyncRequests[arr[0]][arr[1]] = Object.values(payload)[0];
		}
		
	},
	resetFormUserData(state){
		state.form.name = '';
		state.form.email = '';
		state.form.identificationNumber = '';
		state.form.password = '';
		state.form.phoneNumber = '';
		state.form.userDepartmentId = '';
		state.form.userState = '';
		state.form.profileId = '';
		state.form.userId = '';
		state.url = '';
		state.form.loadedFileExistence = '';
	},
	
	setFileProfileUrl(state, url){
		state.url = url;
	}
}

const getters = {
	getUserForm: state => {
		return state.form;
	},
	getFormMode: state => {
		return state.formMode;
	},
	getAsyncRequests: state =>{
		return state.asyncRequests;
	},
	getLoggedUser: state =>{
		return state.loggedUser;
	},
	getFileProfileUrl: state =>{
		return state.url;
	},
}

export default {
	namespaced: true,
	state,
	actions,
	mutations,
	getters

}