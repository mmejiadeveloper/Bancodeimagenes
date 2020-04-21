const state = {
	categories: [],
	totalNumberOfPosts: 0,
	searchInfomation: {
		searchText: "",
		searStatus: ""
	},
}

const actions = {
	getCategories(context, ck = null) {
		this._vm.$IGeneral.asyncRequest("header/__findCategories", null, [response => {
			if (response) {
				let postNumber = 0;
				context.commit('setCategories', response.data);
				$.map(response.data, function (elementOrValue, indexOrKey) {
					postNumber += parseInt(elementOrValue.numberOfPosts);
				});
				context.commit('setTotalNumberOfPost', postNumber);
			}
		}]);
	},
}

const mutations = {
	setCategories(state, categories) {
		state.categories = categories
	},
	setTotalNumberOfPost(state, totalNumberOfPosts) {
		state.totalNumberOfPosts = totalNumberOfPosts
	},
	setSearchInformationObject(state, searchInfomation) {
		state.searchInfomation = searchInfomation
	},
}

const getters = {
	getCategories: state => {
		return state.categories;
	},
	getTotalNumberOfPosts: state => {
		return state.totalNumberOfPosts;
	},
	getSearchInformationObject: state => {
		return state.searchInfomation;
	},
}

export default {
	namespaced: true,
	state,
	actions,
	mutations,
	getters
}