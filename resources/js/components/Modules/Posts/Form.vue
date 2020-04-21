<template>
	<div REQUIRED-FOR-TEMPLATE="posts.form" ref="postsform">
		<LoadingAWSResourceModal/>
		<form class="w-100" :data-vv-scope="'postForm'">
			<div class="row text-center centeredFrom1100 ">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 mt--90px">
					<BodyHeaderPart1 :mode="mode" :actionData="actionData" ref="bodyheaderpart1"/>
					<ToppartForm/>
					<div class="row borderred row-card-white">
						<LeftpartForm ref="leftpart"/>
						<RightpartForm ref="rightpart"/>
					</div>
				</div>
			</div>
			<div class="row text-center centeredFrom1100 ">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 px-0">
					<div class="div-table">
						<div class="div-table-row">
							<BottompartTagsForm/>
							<div style="width:6%" class="div-table-col">
								<span style="visibility:hidden;">non in view</span>
							</div>
							<BottompartFiltersForm/>
						</div>
					</div> 
				</div>
			</div>
			<div class="row text-center centeredFrom1100 ">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
					<button
						:disabled="form.asyncRequests.status==1"
						@click="save"
						type="button"
						class="btn btn-success"
					>
						<i class="fas fa-save"></i>
						Guardar registro
					</button>
				</div>
			</div>
		</form>
	</div>
</template>

<script>
import { mapGetters, mapState } from 'vuex';
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";

import ToppartForm from './FormSections/TopPart';
import LeftpartForm from './FormSections/LeftPart';
import RightpartForm from './FormSections/RightPart';
import BottompartTagsForm from './FormSections/BottomPart_Tags';
import BottompartFiltersForm from './FormSections/BottomPart_Filters';
import LoadingAWSResourceModal from '../Modals/Users/LoadingAWSResourceModal';
export default {
	name: "posts-form",
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
						cancel: ()=> {
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

			lastId: 0
		};
	},

	provide() {
		return { parentValidator: this.$validator }
	},
	components: {
		BodyHeaderPart1,
		ToppartForm,
		LeftpartForm,
		RightpartForm,
		BottompartTagsForm,
		BottompartFiltersForm,
		LoadingAWSResourceModal
	},
	created() {
		this.initialize();
	},
	methods: {
		initialize() {
			this.$validator.reset();
			window.scrollTo(0, 0);
			this.$store.dispatch('filter/initializeFilter', this);
			this.$store.dispatch('localData/loadLocalRowStored', () => {
				console.log(JSON.parse(localStorage.getItem("rowData")));
				if (localStorage.getItem("rowData")) {
					// this.$store.commit('posts/setForm', JSON.parse(localStorage.getItem("rowData")));
				}
			});
			if (Object.keys(this.$router.history.current.query).length > 0) {
				this.$store.commit('posts/setMode', 'update');
				this.loadPostData();
			} else {
				this.$store.commit('posts/setMode', 'create');
				this.loadSettings();
			}
			if (this.mode == "create") {

				this.actionData.message.title = "Recurso creado con \u00e9xito";
				this.actionData.message.bodyh1 = "\u00A1Listo! tu recurso ha sido creado";
				this.actionData.message.bodysmall = "Hemos creado correctamente tu nuevo recurso, a partir de este momento estará disponible teniendo en cuenta los datos que le asignaste.";
			} else {
				this.actionData.message.title = "Recurso actualizado con \u00e9xito";
				this.actionData.message.bodyh1 = "\u00A1Listo! tu recurso ha sido actualizado";
				this.actionData.message.bodysmall = "Hemos actualizado correctamente tu recurso, a partir de este momento estará disponible teniendo en cuenta los datos que le asignaste.";
			}


		},

		getLowQualityFile(e) {
			// alert('w');
			const file = e.target.files[0];
			let loadedFile = this.$refs.leftpart.$refs.file_lowquality.files[0];
			if (this.validateFileExtension(loadedFile) == 1) {
				this.form.lowQualityFile.url = '';
				this.form.lowQualityFile.url = URL.createObjectURL(file);
				this.form.lowQualityFile.file = null;
				this.form.lowQualityFile.file = loadedFile;
				// this.form.loadedFileExistence = true;
			}
		},

		getOriginalPhotoFile(e) {
			const file = e.target.files[0];

			let loadedFile = this.$refs.rightpart.$refs.originalFile.files[0];
			console.log(loadedFile);
			// alert('w');
			if (this.validateFileExtension(loadedFile) == 1 && this.validateFileSize(loadedFile) == 1) {
				this.form.originalPhotoFile.url = URL.createObjectURL(file);
				this.form.originalPhotoFile.file = null;
				this.form.originalPhotoFile.file = loadedFile;
			}
		},

		validateFileExtension(loadedFile) {
			let allowed = 1;
			let fileExtension = loadedFile.name.split('.').pop().toLowerCase();
			let allowedExtensions = ['jpg', 'png', 'tif']
			if (!allowedExtensions.includes(fileExtension)) {
				this.errorMessage = 'La foto no cumple con el formato permitido, los formatos permitidos son: jpg, png, gif';
				this.$snotify.error(this.errorMessage, {
					showProgressBar: false,
					time: 3000
				});
				allowed = 2;
			} else {
				this.errorMessage = '';
			}
			return allowed;
		},

		validateFileSize(loadedFile) {
			let allowed = 1;
			let fileSize = loadedFile.size;
			if (fileSize > 30000000) {
				this.errorMessage = 'El archivo excede la cantidad de peso permitido en el sistema. El maximo es 30MB.';
				this.$snotify.error(this.errorMessage, {
					showProgressBar: false,
					time: 3000
				});
				allowed = 2;
			} else {
				this.errorMessage = '';
			}
			return allowed;
		},

		loadSettings() {
			this.$IGeneral.asyncRequest(this.url + "posts/__loadSettings", null, [response => {
				this.asyncRequestStatus = 'OK';
				if (response) {
					if (response.type == 1) {
						this.$store.dispatch('posts/setAllPostSettings', response.data);
						if (this.mode == "update") {
							this.bindVModelForTagsAndFilters();
						}else{
							this.setLastInserted(response.data.lastIdInserted);
						}
					}
				}
			}]);
		},
		setLastInserted(lastId){
			this.lastId = lastId;
		},
		sendData(dir) {
			this.form.mode = this.mode;
			// this.$IGeneral.vue_swal_loading('', '');
			$('#loadingAWS').modal('show');
			this.$IGeneral.asyncRequest(this.url + dir, this.form ? this.form : null, [response => {
				console.log(response);
				// this.$IGeneral.vue_swal_close();
				$('#loadingAWS').modal('hide');
				if (response) {
					this.$store.commit('posts/setFormAsyncRequestStatus', 0);
					if (response.type == 1) {
						this.$refs.bodyheaderpart1.show()
					}else{
						this.$IGeneral.vue_swal_error(response.message,'Error');
					}
				}
			}], [this.form.lowQualityFile.file, this.form.originalPhotoFile.file]);

		},

		save() {
			this.$validator.validateAll('postForm').then((result) => {
				let selectedTagas = $('#tagsManager').find('input:checkbox').filter(function (index, element) {
					return $(element).prop('checked');
				})
				if (result && selectedTagas.length > 0) {
					if ((this.mode == "create" && this.form.originalPhotoFile.url.length <= 0) || (this.mode == "update" && this.form.originalPhotoFile.url.length <= 0)) {
						this.$snotify.error('Por favor complete la informaci\u00F3n', {
							showProgressBar: false,
						});
					} else {
						this.$store.commit('posts/setFormAsyncRequestStatus', 1);
						this.sendData(this.mode == 'create' ? 'posts/__addPost' : 'posts/__modifyPost');
					}
				} else {
					this.$snotify.error('Por favor complete la informaci\u00F3n', {
						showProgressBar: false,
					});
				}

			});
		},

		loadPostData() {
			const loader =  this.$loading.show({
				container: this.fullPage ? null : this.$refs.formContainer,
				canCancel: true,
				onCancel: this.onCancel,
				backgroundColor: '#000',
				opacity: 0.9,
				color: '#fff'
			});
			this.$store.commit('posts/setFormAsyncRequestStatus', 1);
			this.$IGeneral.asyncRequest(this.url + "posts/__loadPost", this.$router.history.current.query, [response => {
				this.asyncRequestStatus = 'OK';
				loader.hide();
				this.$store.commit('posts/setFormAsyncRequestStatus', 0);
				if (response) {
					if (response.type == 1) {
						// console.log('RESPONSE', response, this.postFilters)
						this.postTags = response.post.postTags;
						this.postFilters = response.post.postFilters;
						this.setLoadedPostData(response.post);
						this.loadSettings();
					}
				}
			}]);
		},

		setLoadedPostData(data) {
			// this.$store.commit('posts/setForm',data);
			this.$store.commit('posts/setFormRowData', data);
		},

		bindVModelForTagsAndFilters() {
			let g = { tags: {}, filters: {} }
			this.postTags.forEach(element => {
				g.tags[element.vmodel.name] = true;
			});
			this.postFilters.forEach(element => {
				g.filters[element.vmodel.name] = element.vmodel.value;
			});
			console.log('asiggment', g);
			this.$store.commit('posts/setFormTagsAndFilters', g);
		}

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

.row-card-admin[data-v-71b2017a] {
    box-shadow: none;
    background: #f1f1f1;
    border-radius: 0%;
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
	font-size: 14px;
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
	font-size: 13px;
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



.dotted {
	border-style: dotted;
	border-bottom: 1px solid black;
}



.divfileupload {
	border: 1px solid #929292;
	border-style: dashed;
	border-radius: 8px;
	padding-top: 18px;
	padding-bottom: 18px;
	position: absolute;
    width: 109px;
    left: 80px;
	top: 50%;
	height: 83px;
	margin-top: -46.5px;
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

/* .snotifyToast__inner{
	background: red;
} */
.w-240{
	width: 240px;
}
</style>