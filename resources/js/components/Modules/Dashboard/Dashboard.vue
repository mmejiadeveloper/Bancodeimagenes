<template>
	<div REQUIRED-FOR-TEMPLATE="dashboard">
		<AppHeader ref="appheader"/>
		<AppBody ref="appbody"/>
		<AppFooter ref="appfooter"/>
		<vue-snotify/>
	</div>
</template>

<script >
import AppHeader from '../../AppTemplate/Header/Header';
import AppBody from '../../AppTemplate/Body/Body';
import AppFooter from '../../AppTemplate/Footer/Footer';
export default {
	name: 'dashboard',
	components: {
		'AppHeader': AppHeader,
		'AppBody': AppBody,
		'AppFooter': AppFooter,
	},

	computed: {
		loader() {
			return this.$loading.show({
				container: this.fullPage ? null : this.$refs.formContainer,
				canCancel: true,
				onCancel: this.onCancel,
				backgroundColor: '#000',
				opacity: 0.9,
				color: '#fff'
			});
		}
	},

	mounted () {
		// this.$store.commit('createUserModal/setLoggedUser',  )
	},
}
</script> 
