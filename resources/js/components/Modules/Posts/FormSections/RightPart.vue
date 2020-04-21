<template>
	<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 py-3 pl-0">
		<div class="row">
			<div
				v-if="$parent.mode == 'update' "
				class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pl-0"
			>
				<div class="w-240 mx-auto" style="background-color:rgb(222, 222, 222)">
					<img class="miniImage" :src="form.lowQualityFile.url" alt>
				</div>
			</div>
			<div v-else class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0 miniImageReposition">
				<div class="mx-auto px-3 text-center" v-if="form.lowQualityFile.file">
					<img class="fileNameDescripction" :src="form.lowQualityFile.url">
				</div>

				<div v-else class="fileNameDescripction mx-auto px-3 py-5">
					<div class="divfileupload py-2">
						<div>
							<i style="color:#c1c1c1; font-size:40px;" class="fas fa-clock"></i>
						</div>
						<div>
							<span style="font-size:13px;" class>Esperando</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="minidescription mx-auto px-3 py-2">
					<div class="" > 
						<b>Miniatura automatica</b> 
					</div>
					<div class="">
						350 x 350
					</div>
				</div>
			</div>
		</div>
		<div v-if="$parent.mode == 'update' " class="row pt-3">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="fileNameDescripction mx-auto px-3 py-5">
					<div style="font-size:40px;">
						<i class="fas fa-image"></i>
					</div>
					<div>
						<span
							style="cursor:pointer;text-decoration:underline; position:relative; top: -10px;"
							v-tooltip=" form.originalPhotoFile.loadedFileName"
						>{{form.originalPhotoFile.loadedFileName}}</span>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="minidescription-details mx-auto px-3">
					<div class="row image-upload">
						<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-left py-2 minidescripcion-details-part1">
							<div
								class="minidescription-details-filesize"
							>
								<div >
									<b>Archivo original</b>
								</div>
								<div>
									{{ form.originalPhotoFile.size }}
								</div>
							</div>
						</div>
						<div
							class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-center fs-13  minidescripcion-details-part2"
						>
							<i class="fas fa-upload"></i>
							<br>
							<label for="file-input2">
								<span class="fs-10">CAMBIAR</span>
							</label>
						</div>
						<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
							<input
								ref="originalFile"
								id="file-input2"
								type="file"
								@change="$parent.getOriginalPhotoFile"
								:disabled="form.asyncRequests.status == 1"
								class="d-none"
							>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div v-else class="row pt-3">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="fileNameDescripction mx-auto px-3 pt-4">
					<div class="divfileupload py-2">
						<div id="originalImageFile" class="image-upload">
							<label  v-if="form.originalPhotoFile.url.length <=0"  for="file-input2">
								<div>
									<i style="color:#c1c1c1; font-size:40px;" class="fas fa-paperclip    "></i>
									<br>
									<span  style="font-size:11px;" class>SUBIR ARCHIVO</span>
								</div>
							</label>
							<label v-tooltip="'Haga click aqui para cambiar el archivo cargado'" v-if="form.originalPhotoFile.url.length > 0"  for="file-input2">
								<div>
									<i style="color:green; font-size:40px;" class="fas fa-check-circle    "></i>
									<br>
									<span  style="font-size:11px;" class>ARCHIVO CARGADO!</span>
								</div>
							</label>

							<input
								ref="originalFile"
								id="file-input2"
								type="file"
								@change="$parent.getOriginalPhotoFile"
								:disabled="form.asyncRequests.status == 1"
							>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="minidescription-details mx-auto px-3">
					<div class="row">
						<div
							class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left py-2 minidescripcion-details-part1"
						>
							<div class="minidescription-details-filesize-nofile">
								<div >
									<b>Archivo original</b>
								</div>
								<div>
									(Peso m&aacute;ximo 30 megas)
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex';
export default {
	name: 'rightpart-form',
	computed: {
		...mapGetters({
			form: 'posts/getFormData',
		})
	},
}
</script>

<style lang="scss" >
.minidescription-details-filesize-nofile{
	font-size: 13px;
	display: block;
	position: relative;
}

.miniImageReposition{
	position: relative;
    top: 1px;
}
</style>