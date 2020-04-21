import dataSource from '../../api/dataSource';

const state = {
	all: [],
	form: {
		originalPhotoFile: {
			url: '',
			file: null,
			loadedFileName: ''
		},
		lowQualityFile: {
			url: '',
			file: null,
			loadedFileName: ''
		},
		postId: 0,
		postName: '',
		userId: '',
		postCategoryId: '',
		postTypeId: '',
		postDescription: '',
		postState: true,
		asyncRequests: {
			status: 0
		},

		filterForm: {

		},

		tagsForm: {

		},

		postStadistics : {}

	},

	loadedPostForDetail: {},
	imageStatistics: {
		visible: false,
		appliesForCustomModalPlugin: true
	},
	mode: "create",

	categories: [],
	types: [],
	users: [],
	tags: [],
	filters: [],

	asyncRequest: null

}

const actions = {
	getAllPosts(context, ck = null) {
		const loader =  this._vm.$loading.show({
			container: this.fullPage ? null : this._vm.$refs.formContainer,
			canCancel: true,
			onCancel: this.onCancel,
			backgroundColor: '#000',
			opacity: 0.9,
			color: '#fff'
		});

		this._vm.$IGeneral.asyncRequest("posts/__loadPosts", null, [response => {
			loader.hide();
			if (response) {
				dataSource.getUsers(posts => { context.commit('setPosts', response.posts) })
				context.dispatch('header/getCategories', {}, { root: true })
				if (ck) {
					ck();
				}
			}
		}]);
	},

	setAllPostSettings({ commit }, data, ck = null) {
		commit('setCategories', data.categories);
		commit('setUsers', data.users);
		commit('setTypes', data.types);
		commit('setTags', data.tags);
		commit('setTags', data.tags);
		commit('setFilters', data.filters);
	},

	openModalDetail({ commit, state }, item, closeModal = false) {


		if (state.asyncRequest === null) {
			state.asyncRequest = this._vm.$IGeneral.asyncRequest("posts/__loadPost", item, [response => {
				if (response) {
					state.asyncRequest = null;
					if (response.type === 1) {
						// console.log('xxx', item);
						commit('setLoadedPostForDetail', response.post);
						console.log('1', item.cerrarModal);
						if (!item.cerrarModal || typeof (item.cerrarModal) === "undefinied") {
							$('#postDetailModal').modal('show');
						}
					}
				}
			}]);
		}
	},


}

const mutations = {
	setPosts(state, posts) {
		state.all = posts
	},
	setCategories(state, categories) {
		state.categories = categories
	},
	setTypes(state, types) {
		state.types = types
	},
	setUsers(state, users) {
		state.users = users
	},
	setForm(state, form) {
		state.form = form
	},
	setFormRowData(state, data) {
		state.form.postId = data.postId;
		state.form.postName = data.postName;
		state.form.userId = data.userId;
		state.form.postCategoryId = data.postCategoryId;
		state.form.postTypeId = data.postTypeId;
		state.form.postDescription = data.postDescription;
		state.form.postState = data.postState;
		state.form.originalPhotoFile = data.originalPhotoFile;
		state.form.lowQualityFile = data.lowQualityFile;
		state.form.postStadistics = data.postStadistics;
	},
	cleanFormRowData(state) {
		state.form.postId = 0;
		state.form.postName = '';
		state.form.userId = '';
		state.form.postCategoryId = '';
		state.form.postTypeId = '';
		state.form.postDescription = '';
		state.form.postState = true;
		state.form.originalPhotoFile.url = '';
		state.form.originalPhotoFile.file = null;
		state.form.lowQualityFile.url = '';
		state.form.lowQualityFile.file = null;
		state.form.tagsForm = {};
		state.form.filterForm = {};
	},
	setFormTagsAndFilters(state, data) {
		state.form.tagsForm = data.tags;
		state.form.filterForm = data.filters;

	},
	setFormAsyncRequestStatus(state, value) {
		state.form.asyncRequests.status = value
	},
	setTags(state, tags) {
		state.tags = tags
	},
	setFilters(state, filters) {
		state.filters = filters
	},
	setMode(state, mode) {
		state.mode = mode
	},
	setPostId(state, postId) {
		state.form.postId = postId
	},
	setLoadedPostForDetail(state, post) {
		state.loadedPostForDetail = post;
	},


}

const getters = {
	getloadedPostForDetail() {
		return state.loadedPostForDetail;
	},
	getImageStatistics: state => {
		return state.imageStatistics;
	},
	getPosts: state => {
		return state.all;
	},
	getPost: state => {
		return state.post;
	},
	getFormData: state => {
		return state.form;
	},
	getMode: state => {
		return state.mode;
	},
	getCategories: state => {
		return state.categories;
	},

	getTypes: state => {
		return state.types;
	},
	getUsers: state => {
		return state.users;
	},
	getTags: state => {
		return state.tags;
	},
	getFilters: state => {
		return state.filters;
	},

}

export default {
	namespaced: true,
	state,
	actions,
	mutations,
	getters

}