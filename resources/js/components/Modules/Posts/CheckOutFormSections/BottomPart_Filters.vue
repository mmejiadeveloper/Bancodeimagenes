<template>
	<div style="width:47%" class="div-table-col row-card-white">
		<div class="tagsTitle mx-1 mt-2 mb-2 py-2">Filtros  </div>

		<div
			v-for="(filter, index) in filters"
			:key="'filterId_' + index "
			class="row px-5 pt-4 pt-2 fs-13"
		>
			<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-left">{{ filter.postFilterName }}</div>
			<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9">
				<select
					:disabled="form.asyncRequests.status == 1"
					v-model="form.filterForm['postFiltersId:'+filter.postFiltersId + '_postFilterName:'+filter.postFilterName.replace(/\s/g,'') ]"
					class="form-control form-control-sm"
					:name="filter.postFilterName"
					v-validate="'required'"
				>
					<option value>Seleccione</option>
					<option
						:selected="subindex==0 ? true: false"
						:xxx="subindex"
						v-for="(selectValue, subindex) in filter.selectValues"
						:key="'select_' + index + 'child_' + subindex"
						:value="selectValue.postFiltersValueId"
					>{{ selectValue.postFilterValue }}</option>
				</select>
				<span>{{ errors.first('postForm.'+ filter.postFilterName) }}</span>
				<div v-if="form.filterForm['postFiltersId:'+filter.postFiltersId + '_postFilterName:'+filter.postFilterName.replace(/\s/g,'') ] == 3">
					<div
						class="row pt-4 pt-2 fs-13"
						v-for="(subFilter, subindex) in filter.subFilters"
						:key="'parent' +index+ 'child'+subindex"
					>
						<div
							class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-left"
						>{{subFilter.postFilterSubFilterName}}</div>
						<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9">
							<select
								class="form-control form-control-sm"
								:disabled="form.asyncRequests.status == 1"
								v-model="form.filterForm['postFiltersId:'+filter.postFiltersId+'_postFilterName:'+filter.postFilterName.replace(/\s/g,'') +'_postFiltersSubFilterId:'+subFilter.postFiltersSubFilterId+'_postFilterSubFilterName:'+subFilter.postFilterSubFilterName.replace(/\s/g,'')]"
								:name="subFilter.postFilterSubFilterName"
								v-validate="'required'"
							>
								<option value>Seleccione</option>
								<option
									v-for="(subFilterSelectValue, subindexselectvalue) in subFilter.selectValues"
									:key="'select_selectvalue_' + index + 'child_' + subindexselectvalue"
									:value="subFilterSelectValue.postFiltersValueId"
								>{{ subFilterSelectValue.postFilterValue }}</option>
							</select>
							<span>{{ errors.first('postForm.'+ subFilter.postFilterSubFilterName) }}</span>
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
	name: 'bottompart-filters-form',
	computed: {
		...mapGetters({
			form: 'posts/getFormData',
			filters: 'posts/getFilters',
		}),
	},
	inject: ['parentValidator'],
	created() {
		this.$validator = this.parentValidator
	}
}
</script>

<style lang="scss" scoped>
</style>