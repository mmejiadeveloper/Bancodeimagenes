<template>
	<div REQUIRED-FOR-TEMPLATE="settings.categories">
		<div class="row row-card-white p-3">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
				<div class="row">
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 text-left table-header">
						<i class="fas fa-newspaper mx-2"></i> Tabla de categorias
					</div>
				</div>
				<div class="row py-3 px-3 category-row category-row-border-side category-backgroundcolor">
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center">
						<div class="row">
							<div
								v-for="(category, index) in sections.categories.items "
								:key="'sections.category__' + index"
								class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-center py-4"
							>
								<Category :category="category" :sections="sections" :index="index"/>
							</div>
							<div
								v-if="sections.categories.items.length <= 0"
								class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center"
							>No existen categorias existentes en el momento.</div>
						</div>
					</div>
				</div>
				<div class="row py-4 category-row category-row-border-bottom category-row-card-darkgray">
					<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right">
						<button
							tabindex="-1"
							v-if="sections.categories.mode == 'add' || sections.categories.mode == 'edit' "
							@click="cancelAdd"
							type="button"
							class="btn btn-danger px-2 w-50"
						>
							<span>
								<i class="fas fa-times"></i>
								Cancelar
							</span>
						</button>
						<button
							tabindex="-1"
							v-if="sections.categories.mode == 'list'"
							:disabled="sections.categories.mode == 'add' || sections.categories.mode == 'edit' "
							@click="addCategory"
							type="button"
							class="btn btn-primary px-2 w-50 category-add-category-button"
						>
							<span>
								<i class="fas fa-plus"></i> Agregar nueva categoria
							</span>
						</button>
					</div>
					<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
						<button
							tabindex="-1"
							@click="saveCategory"
							:disabled="sections.categories.asyncRequest == 'pending' || sections.categories.mode == 'list'"
							type="button"
							class="btn btn-success px-2 w-50"
						>
							<i class="fas fa-save"></i> Guardar
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import Category from "./Category";
export default {
	name: 'settings-categories',
	data() {
		return {
			sections: {
				categories: {
					items: [],
					mode: 'list',
					asyncRequestStatus: '',
					asyncRequest: null,
					options: {
						editable: false
					}
				},
			}

		}
	},
	methods: {
		loadCategories() {
			this.$IGeneral.asyncRequest("categories/__loadCategories", null, [
				response => {
					if (response) {
						this.sections.categories.items = response.categories;
					}
				}
			]
			);
		},
		makeEditable(category, toggled) {
			if (this.sections.categories.mode == 'list') {
				category.options.editable = true;
			}
		},
		editCategory(category) {
			this.sections.categories.mode = 'edit';
			if (category.categoryId != 'localItem') {
				this.sections.categories.asyncRequest = null;
				if (this.sections.categories.asyncRequest == null) {
					this.sections.categories.mode = 'list';
					this.sections.categories.asyncRequest = this.$IGeneral.asyncRequest("categories/__modifyCategories", category, [response => {
						this.sections.categories.asyncRequest = null;
						if (response) {
							category.options.editable = false;
							console.log(response);
							this.loadCategories();
							this.sections.categories.mode = 'list';

							if (response.type == 1) {
								this.$store.dispatch("header/getCategories");
								this.$snotify.success('Ok. La categoria se ha actualizado.', {
									showProgressBar: false,
								});
							}
							else {
								this.$snotify.error('Algo salio mal, no se pudo actualizar la categoria', {
									showProgressBar: false,
								});
							}
						}
					}]);
				}
			}
		},
		deleteCategory(category) {
			this.$IGeneral.vue_swal_confirmacion("Esta seguro que desea eliminar este registro ?", 'Importante', () => {
				this.$IGeneral.asyncRequest("categories/__removeCategories", category, [response => {
					if (response) {
						if (response.type == 1) {
							this.$store.dispatch("header/getCategories");
							this.$IGeneral.vue_swal_successv2("La categoria se ha eliminado", "Listo!");
						} else {
							this.$IGeneral.vue_swal_error(response.message, "Algo salio mal!");
						}
						this.loadCategories();
						this.sections.categories.mode = 'list';
					}
				}]);
			});
		},
		cancelAdd() {
			this.sections.categories.mode = 'list';
			this.sections.categories.items = $.grep(this.sections.categories.items, function (e) {
				return e.categoryId != 'localItem';
			});
		},
		addCategory() {
			this.resetEditableCategories();
			this.sections.categories.mode = 'add';
			this.sections.categories.items.push({
				categoryName: 'Nueva Categoria',
				categoryId: 'localItem',
				categoryStatus: 'pendingToBeCreated',
				options: {
					editable: true
				}
			})
		},
		resetEditableCategories() {
			this.sections.categories.items.forEach(element => {
				element.options.editable = false;
			});
		},
		saveCategory() {
			this.sections.categories.asyncRequest = "pending";
			var pendingCategory = this.sections.categories.items.filter(obj => {
				return obj.categoryId == 'localItem'
			})
			console.log(pendingCategory);

			if (pendingCategory.length > 0) {
				this.$IGeneral.asyncRequest("categories/__addCategories", pendingCategory[0], [response => {
					if (response) {
						console.log(response);
						this.sections.categories.asyncRequest = "OK";
						this.loadCategories();
						this.sections.categories.mode = 'list';

						if (response.type == 1) {
							this.$store.dispatch("header/getCategories");
							this.$snotify.success('Ok. La categoria se ha creado.', {
								showProgressBar: false,
							});
						}
						else {
							this.$snotify.error('Algo salio mal, no se pudo crear la categoria', {
								showProgressBar: false,
							});
						}
					}
				}]);
			}

		}
	},

	components: {
		Category
	},

	mounted() {
		this.loadCategories();
		console.log(__filename);
	},
}
</script>

<style lang="scss" >
.category-row {
	background-color: #f1f1f1;
}
.category-row-border-sides{
	border: 1px solid #e6e6e6;
    border-bottom: 0px;
    border-top: 0px;
}
.category-row-border-bottom{
	border: 1px solid #e6e6e6;
    border-top: 0px;
	border-radius: 5px;
}

.category-add-category-button{
	background: #29B6F6;
	border-color: #29B6F6;
}
.category-backgroundcolor{
	background: #DBDBED !important;
}

.category-row-card-darkgray {
    background-color: #d5d5e4;
    box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}
</style>