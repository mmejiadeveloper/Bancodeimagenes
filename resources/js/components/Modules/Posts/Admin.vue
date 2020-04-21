<template>
	<div>
		<div v-if="$root.loggedUser.profileId == 1" REQUIRED-FOR-TEMPLATE="posts.admin">
			<div class="row text-center centeredFrom1100 ">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 mt--90px">
					<BodyHeaderPart1 :mode="this.mode" :actionData="actionData"/>
					<PostsAdminFilters/>
					<div v-if="posts.length > 0">
						<div class="row row-card-white">
							<div v-if="posts.length > 0" class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-0">
								<table class="table w-10 borderless">
									<thead class="tablegrayheader">
										<tr>
											<th style="width:10%">IMAGEN</th>
											<th class="w-25">DESCRIPCI&Oacute;N / REFERENCIA</th>
											<th>TIPO</th>
											<th>CREADOR</th>
											<th>ACCIONES</th>
										</tr>
									</thead>
									<tbody>
										<Post
											v-show="( page - 1 ) * limit <= index && page * limit > index"
											v-for="(post, index) in posts"
											:key="'post_'+index"
											:item="post"
										/>
									</tbody>
								</table>
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
							<h3>No se han cargado recursos </h3>
							<span>No hay recursos para mostrar, aprovecha esta oportunidad para subir un nuevo recurso.</span>
						</div>
						<div
							class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
						>
							<button
								@click="actionData.view.functions.createPost"
								v-if="actionData.view.id == 'posts' "
								type="button"
								class="btn btn-success"
							><i class="fas fa-cloud  "></i> Subir nuevo recurso</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<AdminFotografo v-if="$root.loggedUser.profileId == 2"/>
		<AdminEndUser ref="adminenduser" v-if="$root.loggedUser.profileId == 3"/>
	</div>
</template>

<script>
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
import IPaginator from "../../Internal/_IPaginator";
import Post from './Post';
import PostsAdminFilters from './AdminSections/Filters';

import AdminFotografo from './AdminProfiles/AdminFotografo';
import AdminEndUser from './AdminProfiles/AdminEndUser';

export default {
	name: "posts-admin",
	components: {
		BodyHeaderPart1,
		Post,
		IPaginator,
		PostsAdminFilters,
		AdminFotografo,
		AdminEndUser
	},
	data() {
		return {
			filters: {
				searchByText: ""
			},

			foundPosts: [{}],
			mode: "admin",
			actionData: {
				message: {
					title: "",
					bodyh1: "",
					bodysmall: ""
				},
				modalId: "createUserModal",
				view: {
					id: 'posts',
					functions: {
						createPost: () => {
							this.$router.push("createPost");
							this.$store.commit('posts/cleanFormRowData');
						}
					}
				}
			},

			toggleData: {
				filterPostsElement: {
					jqueryElements: [
						'filterComplete',
						'cmodal_item2',
						'cmodal_item3',
						'buttonFilterPosition',
					],
					ref: "DOES-NOT-APPLY-BECAUSE-THIS-COMPONENT-IS-NOT-BINDED-TO-A-REFXX",
					modalEffect: true,

					filter: {
						visible: false,
						appliesForCustomModalPlugin: true,
						advancedFilter: false
					},
				},
				idGroup: ''
			}
		};
	},
	methods: {
		...mapActions({
			getPosts: 'posts/getAllPosts',
		}),
		initialize(){
			if (this.$root.loggedUser.profileId == 1) {
				this.$store.dispatch('filter/initializeFilter', this);
				this.getPosts(() => {
					this.$store.dispatch('paginator/setPaginatorConfiguration', { limit: 25 });
					this.$store.dispatch('paginator/setRowsData', this.posts);
				});
			}
		}
	} ,

	computed: mapGetters({
		limit: 'paginator/getLimitOfRows',
		page: 'paginator/getPage',
		posts: 'posts/getPosts',
	}),

	mounted() {
		this.initialize();
	},
	watch: {
		$route(to, from) {
			if(to.name == 'postsadmin') {
				this.initialize();
			}
		}
	}
};
</script>

<style lang="css" >
.row-card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: #f1f1f1;
}
.row-card-white {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: #fff;
}

.list-card {
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	z-index: 3;
	background: white;
	border: 1px solid white;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
.list-card-filter {
	z-index: 3;
	background: #f1f1f1;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
.list-card-titles {
	z-index: 3;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.list-card-titles table > thead {
	background: #cccccc;
	color: #a0a0a0;
	font-size: 11px;
}

.list-card-titles table > tbody {
	background: #fff;
	color: #000;
	font-size: 15px;
}
.list-card-titles table > tbody > tr:hover {
	background: rgb(255, 255, 218);
}

.list-card-paginator {
	z-index: 3;
	background: #fff;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	padding-top: 80px;
	padding-bottom: 80px;
	line-height: 30px;
	font-size: 13px;
	font-weight: 300 ;
}

.boxShadow {
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

.btn-dark {
	background-color: #474747;
	color: #fff;
}

.filterdiv {
	background-color: #c2c2c2;
}

.deteleRow {
	height: 26px;
	width: 26px;
	background-color: #979797;
	font-size: 12px;
	border-radius: 50%;
	padding-top: 3px;
	cursor: pointer;
}

.deteleRow:hover {
	background: #cccbcb;
}

.paginator-tag-text {
	color: #777575;
}

.upperRow {
	position: relative;
	top: -95px;
}

.tablegrayheader {
	background: #c5c5c5;
	font-size: 11px;
	color: #707070;
}

table > tbody > tr {
	cursor: pointer;
}
table > tbody > tr:hover {
	cursor: pointer;
	background-color: rgb(255, 255, 218);
}

.blackTitle {
	background-color: #242424;
	color: #fff;
}

.filterPart1 {
	position: absolute;
	top: 167%;
	left: 0%;
	z-index: 10;
	border-radius: 10px;
}

hr {
	border: none;
	border-top: 1px dotted #c2c2c2;
	color: #fff;
	background-color: #fff;
	height: 1px;
	width: 100%;
	margin-top: 0px;
	margin-bottom: 0px;
	margin-right: 0px;
	margin-left: 0px;
}

.grayTitle {
	background-color: #c2c2c2;
}

.mt--90px{
	margin-top: -90px;
}
</style>
