<template>
	<div class="row row-card-white p-3">

		<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
			<div class="row">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 text-left table-header">
					<i class="fas fa-newspaper mx-2"></i> Servidor de correos saliente
				</div>
			</div>

			<div class="row px-3 text-center server-backgroundcolor">
				<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-center mt-3">
					<table class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0">
						<tbody>
							<tr>
								<td class="py-3"> <b>Permitir personalizaci&oacute;n de STMP</b></td>
								<td class="py-3">
									<section title=".slideThree ">
										<div
										:class="( [outgoingEmailServer.form.allowCustomSTMP ? ' slideThree-active ' : ' slideThree-inactive '] )+ ' slideThree  my-0' ">
											<input type="checkbox" value="None" id="slideThree3" name="check"
											v-model="outgoingEmailServer.form.allowCustomSTMP">
											<label for="slideThree3"></label>
										</div>
									</section>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-center mt-3">
					<table class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0">
						<tbody>
							<tr>
								<td class="py-3 pl-4 text-left w-25">
									<b>Integraci&oacute;n:</b>
								</td>
								<td class="py-3 pr-4 text-left">
									<select class="form-control form-control-sm" name v-model="outgoingEmailServer.form.integration"
									:disabled="!outgoingEmailServer.form.allowCustomSTMP">
										<option>Seleccione su integraci&oacute;n SMTP</option>
										<option value="prueba">Prueba</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center mt-3">
					<table
						class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0 py-2"
					>
						<tbody>
							<tr>
								<td class="py-3 pl-4 text-left w-25"> <b>API KEY:</b> </td>
								<td class="py-3 pl-4 text-left">
									<input
										v-model="outgoingEmailServer.form.APIKEY"
										type="text"
										class="form-control"
										aria-describedby="helpId"
										placeholder
										:disabled="!outgoingEmailServer.form.allowCustomSTMP"
									>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center mt-3">
					<table
						class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0 py-2"
					>
						<tbody>
							<tr>
								<td class="py-3 pl-4 text-left w-25"> <b>Cuenta de correo saliente:</b></td>
								<td class="py-3 pl-4 text-left">
									<input
										v-model="outgoingEmailServer.form.outgoingEmailAccount"
										type="text"
										class="form-control"
										aria-describedby="helpId"
										placeholder
										:disabled="!outgoingEmailServer.form.allowCustomSTMP"
									>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center my-3">
					<table
						class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0 py-2"
					>
						<tbody>
							<tr>
								<td class="py-3 pl-4 text-left w-25"> <b>Contrase&ntilde;a de cuenta:</b> </td>
								<td class="py-3 pl-4 text-left">
									<input
										v-model="outgoingEmailServer.form.passwordOutgoingEmailAccount"
										type="text"
										class="form-control"
										aria-describedby="helpId"
										placeholder
										:disabled="!outgoingEmailServer.form.allowCustomSTMP"
									>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row row-card-darkgray py-4 server-row-card-darkgray">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center">
					<button :disabled="outgoingEmailServer.updateAsyncRequestStatus == 'pending' " @click="updateData" type="button" class="btn btn-success px-2 w-25">
						<i class="fas fa-save"></i> Guardar
					</button>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		name : 'settings-outgoingemailserver',
		props: {
			sections: {
				type: Object,
			},
		},
		data() {
			return {
				outgoingEmailServer: {
					form:{

					},
					updateAsyncRequestStatus:''
				}
			}
		},
		methods: {
			loadOutGoingEmailServerData() {
				this.$IGeneral.asyncRequest("outgoingemailserver/__loadInfo", this.tag, [response => {
					if (response) {
						if (response.type == 1) {
							this.outgoingEmailServer.form = response.data;
						}
					}
				}]);
			},
			updateData(){
				this.outgoingEmailServer.updateAsyncRequestStatus = "pending"

				this.$IGeneral.asyncRequest("outgoingemailserver/__modifyInfo", this.outgoingEmailServer.form, [response => {
					if (response) {
						this.outgoingEmailServer.updateAsyncRequestStatus = "OK"
						if (response.type == 1) {
							this.$snotify.success('Ok. La informacion se ha actualizado.',{
								showProgressBar: false,
							});
						}else{
							this.$snotify.error('Algo salio mal, no se pudo actualizar la informacion',{
								showProgressBar: false,
							});
						}
					}
				}]);
			}
		},
		mounted () {
			this.loadOutGoingEmailServerData();

		},
	}
</script>

<style lang="scss" scoped>
.server-backgroundcolor{
	background: #DBDBED !important;
}

.server-row-card-darkgray {
    background-color: #d5d5e4;
    box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}
</style>