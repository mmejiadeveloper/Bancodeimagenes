<template>
	<div
		v-if="$root.loggedUser.profileId == 1 || $root.loggedUser.profileId == 3"
		id="filterRow"
		:class="'row py-3 px-3  ' + ([ $root.loggedUser.profileId == 3 ? ' row-card-top mt-3 ' : ' row-card row-card-admin-noshadow' ]) "
	>
		<div
			v-if="$root.loggedUser.profileId == 1"
			class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left"
		>
			<span v-if="searchInfomation.searchText.length <= 0" class="user-tag">Listado de recursos</span>
			<span v-else class="user-tag">
				Has buscado :
				<b>{{ searchInfomation.searchText }}</b>
			</span>
			<br>
			<small
				v-if="searchInfomation.searchText.length > 0 && searchInfomation.searchStatus == 'done'"
			>Se encontraron {{posts.length}} resultados</small>
		</div>
		<div
			v-if="$root.loggedUser.profileId == 3"
			class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left"
		>
			<span
				v-if="$parent.actionData.message.title.length > 0"
				class="user-tag-nobold"
			>{{$parent. actionData.message.title}}</span>
			<span class="user-tag">{{ $root.loggedUser.name }}</span>
			<br>
			<small>Se encontraron {{$parent.userFavorites.length}} recursos.</small>
		</div>
		<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right">
			<div class="buttonFilterPosition" id="buttonFilterPosition">
				<small v-if="!$parent.toggleData.filterPostsElement.filter.visible" class="px-2">
					<span>Filtrar recursos</span>
				</small>
				<small id="cmodal_item2" v-else class="px-2">Filtrar resultados</small>
				<button
					id="cmodal_item3"
					@click="initializeCustomModal"
					type="button"
					:class=" [ ( $parent.toggleData.filterPostsElement.filter.visible ? ' btn-primary ' : 'btn btn-dark' ) + ' btn '] "
				>
					<i class="fas fa-filter"></i>
				</button>
			</div>
		</div>
		<div
			v-show="$parent.toggleData.filterPostsElement.filter.visible"
			id="filterComplete"
			class="w-100 filterPosition"
		>
			<div class="arrow-up-filter"></div>
			<div class="row">
				<div
					v-show="$parent.toggleData.filterPostsElement.filter.advancedFilter"
					class="col-sm-5 col-md-5 col-lg-5 col-xl-5 text-center"
					style="margin-left:50px;margin-right:50px;"
				>
					<div id class="filterPart1">
						<div class="row">
							<div
								class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left py-3 blackTitle "
							>Filtros Avanzados</div>

							<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pt-3 pb-2 backg-color-white">
								<div class="row">
									<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 pr-0 text-right lh-28 pr-0">
									<!-- 	<span
											v-tooltip=" 'Tipo de imagen'"
											class="fs-13"
											v-html=" 'Tipo de imagen'.length <= 12 ? 'Tipo de imagen' :  'Tipo de imagen'.substring(0,8) + '...'"
										></span> -->
										<span
											v-tooltip=" 'Tipo de imagen'"
											class="fs-13"
										>Tipo de imagen</span>
									</div>
									<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center">
										<select v-model="advancedRow.imageExtension" class="form-control fs-13">
											<option value>Seleccione un tipo de imagen</option>
											<option value="jpg">JPG</option>
											<option value="png">PNG</option>
										</select>
									</div>
								</div>
							</div>
							<div class="w-100  bkc-white">
								<div
									v-for="(filter, index) in filters"
									:key="'filterId_' + index "
									class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center py-2 backg-color-white"
								>
									<div class="row">
										<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-right lh-28 pr-0">
											<!-- <span
												v-tooltip=" filter.postFilterName"
												class="fs-13"
												v-html=" filter.postFilterName.length <= 12 ? filter.postFilterName :  filter.postFilterName.substring(0,8) + '...'"
											></span> -->
											<span
												v-tooltip=" filter.postFilterName"
												class="fs-13"
												v-html="filter.postFilterName"
											></span>
										</div>
										<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center">
											<select
												:disabled="asyncRequests.status == 1"
												class="form-control form-control-sm fs-13"
												:name="filter.postFilterName"
												v-model="advancedRow.filterForm['x'+filter.postFiltersId]"
												@change="showSubFilters(advancedRow.filterForm['x'+filter.postFiltersId])"
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
											<div v-if="showSubFilter">
												<div
													class="row pt-4 pt-2 fs-13"
													v-for="(subFilter, subindex) in filter.subFilters"
													:key="'parent' +index+ 'child'+subindex"
												>
													<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-left lh-28 pr-0">
														<!-- <span
															v-tooltip=" subFilter.postFilterSubFilterName"
															class="fs-13"
															v-html=" subFilter.postFilterSubFilterName.length <= 12 ? subFilter.postFilterSubFilterName :  subFilter.postFilterSubFilterName.substring(0,8) + '...'"
														></span> -->
														<span
															v-tooltip=" subFilter.postFilterSubFilterName"
															class="fs-13"
															v-html="subFilter.postFilterSubFilterName"
														></span>
													</div>
													<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8">
														<select
															class="form-control form-control-sm fs-13"
															:disabled="asyncRequests.status == 1"
															v-model="advancedRow.filterForm['postFiltersId:'+filter.postFiltersId+'_postFilterName:'+filter.postFilterName.replace(/\s/g,'') +'_postFiltersSubFilterId:'+subFilter.postFiltersSubFilterId+'_postFilterSubFilterName:'+subFilter.postFilterSubFilterName.replace(/\s/g,'')]"
															:name="subFilter.postFilterSubFilterName"
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
									</div>
								</div>
							</div>

							<hr>
							<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center py-3 backg-color-white">
								<div class="row">
									<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-right fs-13 lh-28 pr-0">Autor</div>
									<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center">
										<select v-model="advancedRow.userId" class="form-control fs-13">
											<option value>Cualquiera</option>
											<option
												:value="user.userId"
												v-for="(user, index) in users"
												:key="'user_'+index"
											>{{ user.name }}</option>
										</select>
									</div>
								</div>
							</div>
							<hr>
							<div
								class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center py-3  backg-color-white"
							>
								<button @click="filter" type="button" class="btn btn-primary px-4">Aplicar filtros</button>
							</div>
						</div>
					</div>
				</div>
				<div
					v-show="!$parent.toggleData.filterPostsElement.filter.advancedFilter"
					class="col-sm-5 col-md-5 col-lg-5 col-xl-5 text-center"
					style="margin-left:50px;margin-right:50px;"
				></div>
				<div
					class="col-sm-5 col-md-5 col-lg-5 col-xl-5 text-center"
					v-show="$parent.toggleData.filterPostsElement.filter.visible"
				>
					<div id class="filterPart1">
						<div class="row">
							<div
								class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left py-3 grayTitle "
							>Filtros por categorias principales</div>
							<div
								class="col-sm-6 col-md-6 col-lg-6 col-xl-6 col-xl-12 text-center py-3 backg-color-white"
							>
								<div class="row">
									<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-right lh-28 pr-0">
										<span class="fs-13">Seleccione una</span>
									</div>
									<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center">
										<select
											:disabled="asyncRequests.status == 1"
											v-model="row.categories.postCategoryId"
											class="form-control fs-13"
										>
											<option value="0">Todas las im&aacute;genes</option>
											<option
												v-for="(category, index) in categories"
												:key="'category' +  index"
												:value="category.categoryId"
											>{{ category.categoryName }}</option>
										</select>
									</div>
								</div>
							</div>
							<hr>
							<div
								class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left py-3 grayTitle "
							>Filtrar por etiquetas</div>
							<div class="w-100 py-4 bkc-white">
								<div
									v-for="(tag, index) in tags"
									:key="'group' +  index"
									class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center py-2 backg-color-white"
								>
									<div class="row">
										<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-right lh-28 pr-0">
											<!-- <span
												v-tooltip=" tag.tagGroupName"
												class="fs-13"
												v-html=" tag.tagGroupName.length <= 12 ? tag.tagGroupName :  tag.tagGroupName.substring(0,8) + '...'"
											></span> -->
											<span
												v-tooltip=" tag.tagGroupName"
												class="fs-13"
												v-html=" tag.tagGroupName"
											></span>
										</div>
										<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center">
											<select
												:disabled="asyncRequests.status == 1"
												v-model="row.tags['groupId:'+tag.tagGroupId]"
												class="form-control fs-13"
											>
												<option value="0">Todas las opciones</option>
												<option
													v-for="(ltag, index) in tag.tags"
													:key="'municipio' +  index"
													:value="ltag.tagId"
												>{{ ltag.tagName }}</option>
											</select>
										</div>
									</div>
								</div>
							</div>

							<hr>

							<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left py-3 grayTitle ">
								<div class="row">
									<div class="col-sm-9 col-md-9 col-lg-9 col-xl-9 text-left lh-28">Activar filtros avanzados</div>
									<div class="col-sm-3 col-md-3 col-lg-3 col-xl-3 text-right">
										<section title=".slideThree ">
											<div
												:class="( [$parent.toggleData.filterPostsElement.filter.advancedFilter ? ' slideThree-active ' : ' slideThree-inactive '] )+ ' slideThree  my-0' "
											>
												<input
													v-model="$parent.toggleData.filterPostsElement.filter.advancedFilter"
													type="checkbox"
													value="None"
													id="slideThree1"
													name="check"
													checked
													@change="advancedSearch = !advancedSearch"
												>
												<label for="slideThree1"></label>
											</div>
										</section>
									</div>
								</div>
							</div>
							<hr>
							<div
								class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center py-3  backg-color-white"
							>
								<button
									:disabled="asyncRequests.status == 1"
									@click="filter"
									type="button"
									class="btn btn-primary px-4"
								>Aplicar filtros</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters, mapState } from 'vuex';
export default {
	name: 'posts-admin-filters',
	data() {
		return {
			row: {
				categories: {
					postCategoryId: 0,
				},
				tags: {
				}
			},
			advancedRow: {
				imageExtension: '',
				filterForm: {},
				userId: ''
			},
			asyncRequests: {
				status: 0
			},
			advancedSearch: false,
			showSubFilter: false,
		}
	},
	methods: {
		showSubFilters(x) {
			if (x == 3) {
				this.showSubFilter = true;
			} else {
				this.showSubFilter = false;
			}
		},
		loadSettings() {
			this.$IGeneral.asyncRequest("posts/__loadSettings", null, [response => {
				this.asyncRequestStatus = 'OK';
				if (response) {
					if (response.type == 1) {
						this.$store.dispatch('posts/setAllPostSettings', response.data);
						response.data.tags.forEach(element => {
							this.row.tags['groupId:' + element.tagGroupId] = '0';
						});
						response.data.filters.forEach(element => {
							this.advancedRow.filterForm['x' + element.postFiltersId] = '';
						});
					}
				}
			}]);
		},
		filter() {
			this.asyncRequests.status = 1;
			let route = this.$root.loggedUser.profileId == 1 ? "posts/__filter" : "userProjects/__filterFavorites";
			for (const key in this.row.tags) {
				if (this.row.tags.hasOwnProperty(key)) {
					const element = this.row.tags[key];
					if (element == '0') {
						delete this.row.tags[key];
					}

				}
			}
			this.$IGeneral.asyncRequest(route, !this.advancedSearch ? this.row : this.advancedRow, [response => {
				this.asyncRequestStatus = 'OK';
				if (response) {
					this.asyncRequests.status = 0;
					console.log(response);
					if (response.type == 1) {
						window.scrollTo(0, 0);
						if (this.$root.loggedUser.profileId == 1) {
							this.$store.commit('posts/setPosts', response.data);
						}
						if (this.$root.loggedUser.profileId == 3) {
							this.$parent.userFavorites = response.data;
						}
						this.$CustomModal.actions.closeCustomModal()
					}
				}
			}]);
		},
		initializeCustomModal() {
			console.log('tdata', this.$parent.toggleData)
			this.$parent.toggleData.idGroup = 'filterPostsElement';
			this.$store.dispatch('filter/initializeFilterForCustomModal', this.$parent);
			this.$store.dispatch('filter/toggleVariableAndSetModalEffect', this.loadSettings)

		},
	},
	computed: {
		...mapGetters({
			categories: 'posts/getCategories',
			types: 'posts/getTypes',
			users: 'posts/getUsers',
			tags: 'posts/getTags',
			filters: 'posts/getFilters',
			searchInfomation: "header/getSearchInformationObject",
			posts: 'posts/getPosts',
		}),

	},

	mounted() {
		$(document).ready(function () {
			$("#filterComplete").draggable();
		});
	},
}
</script>

<style lang="scss" scoped>
.row-card-admin {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: #f1f1f1;
	border-radius: 0%;
}
.row-card-admin-noshadow {
	box-shadow: none;
	background: #f1f1f1;
	border-radius: 0%;
}

.filterPosition {
	position: absolute;
	top: 218px;
	left: 28px;
}

.buttonFilterPosition {
	position: absolute;
	left: 354px;
	background: #f1f1f1;
	border-radius: 5px;
}
</style>