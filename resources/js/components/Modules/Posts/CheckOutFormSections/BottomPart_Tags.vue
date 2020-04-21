<template>
	<div style="width:47%" class="div-table-col row-card-white" id="tagsManager">
		<div class="tagsTitle mx-1 mt-2 mb-2 py-2">Etiquetas</div>

		<div :id="'groupId'+taggroup.tagGroupId" v-for="(taggroup, index) in tags" :key="'gtag_'+index" class="mx-2 mt-4 mb-2 py-1 px-4">
			<div class="row fs-12 subtagTitle">
				<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
					<span class="font-weight-bold">{{ taggroup.tagGroupName }}</span>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right">
					<a href="#" @click.prevent="selectEmAll('groupId'+taggroup.tagGroupId)">Seleccionar todas</a>
				</div>
			</div>

			<div class="mx-1 mt-2 mb-2">
				<div class="row fs-12">
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center mt-2 form-inline px-0">
						<div
							v-for="(tag, index) in taggroup.tags"
							:key="'tag_'+index"
							class="form-check pr-2 pb-2"
							title
							v-tooltip="tag.tagName <= 0 ? 'Este etiqueta no puede ser asginada porque no tiene un nombre asignado, dirijase a la parametrizacion para asginar un nombre a esta etiqueta' : '' "
						>
							<input
								:disabled="tag.tagName <= 0 || form.asyncRequests.status == 1 "
								type="checkbox"
								class="form-check-input"
								:id="'exampleCheck' + tag.tagId"
								v-model="form.tagsForm['groupId:'+taggroup.tagGroupId+'_tagId:'+tag.tagId]"
							>
							<label class="form-check-label" :for="'exampleCheck' + tag.tagId">
								<span v-if="tag.tagName <= 0" style="color:red">Sin nombre</span>
								<span v-else>{{tag.tagName}}</span>
							</label>
						</div>
						<div v-if=" taggroup.tags.length <= 0" class="form-check pr-2 pb-2">
							<span>No hay etiquetas agregadas para este grupo</span>
						</div>
					</div>
				</div>
			</div>
			<hr>
		</div>
	</div>
</template>

<script>
import { mapGetters, mapState } from 'vuex';
export default {
	name: 'bottompart-tags-form',
	computed: {
		...mapGetters({
			tags: 'posts/getTags',
			form: 'posts/getFormData',
		}),
	},
	methods: {
		selectEmAll(tagsGroup) {
			$('#' + tagsGroup).find('input:checkbox').each(function (index, element) {
				$(element).click();
				$(element).prop('checked',true);
			});
		}
	},
	mounted() {

	},


}
</script>

<style lang="scss" scoped>
</style>