<template>
	<div REQUIRED-FOR-TEMPLATE="enduserprojects.enduserprojects">
		<PostDetails/>
		<div class="row text-center centeredFrom1100 upperRow">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
				<PostsAdminFilters/>
			</div>
		</div>

		<div v-if="userFavorites.length > 0">
			<div class="row row-card-white centeredFrom1100 upperRow">
				<div v-if="userFavorites.length > 0" class="col-sm-12 col-md-12 col-lg-12 col-xl-12 p-3">
					<Waterfall :maxCol="4">
						<WaterfallItem
							v-show="( page - 1 ) * limit <= index && page * limit > index"
							:width="250"
							v-for="(item, index) in userFavorites"
							:key="index"
							class="grid-item item animated fadeIn my-2"
						>
							<div class="coverText">
								<div class="link">
									<div @click="$store.dispatch('posts/openModalDetail',item)" class="link-detail p-2 mr-3">
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
				</div>
			</div>
			<IPaginator class="upperRow centeredFrom1100"/>
		</div>

		<div v-else class="row row-card-white pb-5">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3">
				<img class src="/img/AppTemplate/Modules/Posts/notfound.png" alt>
			</div>
			<div
				class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
			>No tiene publicaciones seleccionadas como favoritas.</div>
		</div>
	</div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
import EndUserFavoritesPost from './EndUserFavoritesPost';
import IPaginator from "../../Internal/_IPaginator";
import { Waterfall, WaterfallItem } from 'vue2-waterfall';
import PostDetails from "../../Modules/Modals/Posts/EndUser/PostDetail.vue";
import PostsAdminFilters from '../Posts/AdminSections/Filters';
export default {
	name: 'end-user-favorites',
	data() {
		return {
			mode: "exclusiveView",
			actionData: {
				message: {
					title: "Favoritas de ",
					bodyh1: "",
					bodysmall: ""
				},
				modalId: "",
				view: {
					id: '',
					functions: {
					}
				}
			},
			userFavorites: [],
			asyncRequest: null,
			toggleData: {
				filterPostsElement: {
					jqueryElements: [
						'filterComplete',
						'cmodal_item2',
						'cmodal_item3'
					],
					ref: "DOES-NOT-APPLY-BECAUSE-THIS-COMPONENT-IS-NOT-BINDED-TO-A-REF",
					modalEffect: true,

					filter: {
						visible: false,
						appliesForCustomModalPlugin: true,
						advancedFilter: false
					},
				},
				idGroup: ''
			}
		}
	},
	components: {
		BodyHeaderPart1,
		EndUserFavoritesPost,
		IPaginator,
		Waterfall,
		WaterfallItem,
		PostDetails,
		PostsAdminFilters
	},
	methods: {
		loadFavorites() {
			const loader =  this.$loading.show({
				container: this.fullPage ? null : this.$refs.formContainer,
				canCancel: true,
				onCancel: this.onCancel,
				backgroundColor: '#000',
				opacity: 0.9,
				color: '#fff'
			});
			if (this.asyncRequest == null) {
				this.asyncRequest = this.$IGeneral.asyncRequest('userProjects/__loadUserFavorites', null, [response => {
					this.asyncRequest = null;
					loader.hide();
					if (response) {
						if (response.type == 1) {
							this.userFavorites = response.data;
							this.$store.dispatch('filter/initializeFilter', this);
							this.$store.dispatch('paginator/setPaginatorConfiguration', { limit: 5 });
							this.$store.dispatch('paginator/setRowsData', this.userFavorites);
							setTimeout(() => {
								$('#pag').removeClass('pt-5');
								$('#pag').addClass('mb-3');
							}, 100);

							console.log(response);
						} else {
							this.IGeneral.vue_swal_error(response.message, 'error');
						}
					}
				}]);
			}
		},

		loadPost(item) {
			this.$router.push({ path: 'checkOutPost', query: { postId: item.postId } });
			item.cerrarModal = true;
			this.$store.dispatch('posts/openModalDetail', item, true)
		},

		initializeCustomModal() {
			this.toggleData.idGroup = 'filterPostsElement';
			this.$store.dispatch('filter/initializeFilterForCustomModal', this);
			this.$store.dispatch('filter/toggleVariableAndSetModalEffect')
		},
	},

	computed: {
		...mapGetters({
			limit: 'paginator/getLimitOfRows',
			page: 'paginator/getPage',
			posts: 'posts/getPosts',
		})
	},

	mounted() {
		this.loadFavorites();
	},

	watch: {
		$route(to, from) {
			if (to.name == 'enduserfavorites') {
				this.loadFavorites()
			}
		}
	}


}
</script>

<style lang="scss" >
.row-card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: white;
	border: 1px solid white;
	z-index: 3;
	border-radius: 10px;
}
.row-card-top {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: white;
	border: 1px solid white;
	z-index: 3;
	// border-radius: 10px;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}
.row-card-bottom {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: white;
	border: 1px solid white;
	z-index: 3;
	// border-radius: 10px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
}

.list-card {
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	z-index: 3;
	background: white;
	border: 1px solid white;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.user-tag {
	font-size: 23px;
	font-weight: bold;
	color: #777575;
}
.user-tag-small {
	color: #777575;
}

.user-tag-nobold {
	font-size: 20px;
	color: #777575;
}

.line {
	width: 1px;
	height: 44px;
	background: #777575;
	position: absolute;
	top: 24px;
	left: 90%;
}

.deleteproject {
	position: relative;
	// left: -21px;
}

.deleteproject > a {
	color: red;
}

.tablegrayheader {
	background: #e6e6e6;
	font-size: 11px;
	color: #707070;
}

.essaemplogo3row {
	width: 100px;
	height: 100px;
	border-radius: 0%;
	border: 1px solid transparent;
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
</style>