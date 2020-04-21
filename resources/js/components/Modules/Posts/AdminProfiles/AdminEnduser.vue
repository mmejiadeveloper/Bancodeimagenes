<template>
	<div
		:class=" [ ($root.loggedUser.profileId == 3 && $router.currentRoute.name == 'postsadmin' )  ?  'row text-center centeredFrom1100 upperRowEndUser ' : 'row text-center centeredFrom1100 upperRow '] "
	>
		<PostDetails/>
		<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
			<BodyHeaderPart1 :mode="$parent.mode" :actionData="$parent.actionData"/>
			<!-- <PostsAdminFiltersFotografo /> -->
			<div class="row row-card-white topPartUpperRowEndUser">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 p-3">
					<h1>Fotograf&iacute;as destacadas</h1>
				</div>
			</div>
			<div v-if="posts.length > 0">
				<div class="row row-card-white">
					<div v-if="posts.length > 0" class="col-sm-12 col-md-12 col-lg-12 col-xl-12 p-3">
						<Waterfall :maxCol="4">
							<WaterfallItem
								v-show="( page - 1 ) * limit <= index && page * limit > index"
								:width="250"
								v-for="(item, index) in posts"
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
												<b
													v-if=' item.userName.length > 20'
													v-html="item.userName.substring(0,20) + '...'"
													v-tooltip=" item.userName "
													>
												</b>
												<b
													v-else
													v-html="item.userName"
												>
												</b>
											</div>
											<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
												<span
													v-if=' item.postName.length > 20'
													v-html="item.postName.substring(0,20) + '...' "
													v-tooltip=" item.postName "
												></span>
												<span
													v-else
													v-html="item.postName"													
													>
												</span>
											</div>
										</div>
									</div>
								</div>
								<img class :src="'endUserFiles/postFiles/'+item.miniImageUrl" alt>
							</WaterfallItem>
						</Waterfall>
					</div>
				</div>
				<IPaginator />
			</div>

			<div v-else class="row row-card-white pb-5">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3">
					<img class src="/img/AppTemplate/Modules/Posts/notfound.png" alt>
				</div>
				<div
					class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
				>La búsqueda que realizaste no arrojó ningún resultado, aprovecha esta oportunidad para subir un nuevo recurso teniendo en cuenta esta búsqueda.</div>
			</div>
		</div>
	</div>
</template>
<script>
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
import BodyHeaderPart1 from "../../../AppTemplate/Body/BodyHeaderPart1";
import PostsAdminFiltersFotografo from './../AdminSections/FiltersFotografo';
import PostFotografo from './../PostFotografo';
import IPaginator from "../../../Internal/_IPaginator";
import { Waterfall, WaterfallItem } from 'vue2-waterfall';
import PostDetails from "../../../Modules/Modals/Posts/EndUser/PostDetail.vue";
import { log } from 'util';
export default {
	name: 'admin-end-user',
	data() {
		return {
			asyncRequest: null
		}
	},
	components: {
		BodyHeaderPart1,
		PostsAdminFiltersFotografo,
		PostFotografo,
		IPaginator,
		Waterfall,
		WaterfallItem,
		PostDetails
	},
	computed: mapGetters({
		limit: 'paginator/getLimitOfRows',
		page: 'paginator/getPage',
		posts: 'posts/getPosts',

	}),

	methods: {
		...mapActions({
			getPosts: 'posts/getAllPosts',
			getData: () => { }
		}),

		loadPost(item) {
			this.$router.push({ path: 'checkOutPost', query: { postId: item.postId } });
			item.cerrarModal = true;
			this.$store.dispatch('posts/openModalDetail', item, true)
		},
		initialize() {
			this.$store.dispatch('filter/initializeFilter', this);
			this.getPosts(() => {
				this.$store.commit('paginator/setLimit', 27);
				this.$store.dispatch('paginator/setRowsData', this.posts);
			});
		}
	},

	mounted() {
		this.initialize();
	},

	watch: {
		$route(to, from) {
			if (to.name == 'postsadmin') {
				this.initialize();
			}
		}
	}
}
</script>

<style lang="scss" scoped>
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

/* .item:hover {
    background-color: black;
}

.item:hover img {
    opacity: 0.8;
}
 */
</style>