<template>
	<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 pr-0">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pr-0 px-0">
				<img style="max-width: 100%" :src="form.lowQualityFile.url">
			</div>
		</div>
	</div>

	
</template>

<script>
import { mapGetters } from 'vuex';
export default {
	name: 'leftpart-form',
	computed: {
		...mapGetters({
			form: 'posts/getFormData',
			categories: 'posts/getCategories',
			types: 'posts/getTypes',
			users: 'posts/getUsers',
		})
	},
	methods: {

	},
	inject: ['parentValidator'],
	created() {
		this.$validator = this.parentValidator
		console.log(this.$root.loggedUser)
	}
}
</script>

<style lang="scss" scoped>
</style>