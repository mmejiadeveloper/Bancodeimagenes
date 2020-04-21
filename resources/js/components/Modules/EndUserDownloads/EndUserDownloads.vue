<template>
	<div REQUIRED-FOR-TEMPLATE="enduserprojects.enduserprojects">
		<div class="row text-center centeredFrom1100 upperRow">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
				<div
					v-if="$root.loggedUser.profileId == 3 && mode == 'exclusiveView'"
					class="row pt-38px px-5 row-card-top pb-4"
				>
					<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
						<span
							v-if="actionData.message.title.length > 0"
							class="user-tag-nobold"
						>{{actionData.message.title}}</span>
						<span class="user-tag">{{ $root.loggedUser.name }}</span>
						<br>
						<small>Usted tiene {{userDownloads.length}} descargas.</small>
					</div>
					<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right form-inline">
						<div>
							<span class="pr-2">Filtro descargas</span>
							<select v-model="filters.enduserfilters.firstFilter" @change="filter" class="ml-2 form-control w-25">
								<option value>Seleccione</option>
								<option value="posts_user_projects.created_at">Fecha de descarga</option>
								<option value="users_projects.projectName">Nombre de proyecto</option>
							</select>
							<select v-model="filters.enduserfilters.secondFilter" @change="filter" class="form-control w-25">
								<option value>Seleccione</option>
								<option value="asc">Ascendente</option>
								<option value="desc">Descendente</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div v-if="userDownloads.length > 0">
			<div class="row text-center centeredFrom1100 upperRow row-card-bottom p-0">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-0">
					<table class="table table-sm borderless">
						<thead class="tablegrayheader">
							<tr>
								<th style="width:20%;" class="py-3 text-center">IMAGEN</th>
								<th class="py-3 text-center">DESCRIPCI&Oacute;N/REFERENCIA</th>
								<th class="py-3 text-center">TIPO</th>
								<th class="py-3 text-center">PROYECTO</th>
								<th style="width:20%;" class="py-3 text-center">FECHA</th>
							</tr>
						</thead>
						<tbody>
							<EndUserDownloadsPost
								v-show="( page - 1 ) * limit <= index && page * limit > index"
								v-for="( download, index ) in userDownloads"
								:key="'download'+index"
								:item="download"
								:projectName="download.projectName"
							/>
						</tbody>
					</table>
				</div>
			</div>

			<IPaginator class="centeredFrom1100" id="pag"/>
		</div>
		<div v-else class="row row-card-white pb-5">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3">
				<img class src="/img/AppTemplate/Modules/Posts/notfound.png" alt>
			</div>
			<div
				class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
			>No existen descargas para su usuario.</div>
		</div>
	</div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
import EndUserDownloadsPost from './EndUserDownloadsPost';
import IPaginator from "../../Internal/_IPaginator";
export default {
	name: 'end-user-downloads',
	data() {
		return {
			mode: "exclusiveView",
			actionData: {
				message: {
					title: "Descargas de ",
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
			userDownloads: [],
			asyncRequest: null,

			filters: {
				enduserfilters: {
					firstFilter: "",
					secondFilter: ""
				}
			},

		}
	},
	components: {
		BodyHeaderPart1,
		EndUserDownloadsPost,
		IPaginator
	},
	methods: {
		loadDownloads() {
			const loader =  this.$loading.show({
				container: this.fullPage ? null : this.$refs.formContainer,
				canCancel: true,
				onCancel: this.onCancel,
				backgroundColor: '#000',
				opacity: 0.9,
				color: '#fff'
			});
			if (this.asyncRequest == null) {
				this.asyncRequest = this.$IGeneral.asyncRequest('userProjects/__loadUserDownloads', null, [response => {
					this.asyncRequest = null;
					loader.hide();
					if (response) {
						if (response.type == 1) {
							this.userDownloads = response.data;
							this.$store.dispatch('filter/initializeFilter', this);
							this.$store.dispatch('paginator/setPaginatorConfiguration', { limit: 5 });
							this.$store.dispatch('paginator/setRowsData', this.userDownloads);
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

		filter() {
			if (this.filters.enduserfilters.firstFilter.length > 0 && this.filters.enduserfilters.secondFilter.length > 0 || (this.filters.enduserfilters.firstFilter == "" && this.filters.enduserfilters.secondFilter == "")) {
				this.asyncRequestStatus = "pending";
				this.$IGeneral.asyncRequest("userProjects/__filterDownloads", this.filters, [response => {
					this.asyncRequestStatus = 'OK';
					if (response) {
						this.userDownloads = response.data;
					}
				}]);
			}
		},
		resetFilter() {
			this.filters.enduserfilters.firstFilter = "";
			this.filters.enduserfilters.secondFilter = "";
			this.filter();
		}
	},

	computed: {
		...mapGetters({
			limit: 'paginator/getLimitOfRows',
			page: 'paginator/getPage',
			posts: 'posts/getPosts',
		})
	},

	mounted() {
		this.loadDownloads();
	},

	watch: {
		$route(to, from) {
			if (to.name == 'enduserdownloads') {
				this.loadDownloads()
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
</style>