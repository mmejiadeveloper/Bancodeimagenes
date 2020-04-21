<template>
	<div v-if="post.currentUserFavorite" class="row py-3 px-5 row-card-top customColor">
		<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left px-0">
			<div>
				<small>{{ post.postTypeName }}</small> /
				<small>{{ post.categoryName }}</small>
			</div>
			<div>
				<b class="fs24 ln">{{ post.postName }}</b>
			</div>
			<div>
				<small class="ln">
					C&oacute;digo de imagen:
					<b>ES{{ post.postId }}</b>
				</small>
			</div>
		</div>
		<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right px-0 d-flex">
			<div class="row justify-content-center align-self-center ml-auto">
				<div class="favorite mx-2">
					<img
						@click="$parent.$refs.postdetail.updateFavorite(post)"
						v-if="post.currentUserFavorite.postFavoriteId != 0"
						src="img/AppTemplate/Modules/Posts/filledHearth.png"
						alt
					>
					<img
						@click="$parent.$refs.postdetail.updateFavorite(post)"
						v-else
						src="img/AppTemplate/Modules/Posts/hearth.png"
						alt
					>
					<!-- <img @click="$parent.$refs.postdetail.updateFavorite(post)"  src="img/AppTemplate/Modules/Posts/hearth.png" alt> -->
				</div>

				<button
					@click=" download"
					style="height:48px;"
					type="button"
					class="btn btn-danger"
				>
					<i class="fas fa-cloud-download-alt mr-3"></i> Descargar imagen
				</button>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex';
export default {
	name: 'toppart-form',
	computed: {
		...mapGetters({
			imageStatistics: 'posts/getImageStatistics',
			form: 'posts/getFormData',
			post: 'posts/getloadedPostForDetail'
		})
	},

	methods: {
		download() {
			this.$store.dispatch('posts/openModalDetail', this.post);
			this.$parent.$refs.postdetail.downloadMode = true;
		}
	},
	mounted () {
		if(Object.keys(this.post).length <=0) {
			this.$store.commit('posts/setLoadedPostForDetail', this.altPost);
		}
	},

	props: {
		altPost: {
			type: Object
		},
	},
}
</script>

<style lang="scss" scoped>
.fs24 {
	font-size: 24px;
}
.customColor {
	color: #656565;
}
.ln {
	line-height: 0.9;
}

.favorite {
	position: relative;
	background: rgba(167, 167, 167, 0.6);
	height: 50px;
	width: 50px;
	top: 0%;
	left: 0%;
}

.favorite > img {
	cursor: pointer;
}
</style>