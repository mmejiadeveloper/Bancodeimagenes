<template>
	<div class="row py-3 px-5 row-card row-card-admin">
		<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
			<div class="row">
				<div class="col-sm-5 col-md-5 col-lg-5 col-xl-5 text-center borderRight">
					<span v-if="$parent.mode == 'create'" class="user-tag">ID: ES{{ $parent.lastId}}</span>
					<span v-else class="user-tag">ID: ES{{ $parent.form.postId }}</span>
				</div>
				<div class="col-sm-7 col-md-7 col-lg-7 col-xl-7 text-center form-inline">
					<span class="postState pl-2">Estado del recurso</span>
					<section title="Estado del recurso" class="pl-4">
						<div
							:class="( [ form.postState ? ' slideThree-active ' : ' slideThree-inactive '] )+ ' slideThree  my-0' "
						>
							<input
								v-model="form.postState"
								type="checkbox"
								value="None"
								id="slideThree1"
								name="check"
								checked
								@change="$store.dispatch('localData/saveRowFormData', $parent.form)"
								:disabled="form.asyncRequests.status == 1"
							>
							<label for="slideThree1"></label>
						</div>
					</section>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
			<div class="row">
				<div class="col-sm-5 col-md-5 col-lg-5 col-xl-5 text-left"></div>
				<div class="col-sm-7 col-md-7 col-lg-7 col-xl-7 text-right mt-1">
					<span
						v-if="$parent.mode == 'update' "
						@click="$store.dispatch('filter/toggleVariableAndSetModalEffect')"
						class="checkoutStatisticsPointer"
					>
						Ver estadisticas de la imagen
						<i class="far fa-sticky-note mx-2"></i>
					</span>
					<!-- 	<span
						v-if="$parent.mode == 'update' "
						@click="$parent.toggleVariableAndSetModalEffect('imageStatistics.visible', true, 'floatingImageStatistics', 'postsform' )"
						class="checkoutStatisticsPointer"
					>
						Ver estadisticas de la imagen
						<i class="far fa-sticky-note mx-2"></i>
					</span>-->
					<div
						v-show="toggleData.viewStats.filter.visible"
						id="floatingImageStatistics"
						class="floatingImageStatistics w-100 py-3"
					>
						<div class="up-arrow-black-pos2"></div>
						<table class="table table-sm table-borderless mb-0">
							<tbody>
								<tr>
									<td>Descargas</td>
									<td>
										<div class="borderedDivForStatistics mx-3">
											<i class="fas fa-cloud-download-alt mr-1"></i>
											<span>{{form.postStadistics.postDownloads}}</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>Favoritos</td>
									<td>
										<div class="borderedDivForStatistics mx-3">
											<i class="fas fa-heart mr-1"></i>
											<span>{{form.postStadistics.postFavorites}}</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>Proyectos</td>
									<td>
										<div class="borderedDivForStatistics mx-3">
											<i class="fas fa-folder mr-1"></i>
											<span>{{form.postStadistics.postProjects}}</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>Usuarios</td>
									<td>
										<div class="borderedDivForStatistics mx-3">
											<i class="fas fa-users mr-1"></i>
											<span>{{form.postStadistics.postUsers}}</span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex';
export default {
	name: 'toppart-form',
	computed: {
		...mapGetters({
			imageStatistics: 'posts/getImageStatistics',
			form: 'posts/getFormData',
		})
	},
	data() {
		return {
			toggleData: {
				viewStats: {
					jqueryElements: ["floatingImageStatistics"],
					ref: "DOES-NOT-APPLY-BECAUSE-THIS-COMPONENT-IS-NOT-BINDED-TO-A-REF",
					modalEffect: true,

					filter: {
						visible: false,
						appliesForCustomModalPlugin: true,
						advancedFilter: false
					}
				},
				idGroup: ""
			},
		}
	}, 

	methods: {
		initializeCustomModal() {
			this.toggleData.idGroup = 'viewStats';
			this.$store.dispatch('filter/initializeFilterForCustomModal', this);
			//this.$store.dispatch('filter/toggleVariableAndSetModalEffect')
		},
	},

	mounted () {
		this.initializeCustomModal();
	},

	watch: {
		$route(to, from) {
			this.initializeCustomModal();
		}
	}
}
</script>

<style lang="scss" scoped>
.row-card-admin {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: #f1f1f1;
	border-radius: 0%;
}
</style>