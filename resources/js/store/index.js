import Vue from 'vue'
import Vuex from 'vuex'

//****/
import users from './modules/users';
import posts from './modules/posts';
import createUserModal from './modules/createUserModal';
import header from './modules/header';

//****/
import localData from './plugins/localData';
import paginator from './plugins/paginator';
import filter from './plugins/filter';
//****/
Vue.use(Vuex)
//****/
export default new Vuex.Store({
	modules: {
		users,
		posts,
		createUserModal,
		header,

		paginator,
		filter,
		localData
	},
	/* strict: debug,
	plugins: debug ? [createLogger()] : [] */
}) 