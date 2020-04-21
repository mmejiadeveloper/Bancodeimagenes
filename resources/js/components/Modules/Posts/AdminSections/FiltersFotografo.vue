<template>
	<div v-if="$root.loggedUser.profileId == 2">
		<div id class="row py-3 px-3 row-card-admin">
			<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
				<span v-if="searchInfomation.searchText.length <= 0" class="user-tag">Portafolio</span>
				<span v-else class="user-tag">
					Has buscado :
					<b>{{ searchInfomation.searchText }}</b>
				</span><br>
				<small  v-if="searchInfomation.searchText.length > 0 && searchInfomation.searchStatus == 'done'"  >Se encontraron {{posts.length}} resultados</small>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2 text-right">
				<span class="filter-label" >Filtrar portafolio</span>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2 text-right">
				<select @change="filter" v-model="filters.photographerfilters.firstFilter" class="form-control fs-13 ">
					<option value>Seleccione</option>
					<option value="download">Decargadas</option>
					<option value="publishdate">Fecha de publicaci&oacute;n</option>
					<option value="favorites">Favoritas</option>
				</select>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2 text-right">
				<select
					@change="filter"
					v-model="filters.photographerfilters.secondFilter"
					class="form-control fs-13"
				>
					<option value>Seleccione</option>
					<option value="asc">Ascediente</option>
					<option value="desc">Descendiente</option>
				</select>
			</div>
			<div v-if="this.filters.photographerfilters.firstFilter.length > 0 && this.filters.photographerfilters.secondFilter.length > 0" v-tooltip='"Reiniciar filtros"' @click="resetFilter" style="position: absolute;left: 96%;top: 162px; cursor:pointer;">
				<i  style="font-size:20px" class="fas fa-times-circle "></i>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters, mapState } from 'vuex';
export default {
	name: 'posts-admin-filters-fotografo',
	data() {
		return {
			filters: {
				photographerfilters: {
					firstFilter: "",
					secondFilter: ""
				}
			},
			asyncRequestStatus: "OK"
		}
	},
	methods: {
		filter() {
			if (this.filters.photographerfilters.firstFilter.length > 0 && this.filters.photographerfilters.secondFilter.length > 0 || (this.filters.photographerfilters.firstFilter == "" && this.filters.photographerfilters.secondFilter == "")) {
				this.asyncRequestStatus = "pending";
				this.$IGeneral.asyncRequest("posts/__filter", this.filters, [response => {
					this.asyncRequestStatus = 'OK';
					if (response) {
						this.$store.commit('posts/setPosts', response.data);
						this.$CustomModal.actions.closeCustomModal()
					}
				}]);
			} else {

			}
		},
		resetFilter(){
			this.filters.photographerfilters.firstFilter = "";
			this.filters.photographerfilters.secondFilter = "";
			this.filter();
		}
	},
	computed: {
		...mapGetters({
			totalNumberOfPosts: "header/getTotalNumberOfPosts",
			searchInfomation: "header/getSearchInformationObject",
			posts: 'posts/getPosts',
		}),
	},

	mounted() {

	},
}
</script>

<style lang="scss" scoped>

.row-card-admin {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 20px 20px 0 rgba(0, 0, 0, 0.19);
	background: #f1f1f1;
	border-radius: 0%;
}

.filter-label{
	line-height: 37px;
}

</style>