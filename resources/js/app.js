//External plugins
require('./bootstrap');
import Vue from 'vue';
import VueRouter from 'vue-router';
import VueSweetalert2 from 'vue-sweetalert2';
import VModal from 'vue-js-modal'
import VTooltip from 'v-tooltip'
import Snotify from 'vue-snotify';
import 'vue-snotify/styles/material.css'
import VeeValidate from 'vee-validate';
import validationMessages_US_EN from 'vee-validate/dist/locale/en';
import validationMessages_CO_ES from 'vee-validate/dist/locale/es';
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

//Internal plugiins & components
import { routes } from './router';
import Login from './components/AppTemplate/Login/Login';
import Dashboard from './components/Modules/Dashboard/Dashboard';
import IGeneral from './components/Internal/IGeneral';
import CustomModal from './components/Internal/CustomModal';
//state managmebt
import store from './store';


// Use section
Vue.use(Loading);
Vue.use(VueSweetalert2);
Vue.use(VueRouter);
Vue.use(IGeneral)
Vue.use(CustomModal)
Vue.use(VModal)
Vue.use(VTooltip)
Vue.use(Snotify)
Vue.use(VeeValidate, {
	locale: 'es',
	dictionary: {
		es: validationMessages_CO_ES
	},
	classes: true,
	classNames: {
		valid: 'is-valid',
		invalid: 'is-invalid'
	},
	inject: true
});

// Declare section
const router = new VueRouter({
	routes,
	mode: 'history'
});

// console.log(window.backGroundData);


const app = new Vue({
	el: '#app',
	router,
	store,
	components: {
		Login,
		Dashboard,
	},
	created() {
		$('.customModal').hide();
		window.root = this;
		window.swal = this.$swal;
		// console.log();
		
		// delete window.loggedUser;
	},
	data() {
		return {
			loggedUser: window.loggedUser,
			backGroundData:window.backGroundData
			// tiedComponents: {}
		}
	},
});

