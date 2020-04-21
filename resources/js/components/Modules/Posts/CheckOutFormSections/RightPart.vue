<template>
	<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 py-3 pl-0">
		<div class="row">
			<div
				v-if="$parent.mode == 'update' "
				class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pl-0"
			>
				<div class="w-240 mx-auto" style="background-color:rgb(222, 222, 222)" >
					<img class="miniImage" :src="form.lowQualityFile.url" alt>
				</div>
			</div>
			<div v-else class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="mx-auto px-3 text-center" v-if="form.lowQualityFile.file">
					<img class="fileNameDescripction" :src="form.lowQualityFile.url">
				</div>

				<div v-else class="fileNameDescripction mx-auto px-3 py-5">
					<div class="divfileupload">
						<span class>Esperando</span>
					</div>
				</div>
			</div> 
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="minidescription mx-auto px-3 py-2">
					<div class="www" > 
						<b>Miniatura automatica</b> 
					</div>
					<div class="qweqweqwe">
						350 x 350
					</div>
				</div>
			</div>
		</div>
		<div v-if="$parent.mode == 'update' " class="row pt-3">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="fileNameDescripction mx-auto px-3 py-5">
					<span style="cursor:pointer" v-tooltip=" form.originalPhotoFile.loadedFileName">Ver archivo</span>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="minidescription-details mx-auto px-3">
					<div class="row image-upload">
						<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-left py-2 minidescripcion-details-part1">
							<div class="minidescription-details-filesize">Archivo original 11.9 MB</div>
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
								style="display:none;"
							>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div v-else class="row pt-3">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left pl-0">
				<div class="fileNameDescripction mx-auto px-3 pt-4">
					<div class="divfileupload">
						<div id="originalImageFile" class="image-upload">
							<label for="file-input2">
								<div>
									<i class="fas fa-upload"></i>
									<br>
									<span class>Subir</span>
								</div>
								<!-- 	<span class>Subir</span>
								<img class src="/img/AppTemplate/Modules/Posts/Form/nofile.png" alt-->
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
							<div class="minidescription-details-filesize">
								<div >
									<b>Archivo original</b>
								</div>
								<div>
									{{ form.originalPhotoFile.size }}
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
</style>