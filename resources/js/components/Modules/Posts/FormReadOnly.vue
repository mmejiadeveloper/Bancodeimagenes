<template>
	<div REQUIRED-FOR-TEMPLATE="posts.form" ref="postsform">
		<PostDetails ref="postdetail" />
		<form class="w-100" :data-vv-scope="'postForm'" v-if="post.lowQualityFile">
			<div class="row text-center centeredFrom1100 upperRow">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
					<BodyHeaderPart1 :mode="mode" :actionData="actionData" ref="bodyheaderpart1"/>
					<ToppartForm :altPost="post" />
					<div class="row borderred row-card-white">
						<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
							<div class="row">
								<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12  pr-0 px-0">
									<img style="max-width: 100%" :src="post.lowQualityFile.url">
								</div>
							</div>
						</div>
					</div>

					<div class="row borderred row-card-white px-4">
						<div class="col-xs-9 col-md-9 col-lg-9 col-sm-9 text-center">
							<div class="row">
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left">
									<b>Rese&ntilde;a de la imagen</b>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left">{{ post.postDescription }}</div>

								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left mt-3">
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

								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left mt-3">
									<div>
										<b>Im&aacute;genes similares</b>
									</div>
								</div>

								<div v-if="posts.length > 0" class="col-sm-12 col-md-12 col-lg-12 col-xl-12 p-3">
									<Waterfall :maxCol="4">
										<WaterfallItem
											:width="250"
											v-for="(item, index) in posts"
											:key="index"
											class="grid-item item animated fadeIn my-2"
										>
											<div class="coverText">
												<div class="link">
													<div @click="$store.dispatch('posts/openModalDetail',item, true )" class="link-detail p-2 mr-3">
														<i class="fas fa-expand"></i>
													</div>
													<div @click="loadPost(item)" class="link-detail p-2">
														<i class="fas fa-link"></i>
													</div>
												</div>

												<div class="postData">
													<div class="row">
														<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
															<b>{{ item.userName }}</b>
														</div>
														<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
															<span>{{ item.postName }}</span>
														</div>
													</div>
												</div>
											</div>
											<img class :src="'endUserFiles/postFiles/'+item.miniImageUrl" alt>
										</WaterfallItem>
									</Waterfall>
									<IPaginator id="pag"/>
								</div>

								<div v-else class="row row-card-white pb-5">
									<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3">
										<img class src="/img/AppTemplate/Modules/Posts/notfound.png" alt>
									</div>
									<div
										class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
									>No se encontraron imagenes similares</div>
								</div>
							</div>
						</div>

						<div class="col-xs-3 col-md-3 col-lg-3 col-sm-3 text-center">
							<div class="text-center autorInfo">
								<div class="row">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center" style="height:75px">
										<img class="autorPhoto" :src="'endUserFiles/usersAvatar/'+post.userAvatarFileName" alt>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<small class="autorFontColor">Publicado por</small>
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

								<div class="row mx-0">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left px-2">
										<i class="fas fa-filter autorFontColor" style="font-size:12px;"></i>
										<b class="autorFontColor">Filtros</b>
										<hr>
									</div>
									<div
										v-show="( page - 1 ) * limit <= index && page * limit > index"
										v-for=" (post,index) in post.postFilters"
										:key="'filter'+index"
										class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left px-2"
									>
										<div class="row px-2 mt-2">
											<div class="col-xs-6 col-md-6 col-lg-6 col-sm-6 text-left">
												<span class="autorFontColor">{{post.readOnlyValues.key }}</span>
											</div>
											<div class="col-xs-6 col-md-6 col-lg-6 col-sm-6 text-center">
												<span class="autorFontColor">{{post.readOnlyValues.value }}</span>
											</div>
										</div>
										<hr>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";

import ToppartForm from './CheckOutFormSections/TopPart';
import { Waterfall, WaterfallItem } from 'vue2-waterfall';
import IPaginator from "../../Internal/_IPaginator";
import PostDetails from "../../Modules/Modals/Posts/EndUser/PostDetail.vue"
export default {
	name: "posts-form-read-only",
	data() {
		return {
			url: '',
			actionData: {
				message: {
					title: "",
					bodyh1: "",
					bodysmall: ""
				},
				modalId: "postSuccessfullyUpdated",
				view: {
					id: 'createPost',
					functions: {
						savePost: () => {
							this.save();
						},
						closeModal: () => {
							this.$router.push("/");
							this.$store.dispatch('posts/getAllPosts');
						},
						cancel: () => {
							this.$router.push('/');
							this.$store.dispatch('posts/getAllPosts');
						}
					}
				}
			},

			filterResult: {},

			asyncRequestStatus: '',

			postTags: [],
			postFilters: [],

			filter: {
				visible: false,
				appliesForCustomModalPlugin: true,
				advancedFilter: false
			},
			toggleData: {
				jqueryElementId: "floatingImageStatistics",
				ref: "postsform",
				modalEffect: true
			},
			lastId: 0,
			post: {}
		};
	},

	provide() {
		return { parentValidator: this.$validator }
	},
	components: {
		BodyHeaderPart1,
		ToppartForm,
		Waterfall,
		WaterfallItem,
		IPaginator,
		PostDetails
	},
	created() {
		this.initialize();
	},
	methods: {

		loadPost(item) {
			this.$router.push({ path: 'checkOutPost', query: { postId: item.postId } });
		},

		...mapActions({
			//getPosts: 'posts/getAllPosts',
			getData: () => { }
		}),

		initialize() {
			window.scrollTo(0, 0);
			this.loadPostData();
		},

		loadPostData() {
			this.$store.commit('posts/setFormAsyncRequestStatus', 1);
			this.$IGeneral.asyncRequest(this.url + "posts/__loadPost", this.$router.history.current.query, [response => {
				this.asyncRequestStatus = 'OK';
				this.$store.commit('posts/setFormAsyncRequestStatus', 0);
				if (response) {
					if (response.type == 1) {
						this.post = response.post;
						this.$store.commit('posts/setPosts', response.similarPosts);
						this.$store.commit('paginator/setLimit', 27);
						this.$store.dispatch('paginator/setRowsData', response.similarPosts);
						setTimeout(() => {
							$('#pag').removeClass('pt-5');
							$('#pag').removeClass('py-3');
							$('#pag').addClass('py-1');
						}, 100);
					}
				}
			}]);
		},
	},

	computed: {
		...mapGetters({
			imageStatistics: 'posts/getImageStatistics',
			mode: 'posts/getMode',
			form: 'posts/getFormData',
			categories: 'posts/getCategories',
			types: 'posts/getTypes',
			users: 'posts/getUsers',
			tags: 'posts/getTags',

			limit: 'paginator/getLimitOfRows',
			page: 'paginator/getPage',
			posts: 'posts/getPosts',

		}),


	},

	watch: {
		$route(to, from) {
			this.initialize();
		}
	}
};
</script>

<style lang="scss" >
.autorInfo {
	top: -51px;
}

.autorPhoto {
	top: -35px;
}

.upperRow {
	position: relative;
	top: -95px;
}

.row-card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: #f1f1f1;
}
.row-card-white {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: #fff;
}
.list-card-filter {
	z-index: 3;
	background: #f1f1f1;
	// border: 1px solid black;
	// box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.floatingImageStatistics {
	background-color: #363c43;
	color: #fff;
	border-radius: 10px;
	position: absolute;
	top: 40px;
}
.floatingImageStatistics > table {
	color: #fff;
	text-align: center;
}

.borderedDivForStatistics {
	border: 1px solid #fff;
	border-radius: 5px;
}

.whiteColor {
	color: #fff;
}

.checkoutStatisticsPointer {
	cursor: pointer;
}

.miniImage {
	max-width: 100% !important;
	// width: 240px;
	height: 200px;
}

.minidescription {
	width: 240px;
	// height: 50px;
	background: #707070;
	color: #fff;
}
.minidescription-details {
	width: 240px;
}

.minidescripcion-details-part1 {
	background-color: #8a8a8a;
	color: #fff;
}

.minidescripcion-details-part2 {
	background-color: #525252;
	color: #fff;
}

.fileNameDescripction {
	width: 240px;
	height: 200px;
	background: #f4f4f4;
	border: 1px solid #d8d6d6;
	text-align: center;
}

.fs-13 {
	font-size: 13px;
}

.fs-10 {
	font-size: 10px;
}

.fs-12 {
	font-size: 12px;
}
.minidescription-details-filesize {
	font-size: 13px;
	display: block;
	/* position: relative;
    top: 19px; */
}

.div-table {
	display: table;
	width: auto;
	border-spacing: 5px; /* cellspacing:poor IE support for  this */
	width: 100%;
}
.div-table-row {
	display: table-row;
	width: auto;
	clear: both;
}
.div-table-col {
	float: left; /* fix for  buggy browsers */
	display: table-column;
}

.tagsTitle {
	background: #0065cb;
	color: white;
	border-radius: 5px;
	font-size: 15px;
	font-weight: bold;
}

.subtagTitle {
	background-color: #eeeeee;
	color: #797979;
	border-radius: 10px;
	border: 1px solid #dddddd;
}

.dotted {
	border-style: dotted;
	border-bottom: 1px solid black;
}

hr {
	border: none;
	border-top: 1px dotted #c2c2c2;
	color: #fff;
	background-color: #fff;
	height: 1px;
	width: 100%;
	margin-bottom: 1px;
}

.divfileupload {
	border: 1px solid #929292;
	border-style: dashed;
	border-radius: 8px;
	padding-top: 18px;
	padding-bottom: 18px;
}

.borderRight {
	border-right: 1px solid #c2c2c2;
}

.postState {
	font-size: 15px;
	font-weight: 400;
}

.image-upload > input {
	display: none;
}

.topPartUpperRowEndUser {
	border-top-right-radius: 11px;
	border-top-left-radius: 11px;
}

h1 {
	color: #7b7b7b;
}
.item {
	position: relative;
}
.item:hover > .coverText {
	display: block;
}

.item img {
	border-radius: 5px;
	width: 100%;
	display: block;
	cursor: pointer;
}

/* .item img:hover{
	display: none;
}
 */

.imgx {
	border-radius: 5px;
	width: 100%;
	display: block;
	cursor: pointer;
	height: calc(100vh);
}
.coverText {
	height: 500px;
	position: absolute;
	display: none;
}
.coverText {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: 11111;
	background-color: rgba(0, 0, 0, 0.5);
}

.coverText > .link {
	// color: white;
	position: absolute;
	margin: 0 auto;
	width: 19%;
	// border: 1px solid #fff;
	// border-radius: 5px;
	padding-top: 3px;
	padding-bottom: 3px;
	left: 34%;
	bottom: 45%;
	cursor: pointer;
	display: flex;
}

.link > .link-detail {
	color: white;
	border: 1px solid #fff;
	border-radius: 5px;
}

.coverText > .postData {
	color: white;
	position: absolute;
	bottom: 0px;
	left: 5%;
	text-align: left;
}

.upperRowEndUser {
	position: relative;
	// top: -235px;
	top: -12ex;
}

@-webkit-keyframes fadeIn {
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@keyframes fadeIn {
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
.animated {
	-webkit-animation-duration: 1s;
	animation-duration: 1s;
	-webkit-animation-fill-mode: both;
	animation-fill-mode: both;
}
.fadeIn {
	-webkit-animation-name: fadeIn;
	animation-name: fadeIn;
}


.w-240{
	width: 240px;
}
</style>