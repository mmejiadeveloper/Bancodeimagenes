<template>
	<div class="row text-center centeredFrom1100 upperRow">
		<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
			<BodyHeaderPart1 :mode="$parent.mode" :actionData="$parent.actionData"/>
			<PostsAdminFiltersFotografo/>
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
								:fixed-height="true"
								:auto-resize="true"

							>
								<div :class="'coverText ' + [ posts.length <= 1 ? 'w-200' : '' ] ">
									<div class="link" @click="loadPost(item)">
										<i class="fas fa-link centerIconInside"></i>
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
								<img :class=" [ posts.length <= 1 ? ' w-200' : '' ]" :src="'endUserFiles/postFiles/'+item.miniImageUrl" alt>
							</WaterfallItem>
						</Waterfall>
					</div>
				</div>
				<IPaginator/>
			</div>

			<div v-else class="row row-card-white pb-5">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3">
					<img class src="/img/AppTemplate/Modules/Posts/notfound.png" alt>
				</div>
				<div
					class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
				>
					<h3>No has subido ningún recurso</h3>
					<span>Agrega tu primer recurso y comparte tu creatividad. Agregar un v&iacute;nculo que abra el modal o lleve a la secci&oacute;n de de agregar nuevo recurso. </span>
				</div>
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
export default {
	name: 'admin-fotografo',
	components: {
		BodyHeaderPart1,
		PostsAdminFiltersFotografo,
		PostFotografo,
		IPaginator,
		Waterfall,
		WaterfallItem
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
			this.$router.push({ path: 'updatePost', query: { postId: item.postId } })
		}
	},

	mounted() {
		this.$store.dispatch('filter/initializeFilter', this);
		this.getPosts(() => {
			this.$store.commit('paginator/setLimit', 27);
			this.$store.dispatch('paginator/setRowsData', this.posts);
		});
	},
}
</script>

<style lang="scss" scoped>

.centerIconInside{
    margin-left: auto;
    margin-right: auto;
    margin-top: 5px;
    margin-bottom: 5px;
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
	color: white;
	position: absolute;
	margin: 0 auto;
	width: 19%;
	border: 1px solid #fff;
	border-radius: 5px;
	padding-top: 3px;
	padding-bottom: 3px;
	left: 41%;
	bottom: 45%;
	cursor: pointer;
}
.coverText > .postData {
	color: white;
	position: absolute;
	bottom: 0px;
	left: 5%;
	text-align: left;
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

.w-200{
	width: 210px !important;
}

</style>