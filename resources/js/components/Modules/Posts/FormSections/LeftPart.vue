<template>
	<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9 py-3 pr-0">
		<div class="">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12  lowQualityFileReposition">
				<label for="file-input_formpost" style="background-color:#dedede; width:100%;" class="file-input_formpost-class">
					<!-- <div v-if="form.lowQualityFile.url.length <= 0" class="cameradiv" style="cursor:pointer;">
						<div class="cameraicon" >
							<i style="fs-40" class="fas fa-camera"></i>
						</div>
						<div class="cameratext" style="text-decoration:underline;" >SUBIR IMAGEN</div>
					</div> -->
				</label>
				<div id="lowqualityImage " class="image-upload">
					<label for="file-input_formpost" style="background-color:#dedede; width:100%;" class="file-input_formpost-class">
						<div class="hover-change" v-if="form.lowQualityFile.url.length > 0"  >
							<div class="fs-27 changeImageText" >
								Cambiar imagen
							</div>
							<div class="changeImageTextIcon" >
								<i class="fas fa-exchange-alt fs-27"></i>
							</div>
						</div>
						<div v-if="form.lowQualityFile.url.length > 0"
							class="successfullyLoaded" >
							<div>
								<span class="successfullyLoadedCheck successfullyLoadedCheckText" >
									<i class="far fa-check-circle successfullyLoadedCheck_i"></i>
									La imagen ha sido cargada correctamente 
								</span>
							</div>
							
						</div>
						<img
							v-if="form.lowQualityFile.url.length <= 0"
							class='resizePreview'
							height="525"
							src="/img/AppTemplate/Modules/Posts/Form/nofile.png"
							alt
						>
						<img v-else class="resizePreview" :src="form.lowQualityFile.url">
					</label>
					<div class="d-inline image-upload">
						<input
							ref="file_lowquality"
							id="file-input_formpost"
							type="file"
							@change="$parent.getLowQualityFile"
							:disabled="form.asyncRequests.status == 1"
							name="archivo de baja calidad"
						>
						<br>
						<span>{{ errors.first('postForm.archivo de baja calidad') }}</span>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-2">
				<div class="row px-4">
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-left form-text-label"> <b>Nombre de fotografia: </b></div>
					<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9 text-left">
						<input
							v-model="form.postName"
							type="text"
							class="form-control form-control-sm custominput"
							placeholder="Escribe un titulo muy descriptivo de la imagen "
							:disabled="form.asyncRequests.status == 1"
							v-validate="'required|min:5'"
							name="nombre"
							@keyup="$store.dispatch('localData/saveRowFormData', form)"
						>
						<span>{{ errors.first('postForm.nombre') }}</span>
					</div>
				</div>
			</div>
			<div
				v-if="$root.loggedUser.profileId == 1"
				class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-2"
			>
				<div class="row px-4">
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-left form-text-label"> <b>Creador: </b> </div>
					<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9 text-left">
						<select
							v-model="form.userId"
							class="form-control form-control-sm"
							:disabled="form.asyncRequests.status == 1"
							v-validate="'required'"
							name="creador"
							@change="$store.dispatch('localData/saveRowFormData', form)"
						>
							<option value>Seleccione</option>
							<option
								v-for="(user, index) in users"
								:key="'user_'+index"
								:value="user.userId"
							>{{ user.name }}</option>
						</select>
						<span>{{ errors.first('postForm.creador') }}</span>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-2">
				<div class="row px-4">
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-left form-text-label"><b>Categoria: </b></div>
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3">
						<select
							v-model="form.postCategoryId"
							class="form-control form-control-sm"
							:disabled="form.asyncRequests.status == 1"
							v-validate="'required'"
							name="categoria"
							@change="$store.dispatch('localData/saveRowFormData', form)"
						>
							<option value>Seleccione</option>
							<option
								v-for="(category, index) in categories"
								:key="'category_'+index"
								:value="category.categoryId"
							>{{ category.categoryName }}</option>
						</select>
						<span>{{ errors.first('postForm.categoria') }}</span>
					</div>
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-right form-text-label"><b>Tipo: </b></div>
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3">
						<select
							v-model="form.postTypeId"
							class="form-control form-control-sm "
							:disabled="form.asyncRequests.status == 1"
							v-validate="'required'"
							name="tipo"
							@change="$store.dispatch('localData/saveRowFormData', form)"
						>
							<option class="red" value=""> Seleccione</option>
							<option
								v-for="(type, index) in types"
								:key="'type_'+index"
								:value="type.postTypeId"
							>{{ type.postTypeName }}</option>
						</select>
						<span>{{ errors.first('postForm.tipo') }}</span>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-2 pb-5">
				<div class="row px-4">
					<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-left form-text-label"><b>Rese&ntilde;a: </b></div>
					<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9 text-left">
						<textarea
							v-model="form.postDescription"
							class="form-control custominput"
							rows="5"
							:disabled="form.asyncRequests.status == 1"
							v-validate="'required'"
							:name="'rese\u00F1a'"
							placeholder="Escribe una reseña que identifique claramente tu imagen y que contenga las palabras claves para encontrarla"
							@keyup="$store.dispatch('localData/saveRowFormData', form)"
						></textarea>
						<span>{{ errors.first('postForm.rese\u00F1a') }}</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex';
export default {
	name: 'leftpart-form',
	computed: {
		...mapGetters({
			form: 'posts/getFormData',
			categories: 'posts/getCategories',
			types: 'posts/getTypes',
			users: 'posts/getUsers',
		})
	},
	methods: {

	},
	inject: ['parentValidator'],
	created() {
		this.$validator = this.parentValidator
		console.log(this.$root.loggedUser)
	}
}
</script>

<style lang="scss" scoped>
.cameradiv{
	position: absolute;
    left: 357px;
    top: 174px;
    color: #6b6b6b;
}
.cameraicon{
	font-size: 65px;
}
.cameratext{
	position: relative;
    top: -15PX;
}
b{
	color: #888787
}
.form-control {
    border-color: #ced4da;
}
.custominput::placeholder{
	font-size: 14px;
	color: #a1a1a1;
}

.red{
	color: red !important;
	background: red !important;
}

.form-text-label{
	font-size: 14px;
	line-height: 30px;
}

.successfullyLoadedCheck{
	position: absolute;
    bottom: 10px;
    right: 15px;
}

.successfullyLoadedCheck_i{
	color: green;
    font-size: 22px;
}

.successfullyLoadedCheckText{
	background: #737373;
    padding: 5px;
    border-radius: 9px;
    color: white;
    border-bottom-width: 5px;
	margin-bottom: 5px;
	margin-right: 5px;
}

.lowQualityFileReposition{
	position: relative;
    top: -24px;
}

.resizePreview{
	max-width: 100%;
	max-height: 525px;
}

.file-input_formpost-class{
	margin-bottom: 0px;
}


.hover-change{
	position: absolute;
    width: 780px;
	height: 520px;
	color: transparent;
}

.hover-change:hover{
    background: hsla(0, 0%, 14%, 0.4);
	cursor: pointer;
	color: white;
}

.changeImageText{
	position: absolute;
    top: 44%;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    // color: white;
}

.changeImageTextIcon{
	position: absolute;
    top: 53%;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    // color: white;
}
</style>