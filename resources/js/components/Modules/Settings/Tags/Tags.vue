<template>
	<div REQUIRED-FOR-TEMPLATE="settings.tags">
		<div class="row row-card-white p-3">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
				<div class="row">
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 text-left table-header">
						<i class="fas fa-newspaper mx-2"></i> Tabla de etiquetas
					</div>
				</div>

				<div class="row py-3 px-5  table-body-border border-bottom-0 tags-backgroundcolor">
					<div
						v-for="(tagGroup,index) in sections.tags.tagsGroups"
						:key="'id_'+tagGroup.tagGroupId+'_groupTag_index_'+index"
						:class="'groupTag-table' + index + '  w-100 py-3'"
					>
						<TagGroup ref="tagGroup" :tagGroup="tagGroup" :index="index" :sections="sections"/>
					</div>
					<div v-if="sections.tags.tagsGroups.length <= 0" class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 ">
						<span>No existen grupos de etiquetas</span>
					</div>
				</div>
				<div class="row tags-row-card-darkgray table-body-border border-top-0 py-4">
					<!-- <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right">
						<button type="button" class="btn btn-primary px-2 w-50">
							<i class="fas fa-plus"></i> Agregar nueva categoria
						</button>
					</div>-->
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center">
						<button @click="save" type="button" class="btn btn-success px-2 w-25">
							<i class="fas fa-save"></i> Guardar
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import TagGroup from "./TagGroup";
export default {
	name: 'settings-tags',
	components: {
		TagGroup,
	},
	data() {
		return {
			sections: {
				tags: {
					tagsGroups: [],
					tagsPendingToBeSaved: [],
					saveTagsAsyncRequest: null,
					group1: {
						form: {
							inputAdd: "Municipios"
						},
					},

					group2: {
						form: {
							inputAdd: "Grupos de interes"
						}
					},

					group3: {
						form: {
							inputAdd: "Materialidad"
						}
					},

					group4: {
						form: {
							inputAdd: "Valores"
						}
					}

				},
			}
		}
	},
	methods: {

		reloadAllTagsListData(){
			let groups = this.$refs.tagGroup;
			for (const key in groups) {
				if (groups.hasOwnProperty(key)) {
					const group = groups[key];
					if(group.actionGroup == 'add' ){
						group.loadGroupTags();
						group.actionGroup = 'list';
					}

				}
			}
		},

		loadTagsGroups() {
			this.$IGeneral.asyncRequest("tags/__loadGroups", null, [response => {
				if (response) {
					if (response.type == 1) {
						this.sections.tags.tagsGroups = response.tagsGroups;
					}
				}
			}]);
		},

		save() {
			this.findTagsInGroups(this.$children);
			this.sendSaveRequest();
		},

		findTagsInGroups(groups) {
			groups.forEach(group => {
				this.findTag(group);
			});
		},

		findTag(group) {
			let object = group.$refs.tags;
			for (const key in object) {
				if (object.hasOwnProperty(key)) {
					const tagVueInstance = object[key];
					if (tagVueInstance.tag.tagId == 'localItem') {
						this.sections.tags.tagsPendingToBeSaved.push(tagVueInstance.tag);
					}
				}
			}

		},

		sendSaveRequest() {
			/* console.log(this.sections.tags.tagsPendingToBeSaved,this.sections.tags.saveTagsAsyncRequest ); */
			if (this.sections.tags.tagsPendingToBeSaved.length > 0) {
				if (this.sections.tags.saveTagsAsyncRequest == null) {
					this.sections.tags.saveTagsAsyncRequest = this.$IGeneral.asyncRequest("tags/__storeTags", this.sections.tags.tagsPendingToBeSaved, [response => {
						this.sections.tags.saveTagsAsyncRequest = null;
						if (response) {
							if (response.type == 1) {
								this.resetTagsPendingToSave();
								this.reloadAllTagsListData();
								console.log(response);
								this.$snotify.success('Ok. La informacion se ha actualizado.',{
									showProgressBar: false,
								});
							}
							else{
								this.$snotify.error('Algo salio mal, no se pudo actualizar la informacion',{
									showProgressBar: false,
								});
							}
						}
					}]);
				}
			}
		},

		resetTagsPendingToSave() {
			this.sections.tags.tagsPendingToBeSaved = [];
		}

	},
	mounted() {
		this.loadTagsGroups();
	},
}
</script>

<style lang="scss" >
.tags-backgroundcolor{
	background: #DBDBED !important;
}

.tags-row-card-darkgray {
    background-color: #d5d5e4;
    box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}
</style>