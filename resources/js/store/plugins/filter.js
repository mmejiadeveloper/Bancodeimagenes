
const state = {
	actionData: {
		ref: "",
		jqueryElements: [],
		toggledVariable: "",
		modalEffect: false
	},

	__vmInstance: null

}

const actions = {
	toggleVariableAndSetModalEffect({ commit }, cb = null) {
		commit('toggleVariable');
		commit('openModal');
		if (cb) {
			cb();
		}
	},

	initializeFilter({ commit }, __vmInstance) {
		commit('setVueInstance', __vmInstance)
		commit('setActionData');
	},
	initializeFilterForCustomModal({ commit }, __vmInstance) {
		commit('setVueInstance', __vmInstance)
		commit('setActionDataForCustomModa');
	}
}

const mutations = {

	setVueInstance(state, __vmInstance) {
		state.__vmInstance = __vmInstance;
	},

	setActionData(state) {
		if (state.__vmInstance.toggleData) {
			state.actionData.ref = state.__vmInstance.toggleData.ref;
			state.actionData.modalEffect = state.__vmInstance.toggleData.modalEffect;
			state.actionData.jqueryElements = state.__vmInstance.toggleData.jqueryElements;
		}

	},

	setActionDataForCustomModa(state) {
		state.actionData.ref = state.__vmInstance.toggleData[state.__vmInstance.toggleData.idGroup].ref;
		state.actionData.modalEffect = state.__vmInstance.toggleData[state.__vmInstance.toggleData.idGroup].modalEffect;
		state.actionData.jqueryElements = state.__vmInstance.toggleData[state.__vmInstance.toggleData.idGroup].jqueryElements;


	},

	toggleVariable(state) {
		console.log('this' ,state.__vmInstance.toggleData );	
		// console.log('this' + state.__vmInstance.toggleData.idGroup );	
		state.__vmInstance.toggleData[state.__vmInstance.toggleData.idGroup].filter.visible = !state.__vmInstance.toggleData[state.__vmInstance.toggleData.idGroup].filter.visible;
	},

	openModal(state) {
		if (state.actionData.modalEffect) {
			window.currentVrouteComponent = state.__vmInstance;
			state.__vmInstance.$CustomModal.actions.openCustomModal(
				state.actionData.jqueryElements,
				state.actionData.ref,
				state.__vmInstance.toggleData.idGroup,
				null,
				true
			);
		}
	}



}

const getters = {
}

export default {
	namespaced: true,
	state,
	actions,
	mutations,
	getters

}