<template>
	<div id="postDetailModal" class="modal fade" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true" >
		<div v-if="!downloadMode" class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-body" v-if="Object.keys(post).length > 0">
					<div class="closex" @click="closeModal" ><i class="fas fa-times    "></i></div>
					<div class="row text-center px-4">
						<div class="col-xs-7 col-md-7 col-lg-7 col-sm-7 text-left px-0">
							<div>
								<b>{{ post.postName }}</b>
							</div>
							<div>
								<small>{{ post.postTypeName }}</small> /
								<small>{{ post.categoryName }}</small>
							</div>
						</div>
						<div class="col-xs-5 col-md-5 col-lg-5 col-sm-5 text-right px-0">
							<button
								@click=" downloadMode = !downloadMode"
								style="height:48px;"
								type="button"
								class="btn btn-danger"
							>
								<i class="fas fa-cloud-download-alt mr-3"></i> Descargar imagen
							</button>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
							<div class="favorite">
								<img
									@click="updateFavorite(post)"
									v-if="post.currentUserFavorite.postFavoriteId != 0"
									src="img/AppTemplate/Modules/Posts/filledHearth.png"
									alt
								>
								<img
									@click="updateFavorite(post)"
									v-else
									src="img/AppTemplate/Modules/Posts/hearth.png"
									alt
								>
							</div>
							<img v-if="post.lowQualityFile" width="747" height="466" :src="post.lowQualityFile.url">
						</div>
					</div>
					<div class="row mt-3 text-center px-4">
						<div class="col-xs-8 col-md-8 col-lg-8 col-sm-8 text-left px-0">
							<div class="row">
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left">
									<b>Rese&ntilde;a de la imagen</b>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left">{{ post.postDescription }}</div>

								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left">
									<div>
										<b>Etiquetas</b>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left">
									<div class="form-inline">
										<div v-for="(tag, index) in post.postTags" :key="'tag'+index" class="tag p-1 m-1">
											<span>{{ tag.tagName }}</span>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xs-4 col-md-4 col-lg-4 col-sm-4 text-right px-2">
							<div class="text-center autorInfo">
								<div class="row">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<img class="autorPhoto" :src="'endUserFiles/usersAvatar/'+post.userAvatarFileName" alt>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<small class="autorFontColor">Autor</small>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<b class="autorFontColor">
											<u v-html="post.autorName"></u>
										</b>
									</div>
								</div>
								<div class="row mt-3">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<small class="autorFontColor">Datos de uso de la imagen</small>
									</div>
								</div>
								<div class="row mt-2" v-tooltip="post.downloads.toString()">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<div class="mx-auto w-50 stat">
											<div style="width:35%">
												<i class="fas fa-cloud-download-alt mr-1"></i>
											</div>
											<div style="width:65%">
												<div
													v-if="post.downloads.toString().length > 7 "
												>{{ post.downloads.substring(0,7) + '...' }}</div>
												<div v-else>{{ post.downloads}}</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row mt-2 mb-4" v-tooltip="post.favorites.toString()">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<div class="mx-auto w-50 stat">
											<div style="width:35%">
												<i class="fas fa-heart mr-1"></i>
											</div>
											<div style="width:65%">
												<div
													v-if="post.favorites.toString().length > 7 "
												>{{ post.favorites.substring(0,7) + '...' }}</div>
												<div v-else>{{ post.favorites}}</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<PostDownload  class="modal-dialog " />
	</div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
import PostDownload from './PostDownload';
export default {
	name: 'post-detail',
	data() {
		return {
			favorite: false,
			asyncRequest: null,
			downloadMode: false
		}
	},
	computed: {
		...mapGetters({
			post: 'posts/getloadedPostForDetail'
		})
	},

	components: {
		PostDownload
	},

	methods: {
		updateFavorite(post = null) {
			if (this.asyncRequest == null) {
				let data = {
					userId: this.$root.loggedUser.userId,
					postId:  post == null ?  this.post.postId : post.postId,
					postFavoriteId: post == null ?  this.post.currentUserFavorite.postFavoriteId : post.currentUserFavorite.postFavoriteId,
				}
				this.asyncRequest = this.$IGeneral.asyncRequest("posts/__favorite", data, [response => {
					if (response) {

						this.asyncRequest = null;
						if (response.type == 1) {
							console.log(response);
							this.$store.commit('posts/setLoadedPostForDetail', response.data);
							this.$snotify.html(response.message, {
								showProgressBar: false,
							});
							if(this.$router.currentRoute.name == 'enduserfavorites' ){
								this.$parent.loadFavorites();
							}
						} else {
							this.$snotify.error(response.message, {
								showProgressBar: false,
							});
						}
					}
				}]);
			}
		},
		closeModal(){
			$('#postDetailModal').modal('hide');
		}
	},

}
</script>

<style lang="scss" >
.autorFontColor {
	color: #797979;
}

.tag {
	background: #b1b1b1;
	text-align: center;
	color: white;
	font-weight: 500;
	font-size: 12px;
}

.autorPhoto {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	border: 2px solid #fff;
	position: relative;
	top: -15px;
}

.autorInfo {
	position: relative;
	top: -36px;
	border: 1px solid #c7c7c7;
	border-radius: 7px;
	background: rgba(255, 255, 255, 0.2);
	// width: 90%;
}

.stat {
	border: 1px solid #848484;
	border-radius: 5px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

.favorite {
	position: absolute;
	background: rgba(132, 132, 132, 0.6);
	height: 50px;
	width: 50px;
	top: 7px;
	left: 30px;
	padding: 13px;
}

.favorite > img {
	cursor: pointer;
}

.snotifyToast__inner {
	color: #fff;
	background-color: green;
}

.closex{
	cursor: pointer;
    position: absolute;
    height: 25px;
    width: 25px;
    right: -34px;
    top: -23px;
    background: white;
    /* padding: 3px; */
    font-size: 15px;
    border-radius: 50%;
}
</style>