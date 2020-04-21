<template>
	<div class="modal-content">
		<div class="modal-body py-1" v-if="$parent.downloadMode && Object.keys(post).length > 0">
			<div class="row text-center bluegradient margin-title mx-1 mt-2 py-3">
				<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
					<h4>Agregar esta descarga a un proyecto</h4>

					<button type="button" class="close" @click=" $parent.downloadMode = false" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>

			<div class="row text-center mt-3 d-flex h-100 text-center mx-1">
				<div class="col-xs-5 col-md-5 col-lg-5 col-sm-5 pl-0">
					<img v-if="post.lowQualityFile" class="profimg" :src="post.lowQualityFile.url">
				</div>
				<div
					class="col-xs-7 col-md-7 col-lg-7 col-sm-7 text-left justify-content-center align-self-center px-0"
				>
					<div>
						<b v-html="post.postName"></b>
					</div>
					<div>
						<small>ES{{ post.postId }}</small>
					</div>
				</div>
			</div>
			<div class="row text-center mt-3">
				<div
					class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-left customColor"
				>Nombre de proyecto existente / Crear nuevo proyecto</div>
				<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 mt-2">
					<input
						@keyup="findProjects"
						v-model="filter.inputText"
						type="text"
						class="form-control form-control-sm"
						placeholder="Buscar por proyectos"
					>
					<i class="fas fa-search searchIcon"></i>
				</div>
			</div>
			<div class="row text-left mt-3 px-3 customColor">
				<div
					v-if="filter.inputText.length > 0 && userProjects.length > 0"
					class="col-xs-12 col-md-12 col-lg-12 col-sm-12"
				>
					Proyectos con la palabra
					<b>{{ filter.inputText }}</b>
				</div>
				<div v-if="userProjects.length > 0" class="col-xs-12 col-md-12 col-lg-12 col-sm-12 px-4">
					<div v-for="(project, index) in userProjects" :key="'project'+index">
						<div class="form-inline mt-2">
							<div class="form-check mr-2">
								<input
									v-model="selectedProjects['projectId_'+project.usersProjectId]"
									type="checkbox"
									class="form-check-input"
									:id="'project_'+project.usersProjectId"
								>
								<label class="form-check-label" :for="'project_'+project.usersProjectId"></label>
							</div>
							<span v-html="project.projectName"></span>
						</div>
					</div>
				</div>
				<div v-else-if="filter.inputText.length > 0" class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
					No se encontraron projectos para :
					<b>{{ filter.inputText}}</b>
				</div>
				<div v-else class="col-xs-12 col-md-12 col-lg-12 col-sm-12">No se encontraron projectos.</div>

				<hr v-if="userProjects.length <= 0" class="mt-2">
				<div v-if="userProjects.length <= 0" class="col-xs-12 col-md-12 col-lg-12 col-sm-12 my-3">
					<a @click.prevent="addNewProject" href>
						<i style="color:red" class="fas fa-plus-circle"></i>
						<span v-if="filter.inputText.length > 0">
							Crear proyecto para
							<b>{{ filter.inputText }}</b>
						</span>
						<span v-else>Ingrese un nombre para un proyecto nuevo</span>
					</a>
				</div>
				<hr v-if="userProjects.length <= 0">

				<div class="col-xs-12 text-center col-md-12 col-lg-12 col-sm-12 mb-3 mt-3">
					<button
						@click="saveProject"
						:disabled="asyncRequest != null || !isEmpty"
						type="button"
						class="btn btn-danger"
					>
						<i class="fas fa-download mr-3"></i>
						Agregar y descargar
					</button>
					<a class="d-none"  id="invdown" :href="post.originalPhotoFile.downloadLink" download='w3logo'>Invisible guy</a>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
export default {
	name: 'post-download',
	data() {
		return {
			filter: {
				inputText: ''
			},
			projectData: {

			},
			userProjects: [],
			asyncRequest: null,
			selectedProjects: {}
		}
	},

	methods: {
		findProjects() {
			if (this.asyncRequest == null) {
				this.asyncRequest = this.$IGeneral.asyncRequest("users/__loadUserProjects", this.filter, [response => {
					if (response) {
						this.asyncRequest = null;
						if (response.type == 1) {
							this.userProjects = response.data;
						}
					}
				}]);
			}
		},
		saveProject() {
			if (this.asyncRequest == null) {
				let projectData = {
					postId: this.post.postId,
					projects: this.selectedProjects
				}
				this.asyncRequest = this.$IGeneral.asyncRequest("posts/__andToProjectAndDownload", projectData, [response => {
					if (response) {
						this.asyncRequest = null;
						if (response.type == 1) {
							this.downloadFileAndCloseModal(response);
						}
					}
				}]);
			}
		},

		downloadFileAndCloseModal(response) {
			let link = $('#invdown:first');
			link[0].click();
			this.$parent.downloadMode = false;
			$('#postDetailModal').modal('hide');
			this.$snotify.success('Se ha descargado tu recurso, revisa en tu carpeta de descargas.', {
				showProgressBar: false,
			});
		},

		addNewProject() {

			if (this.asyncRequest == null) {

				let newProject = {
					projectName: this.filter.inputText
				}

				this.asyncRequest = this.$IGeneral.asyncRequest("userProjects/__addProject", newProject, [response => {
					if (response) {
						this.asyncRequest = null;
						if (response.type == 1) {
							this.userProjects = response.projects;
							this.$snotify.success('Se ha creado un nuevo proyecto con el nombre: ' + this.filter.inputText , {
								showProgressBar: false,
                            });
                            this.filter.inputText = '';
						}else{
                            this.$IGeneral.vue_swal_error(response.message,'error');
                        }
					}
				}]);
			}

		}
	},

	mounted() {
		this.findProjects();
	},

	computed: {
		...mapGetters({
			post: 'posts/getloadedPostForDetail'
		}),
		isEmpty() {
			return (Object.values(this.selectedProjects).includes(true));
		}
	}
}
</script>

<style lang="scss" scoped>
.bluegradient {
	color: #fff;
	background-image: linear-gradient(#002965, #0065cb);
	border-radius: 5px;
}

.profimg {
	width: 100%;
	height: 120px;
}
.customColor {
	font-size: 14px;
	color: #6f6f6f;
}

a {
	color: #6f6f6f;
	text-decoration: none;
}

.searchIcon {
	position: absolute;
	top: 8px;
	right: 30px;
	color: #6d6d6d;
}

.close {
	float: right;
	font-size: 1.3rem;
	font-weight: 700;
	line-height: 1;
	color: #fff;
	/* text-shadow: 0 1px 0 #fff; */
	opacity: 1;
	position: absolute;
	top: -13px;
	right: 7px;
}
</style>