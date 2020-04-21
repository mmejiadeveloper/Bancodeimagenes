
const state = {
	all: [],
	page: 1,
	limitOfRows: 1,
	rows: [],
	numberOfPages: 0.0
}

const actions = {
	setRowsData({ commit }, data) {
		commit('setRows', data);
		commit('setNumberOfPages');
	},

	setPaginatorConfiguration({ commit }, data) {
		commit('setPage', 1);
		commit('setLimit', data.limit);
	},

	paginatorPrevious({ commit }) {
		commit('setPageDecrease');
	},
	paginatorNext({ commit }) {
		commit('setPageIncrement');
	},
	goToPage( {commit}, page ){
		commit('setPage', page);
	}
}

const mutations = {
	setRows(state, rows) {
		state.all = rows
	},
	setPage(state, page) {
		state.page = page
	},
	setLimit(state, limit) {
		state.limitOfRows = limit
	},
	setNumberOfPages(state) {
		console.log(state.all.length, state.limitOfRows);
		let numberOfPages = (state.all.length / state.limitOfRows);
		state.numberOfPages = Math.ceil(numberOfPages);
	},
	setPageDecrease(state) {
		if (state.page > 1) {
			state.page--;
		}
	},
	setPageIncrement(state) {
		if ((state.page * state.limitOfRows) / (state.all.length) < 1) {
			state.page++;
		}
	},
}

const getters = {
	getPage: state => {
		return state.page;
	},
	getLimitOfRows: state => {
		return state.limitOfRows;
	},
	getRowsLength: state => {
		return state.all.length;

	},
	getNumberOfPages: state => {
		return state.numberOfPages;
	}
}

export default {
	namespaced: true,
	state,
	actions,
	mutations,
	getters

}