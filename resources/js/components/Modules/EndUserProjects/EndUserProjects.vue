<template>
	<div REQUIRED-FOR-TEMPLATE="enduserprojects.enduserprojects">
		<div class="row text-center centeredFrom1100 upperRow">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
				<div
					v-if="$root.loggedUser.profileId == 3 && mode == 'exclusiveView'"
					class="row pt-38px px-5 row-card pb-4"
				>
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left">
						<span
							v-if="actionData.message.title.length > 0"
							class="user-tag-nobold"
						>{{actionData.message.title}}</span>
						<span class="user-tag">{{ $root.loggedUser.name }}</span>
						<br>
						<small>Usted tiene {{userProjects.length}} proyectos.</small>
					</div>
				</div>
			</div>
		</div>
		<div v-if="userProjects.length > 0">
			<div v-for="(project, index) in userProjects" :key="'project'+index" class="mt-4" v-show="( page - 1 ) * limit <= index && page * limit > index">
				<div class="row text-center centeredFrom1100 upperRow row-card-top px-5 pr-0 py-3">
					<div class="col-sm-5 col-md-5 col-lg-5 col-xl-5 py-3 text-left pr-0">
						<div class="form-inline">
							<img src="img/AppTemplate/Modules/EndUserProjects/folder.png" class="mr-3" alt>
							<span class="user-tag-nobold">Proyecto&nbsp;</span>
							<span class="user-tag">{{ project.projectName }}</span>
							<div class="ml-4 line"></div>
						</div>
					</div>

					<div class="col-sm-7 col-md-7 col-lg-7 col-xl-7 py-3 pl-0">
						<div class="form-inline">
							<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left pl-0 deleteproject">
								<a href="#" @click.prevent="deleteUserProject(project)">
									<small>
										<i class="fas fa-trash mr-1"></i> Eliminar proyecto
									</small>
								</a>
							</div>
							<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right">
								<select v-model="project['options']['visible']" class="form-control">
									<option :value="true">Mostrar</option>
									<option :value="false">Ocultar</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div
					v-show="project['options']['visible']"
					class="centeredFrom1100 row upperRow row-card-bottom"
				>
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
								<EndUserProjectPost

									v-for="( post, sindex ) in project.posts"
									:key="'project'+index+'Posts'+sindex"
									:item="post"
									:projectName="project.projectName"
								/>
							</tbody>
						</table>
					</div>
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
			>No existen proyectos para su usuario.</div>
		</div>
	</div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
import EndUserProjectPost from './EndUserProjectPost';
import IPaginator from "../../Internal/_IPaginator";
export default {
	name: 'end-user-projects',
	data() {
		return {
			mode: "exclusiveView",
			actionData: {
				message: {
					title: "Proyectos de ",
					bodyh1: "",
					bodysmall: ""
				},
				modalId: "createUserModal",
				view: {
					id: 'users',
					functions: {
						createUser: () => {
							this.loadRowDataInModal();
							this.$store.dispatch('createUserModal/setFormMode', 'newUser');
						}
					}
				}
			},
			userProjects: [],
			asyncRequest: null
		}
	},
	components: {
		BodyHeaderPart1,
		EndUserProjectPost,
		IPaginator
	},
	methods: {
		loadProjects() {
			const loader =  this.$loading.show({
				container: this.fullPage ? null : this.$refs.formContainer,
				canCancel: true,
				onCancel: this.onCancel,
				backgroundColor: '#000',
				opacity: 0.9,
				color: '#fff'
			});
			if (this.asyncRequest == null) {
				this.asyncRequest = this.$IGeneral.asyncRequest('userProjects/__loadUserProjects', null, [response => {
					this.asyncRequest = null;
					loader.hide();
					if (response) {
						if (response.type == 1) {
							this.userProjects = response.data;
							this.$store.dispatch('filter/initializeFilter', this);
							this.$store.dispatch('paginator/setPaginatorConfiguration', { limit: 2 });
							this.$store.dispatch('paginator/setRowsData', this.userProjects);
							setTimeout(() => {
								$('#pag').removeClass('pt-5');
								$('#pag').addClass('mb-3');
							}, 100);
						} else {
							this.$IGeneral.vue_swal_error(response.message, 'error');
						}
					}
				}]);
			}
		},

		deleteUserProject(project) {
			this.$IGeneral.vue_swal_confirmacion('Esta seguro que desea eliminar este proyecto?, Nota: todos los recursos anadadios seran eliminados.', 'Advertencia', () => {
				if (this.asyncRequest == null) {
					this.asyncRequest = this.$IGeneral.asyncRequest('userProjects/__removeUserProject', project, [response => {
						this.asyncRequest = null;
						if (response) {
							if (response.type == 1) {
								console.log(response);
								this.loadProjects();
								this.$snotify.success('Ok. El proyecto ha sido eliminado.', {
									showProgressBar: false,
								});
							} else {
								this.IGeneral.vue_swal_error(response.message, 'error');
							}
						}
					}]);
				}
			});
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
		this.loadProjects();
	},

	watch: {
		$route(to, from) {
			if(to.name == 'enduserprojects') {
				this.loadProjects()
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