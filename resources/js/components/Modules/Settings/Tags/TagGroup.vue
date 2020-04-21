<template>
	<div REQUIRED-FOR-TEMPLATE="settings.tags.taggroup">
		<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center taggroup-row">
			<div class="row">
				<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center py-4">
					<div class="row">
						<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
							<label for>Nombre de la categor&iacute;a de la etiqueta</label>
						</div>
						<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6">
							<input
								v-model="tagGroup.tagGroupName"
								@change="editGroupName"
								type="text"
								class="form-control"
								aria-describedby="helpId"
								placeholder
							>
						</div>
					</div>
				</div>
				<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-right py-4">
					<div v-if="actionGroup == 'list'">
						<a href @click.prevent="addTag">(+) Crear nueva categoria</a>
					</div>
					<div v-else>
						<a href @click.prevent="cancelAdd">Cancelar</a>
						<div style="display:inline;">
							<i class="fas fa-times color-red1 ml-2"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center row-card-white">
			<div class="row px-2">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center py-1">
					<div v-if="groupTags.length > 0 " class="form-inline">
						<div
							class="form-check mx-2 my-2"
							v-for="(tag, index) in groupTags "
							:key="'id_' + tag.tagId + '_tag_index_' + index "
						>
							<Tag ref="tags" :tag="tag" :index="index"/>
						</div>
					</div>
					<div
						v-else-if="groupTags.length <= 0 && waitForAsyncRequestResponseMessage == 'OK'"
					>No se encontraron etiquetas para {{ tagGroup.tagGroupName }}</div>
					<div
						v-if="waitForAsyncRequestResponseMessage == 'pending'"
					>Por favor espere mientras se carga la informaci&oacute;n</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-right  py-2">
					<span @click="deleteTag" :class=" ([ actionGroup != 'list' ? ' unable ' : ' cpointer ' ] ) +  ' '">
						Borrar seleccionados
						<div :class="([ actionGroup == 'list' ? ' color-red1 ' : '' ] )" style="display:inline;">
							<i :class="  ' fas fa-trash  ml-2 '"></i>
						</div>
					</span>
				</div>
			</div>
		</div>


	</div>
</template>

<script>
import Tag from "./Tag";
export default {
	name: 'tag-group',
	components: {
		Tag
	},
	props: {
		tagGroup: {
			type: Object,
		},
		sections: {
			type: Object,
		},
		index: {
			type: Number,
		}
	},
	data() {
		return {
			groupTags: [],
			actionGroup: 'list',
			editGroupNameAsyncRequest: null,
			waitForAsyncRequestResponseMessage: ''
		}
	},
	methods: {
		loadGroupTags() {
			this.waitForAsyncRequestResponseMessage = 'pending';
			this.$IGeneral.asyncRequest("tags/__loadGroupTags", this.tagGroup, [response => {
				if (response) {
					if (response.type == 1) {
						this.groupTags = response.tagsGroupTags;
						this.waitForAsyncRequestResponseMessage = 'OK';
						// this.actionGroup = 'list';
					}
				}
			}]);
		},

		addTag() {
			this.actionGroup = 'add';
			this.groupTags.push({
				tagName: 'Nueva Etiqueta',
				tagId: 'localItem',
				tagStatus: 'pendingToBeCreated',
				tagGroupId: this.tagGroup.tagGroupId,
				options: {
					editable: true
				}
			})

		},

		cancelAdd() {
			this.actionGroup = 'list';
			this.groupTags = $.grep(this.groupTags, function (e) {
				return e.tagId != 'localItem';
			});
		},

		editGroupName() {
			if (this.editGroupNameAsyncRequest == null) {
				this.editGroupNameAsyncRequest = this.$IGeneral.asyncRequest("tags/__renameGroup", this.tagGroup, [response => {
					this.editGroupNameAsyncRequest = null;
					if (response) {
						console.log(response);
						if (response.type == 1) {
							this.$snotify.success('Ok. El nombre del grupo ha sido actualizado.',{
								showProgressBar: false,
							});
						}
						else{
							this.$snotify.error('Algo salio mal, no se pudo actualizar el nombre del grupo',{
								showProgressBar: false,
							});
						}
					}
				}]);
			}
		},

		deleteTag() {
			var selectedTags = this.findSelectedTags();
			console.log(selectedTags);
			if (this.actionGroup == 'list') {
				if (selectedTags.length > 0) {
					this.$IGeneral.vue_swal_confirmacion("Esta seguro que desea eliminar estas etiquetas ?", 'Importante', () => {
						this.$IGeneral.asyncRequest("tags/__removeTags", selectedTags, [response => {
							if (response) {
								if (response.type == 1) {
									this.loadGroupTags();
									this.$IGeneral.vue_swal_successv2("Las etiquetas se han eliminado", "Listo!");
								} else {
									this.$IGeneral.vue_swal_error(response.message, "Algo salio mal!");
								}
							}
						}]);
					});
				}
			}
		},
		findSelectedTags() {
			let clickedTags = $.grep(this.groupTags, function (e) {
				return e.options.checked == true;
			});
			return clickedTags;
			console.log(clickedTags);
		}

	},
	mounted() {
		this.loadGroupTags();
	},
}
</script>

<style lang="scss" scoped>
.cpointer {
	cursor: pointer;
}

.unable {
	color: #c2c2c2;
}
.taggroup-row{
	background-color: #F4F4F4;
}


</style>