<template>
	<div REQUIRED-FOR-TEMPLATE="header" class="appheaderbackgroundEndUser">
		<div class="row centeredAutoScreen">
			<div class="col-xs-5 col-lg-5 col-sm-5 col-md-5 text-left mt-3 offset-md-1">
				<img
					style="cursor:pointer"
					@click="$parent.goToDashboard"
					class="essaemplogo1left"
					src="/img/AppTemplate/Header/essaemplogo1.png"
					alt
				>
			</div>
			<div class="col-xs-6 col-lg-6 col-sm-6 col-md-6 text-right">
				<div class="row">
					<div class="col-xs-6 col-lg-6 col-sm-6 col-md-6 text-right"></div>
					<div
						id="userOptions"
						@click="$parent.initializeCustomModal"
						:class=" [ ( toggleData.rightSideOptions.filter.visible ? 'dropdown-useroptions-active no-horizontal-padding  ' : 'dropdown-useroptions' ) + ' col-xs-6 col-lg-6 col-sm-6 col-md-6 text-center ' ]  "
					>
						<div class=" mt-2 mb-2 d-inline-flex ">

							<b class="mr-2 lh-43">{{loggedUser.name}} 
								<i v-if="!toggleData.rightSideOptions.filter.visible" class="ml-2 fas fa-chevron-down"></i>
								<i v-else class="ml-2 fas fa-arrow-up"></i>
							</b>
							

							<div class="essaemplogo2left ml-2 mr-30px perfectFullyfillProfileIImage " :style=" ' background-image: url(endUserFiles/usersAvatar/'+loggedUser.userAvatarFileName+')' " >
							</div>

							<!-- <span class="mr-2">{{$root.loggedUser.name}}</span>
							<i v-if="!toggleData.rightSideOptions.filter.visible" class="fas fa-chevron-down"></i>
							<i v-else class="fas fa-arrow-up"></i>
							
							<img
								class="essaemplogo2left ml-2"
								:src="'endUserFiles/usersAvatar/'+ $root.loggedUser.userAvatarFileName"
								alt
							> -->
						</div>

						<div id class v-show="toggleData.rightSideOptions.filter.visible">
							<table class="table rightSideUserOptionsTable no-bottom-margin">
								<tbody>
									<tr
										class="text-left"
										:key="index"
										v-for="(item,index) in rightSideUserOptions.options"
										@click="[ item.event ? item.event() : null]"
									>
										<td class="pl-4">
											<i :class="item.viewIcon"></i>
											<span class="pl-3" v-html=" item.viewName"></span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row text-left centeredFrom1100 pt-4 pb-5">
			<div class="col-xs-12 col-lg-12 col-sm-12 col-md-12 pt-3 centeredFromEndUserDataSearch">
				<div class="row">
					<div class="col-xs-12 col-lg-12 col-sm-12 col-md-12 py-3 text-center">
						<div>
							<span class="div-categories-text-hyper-title">La magia empieza aqu&iacute;</span>
						</div>
						<div>
							<span
								class="div-categories-text-title2"
							>Descubre miles de fotograf&iacute;as aprobadas para usar en tus proyectos</span>
						</div>
					</div>
					<div class="col-xs-12 col-lg-12 col-sm-12 col-md-12 mt-4">
						<div class="input-group my-group">
							<div
								@click="$parent.openCategoriesModal"
								class="form-control-custom border-right-mixed-white"
								id="categoryContainer"
							>
								{{ categorySelected.categoryName }}
								<i class="fas fa-chevron-down"></i>
							</div>
							<input
								type="text"
								v-model="$parent.searchInfomation.searchText"
								v-on:keyup.enter="searchPosts"
								class="form-control borderedInputWithStaticHeight border-left-mixed-white"
								:placeholder="'\u00BF Qu\u00E9 est\u00E1 buscando ?'"
							>
							<button
								@click="$parent.searchPosts"
								type="button"
								class="btn btn-primary div-categories-search-button"
							>
								<i class="fas fa-search div-categories-search-button-icon"></i>
							</button>
							<div
								id="categoriesDiv"
								v-show="toggleData.categoryGroup.filter.visible"
								class="div-categories"
							>
								<div class="up-arrow"></div>
								<table class="table table-sm">
									<thead>
										<tr>
											<th colspan="2">BUSCAR EN</th>
										</tr>
									</thead>
									<tbody>
										<tr @click="$parent.selectCategory({categoryName:'Categorias', categoryId:0 })">
											<td class="w-75">Todas</td>
											<td>
												<div>{{ $parent.totalNumberOfPosts }}</div>
											</td>
										</tr>
										<tr
											:key="index"
											v-for="(category, index) in $parent.categories"
											@click="$parent.selectCategory(category)"
										>
											<td class="w-75">{{ category.categoryName }}</td>
											<td>
												<div>{{ category.numberOfPosts }}</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script lang="ts">
import { mapGetters } from "vuex";
export default {
	name: "app-header-end-user",
	data() {
		let parentData = this.$parent._data;
		parentData.childViewState = 'open';
		parentData.asyncRequest = null;
		return parentData;
	},
	methods: {
		searchPosts() {
			if (this.asyncRequest == null) {
				this.checkForCurrentView();
				this.searchInfomation.category = this.categorySelected;
				this.asyncRequest = this.$IGeneral.asyncRequest(
					"posts/__searchPosts",
					this.searchInfomation,
					[
						response => {
							if (this.searchInfomation.searchText.length <= 0) {
								this.$store.commit(
									"header/setSearchInformationObject",
									{
										searchText: this.searchInfomation
											.searchText,
										searchStatus: ""
									}
								);
							} else {
								this.$store.commit(
									"header/setSearchInformationObject",
									{
										searchText: this.searchInfomation
											.searchText,
										searchStatus: "done"
									}
								);
							}

							this.asyncRequest = null;
							if (response) {
								if (response.type == 1) {
									this.$store.commit(
										"posts/setPosts",
										response.data
									);
								}
							}
						}
					]
				);
			}
		},

		checkForCurrentView() {
			if (this.$router.currentRoute.name != "postsadmin") {
				this.sendToMainPostView();
			}
		},
		sendToMainPostView() {
			this.$router.push("/");
		},
	},
	computed: {
		...mapGetters({
			categories: "header/getCategories",
			totalNumberOfPosts: "header/getTotalNumberOfPosts",
			searchInfomation: "header/getSearchInformationObject",
			loggedUser: 'createUserModal/getLoggedUser',

		}),
		/* options() {
			return this.rightSideUserOptions.options.filter(item => {
				return item.onlyForAdministrator == true;
			});
		},

		currentDataViewName() {
			return  this.rightSideUserOptions.options.filter(obj => {
				return obj.viewRoute == this.$router.currentRoute.name;
			})[0].viewName.toLowerCase();
		}, */
	},

};
</script>

<style lang="css" scoped>
.img1header {
	height: 370px;
	width: 100%;
	position: absolute;
	top: 0;
	left: 0;
}

.essaemplogo1left {
	width: 140px;
}

.dropdown-useroptions {
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	padding-top: 7px;
	padding-bottom: 7px;
	background-color: transparent;
	position: absolute;
	min-width: 200px;
	right: 0px !important;
}

.dropdown-useroptions-active {
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	padding-top: 7px;
	padding-bottom: 7px;
	background-color: #002d6b;
	color: #fff;
	z-index: 2;
	position: absolute;
	min-width: 200px;
	right: 0px !important;
}

.essaemplogo2left {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	border: 2px solid #fff;
}

.essaemplogo3row {
	width: 200px;
	height: 200px;
	border-radius: 50%;
	border: 2px solid white;
}

.rightSideUserOptionsTable {
	background-color: #fff;
	color: #002d6b;
	position: absolute;
}

.borderedInputWithStaticHeight {
	height: 55px;
	-webkit-border-radius: 50px;
	-moz-border-radius: 50px;
	border-radius: 10px;
}
.borderedInputWithStaticHeight::placeholder {
	color: #c2c2c2;
}

.form-control-custom {
	text-align: center;
	padding: 15px;
	font-size: 12px;
	font-weight: 400;
	line-height: 1.5;
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ced4da;
	width: 150px;
	padding-top: 15px;
	padding-bottom: 15px;
	border-top-left-radius: 0.25rem;
	border-bottom-left-radius: 0.25rem;
	cursor: pointer;
	line-height: 23px;
}

.div-categories {
	position: absolute;
	height: auto;
	top: 65px;
	border-radius: 5px;
	background-color: #fff;
	color: #002d6b;
	font-size: 12px;
	width: 150px;
	z-index: 5;
}

.div-categories table thead > tr > th {
	border: 1px solid transparent;
	padding: 13px;
	color: #6d6d6d;
}

.div-categories table tbody > tr > td:nth-of-type(2n + 0) div {
	/* background: #e6e6e6; */
	font-size: 8px;
	border: 1px solid #dedede;
	padding: 3px;
	text-align: center;
	font-weight: bold;
	border-radius: 5px;
}

.div-categories table tbody > tr {
	cursor: pointer;
}

.div-categories table tbody > tr > td:nth-of-type(1n + 0) {
	padding-left: 15px;
}

.div-categories table tbody > tr > td:nth-of-type(2n + 0) {
	padding-left: 5px;
}

.div-categories table tbody > tr:hover {
	background-color: #002d6b;
	color: #fff;
}

.div-categories table tbody > tr:hover td div {
	background: rgb(46, 115, 212);
	border: 1px solid rgb(46, 115, 212);
	color: #fff;
}

.div-categories-text-title {
	color: #fff;
	font-size: 25px;
	font-weight: bold;
}

.div-categories-text-title2 {
	color: #fff;
	font-size: 20px;
}

.div-categories-text-hyper-title {
	color: #fff;
	font-size: 45px;
	font-weight: bold;
}

.div-categories-search-button {
	position: absolute;
	right: 0;
	height: 100%;
	border-radius: 0px;
	background-color: #c62e45;
	border: 1px solid #c62e45;
	width: 80px;
	z-index: 20;
}

.div-categories-search-button-icon {
	font-size: 27px;
}

.appheaderbackground {
	background: url(/img/AppTemplate/Header/imgHeader1.png) no-repeat
		center center;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
.appheaderbackgroundEndUser {
	background: url(/img/AppTemplate/Header/imgHeader1.png);
	height: calc(76vh) !important;
	background-position: center right !important;
	background-size: cover !important;
}

.perfectFullyfillProfileIImage{
	background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}

</style>