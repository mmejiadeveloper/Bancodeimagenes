<template>
	<div REQUIRED-FOR-TEMPLATE="createusermodal">
		<div
			class="modal fade"
			id="createUserModal"
			tabindex="-1"
			role="dialog"
			aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true"
			data-backdrop="static"
			data-keyboard="false"
		>
			<div class="modal-dialog modal-dialog-centered recenter-to-480" role="document">
				<div class="modal-content mt-100">
					<div class="modal-body pt-0">
						<div class="row bluegradient">
							<div style="height:80px;" class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
								<div v-if="asyncRequests.userIntegrity == 1" style="cursor:pointer;" @click="hide()">
									<i class="fas fa-times float-right mt-3"></i>
								</div>
								<div style="position: absolute; left: 50%; top: -74%;">
									<div style="position: relative; left: -50%;">
										<div
											id="image-upload"
											:class=" [ asyncRequests.formStep == 0  || asyncRequests.formStep == 4 ? 'uploadPhotodiv' : 'uploadPhotodiv-created' ] "
										>
											<label for="file-input" class>
												<span class="span-abs zx-100">
													<i class="fas fa-upload"></i>
													Subir foto
												</span>
											</label>
											<input
												name="files[]"
												id="file-input"
												type="file"
												@change="onFileChange"
												ref="file"
												class="zx-100"
											>
										</div>
										<div class="layout">
											<!-- <div v-if="url && form.loadedFileExistence "  id="preview">
												<img :src="url" alt="no existing file">
											</div> -->

											<div  v-if="url && form.loadedFileExistence " id="preview" class="perfectFullyfillProfileIImage " :style=" ' background-image: url('+url+')' " >
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
								<h5
									v-if=" formMode == 'newUser' &&  ( asyncRequests.formStep == 0 || asyncRequests.formStep == 4 )"
									class="font-weight-bold"
								>Nombre del usuario</h5>
								<div v-else-if="formMode == 'updateLoggedUser' || formMode == 'editUser' ">
									<h5
										class="font-weight-bold"
									>{{ form.name }} </h5>
									<h5
										class="font-weight-bold"
									>C.C {{ form.identificationNumber }}</h5>
								</div>
							</div>
							<div
								v-if="formMode == 'updateLoggedUser' || formMode == 'editUser' "
								class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center pb-3"
							>
								<small>Creado el {{ form.createdAt }}</small>
							</div>
							<div
								style="color:red;"
								v-if="asyncRequests.userIntegrity == 2 && asyncRequests.formStep == 0"
								class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center pb-3"
							>
								<small>Sus datos de usuario han sido modificados de una manera no autorizada o permitida, debe cambiar la contrase&ntilde;a de su cuenta antes de realizar cualquier operaci&oacute;n</small>
							</div>
							<div
								style="color:red;"
								v-if="errorMessage.length > 0"
								class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center pb-3"
							>
								<small>{{errorMessage}}</small>
							</div>
						</div>
						<!-- <form :data-vv-scope='formScope'> -->

						<div
							v-if="asyncRequests.formStep == 0 || asyncRequests.formStep == 4"
							class="row px-4 pt-4 text-left"
						>
							<form class="w-100" :data-vv-scope="'createUserScope'">
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Nombre de usuario (*)</label>
										<input
											v-model=" form.name"
											type="text"
											class="form-control input-shadow"
											aria-describedby="helpId"
											placeholder="Ingresa el nombre del usuario"
											:disabled="asyncRequests.formStep == 4"
											v-validate="'required'"
											name="nombre"
											maxlength="35"
											@keyup="$store.dispatch('localData/saveRowFormData', form)"
										>
										<span>{{ errors.first('createUserScope.nombre') }}</span>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Documento de identificac&oacute;n (*)</label>
										<input
											v-model=" form.identificationNumber"
											type="text"
											class="form-control input-shadow"
											aria-describedby="helpId"
											:placeholder="'N\u00FAmero de identificaci\u00F3n'"
											:disabled="asyncRequests.formStep == 4"
											v-validate="'required'"
											:name="'c\u00E9dula'"
											@keyup="$store.dispatch('localData/saveRowFormData', form)"
										>
										<span>{{ errors.first('createUserScope.' + 'c\u00E9dula') }}</span>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Correo electronico (*)</label>
										<input
											v-model="form.email"
											type="text"
											class="form-control form-control-md input-shadow"
											aria-describedby="helpId"
											placeholder="Ingresa el email del usuario"
											:disabled="asyncRequests.formStep == 4"
											@keyup="$store.dispatch('localData/saveRowFormData', form)"
											name="correo"
											v-validate="'required|email'"
										>
										<span>{{ errors.first('createUserScope.correo') }}</span>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Contrase&ntilde;a</label>
										<input
											v-model="form.password"
											type="password"
											class="form-control form-control-md input-shadow"
											aria-describedby="helpId"
											:placeholder="'Ingresa la contrase\u00F1a del usuario'"
											:disabled="asyncRequests.formStep == 4"
											@keyup="$store.dispatch('localData/saveRowFormData', form)"
											name="contrasena"
											v-validate="'required|min:6'"
										>
										<span>{{ errors.first('createUserScope.contrasena') }}</span>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Celular</label>
										<input
											v-model="form.phoneNumber"
											type="text"
											class="form-control form-control-md input-shadow"
											aria-describedby="helpId"
											placeholder="Ingresa el celular del usuario"
											:disabled="asyncRequests.formStep == 4"
											@keyup="$store.dispatch('localData/saveRowFormData', form)"
											name="celular"
											v-validate="'required|numeric'"
										>
										<span>{{ errors.first('createUserScope.celular') }}</span>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Tipo de usuario</label>
										<select
											v-model="form.profileId"
											class="form-control"
											:disabled="asyncRequests.formStep == 4 || $root.loggedUser.profileId != 1"
											@change="$store.dispatch('localData/saveRowFormData', form)"
											name="tipo"
											v-validate="'required'"
										>
											<option value>Seleccione el tipo de usuario</option>
											<option
												:key="index"
												:value="profile.profileId"
												v-for="(profile, index ) in profiles "
											>{{ profile.profileName }}</option>
										</select>
										<span>{{ errors.first('createUserScope.tipo') }}</span>
									</div>
								</div>
								<div v-if="form.profileId != 1" class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Departamento</label>
										<select
											v-model="form.userDepartmentId"
											class="form-control"
											:disabled="asyncRequests.formStep == 4 || $root.loggedUser.profileId != 1"
											@change="$store.dispatch('localData/saveRowFormData', form)"
											name="departamento"
											v-validate="'required'"
										>
											<option value>Seleccione un departamento</option>
											<option
												:key="index"
												:value="department.userDepartmentId"
												v-for="(department, index ) in departments "
											>{{ department.departmentName }}</option>
										</select>
										<span>{{ errors.first('createUserScope.departamento') }}</span>
									</div>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12">
									<div class="form-group">
										<label for>Estado</label>
										<select
											v-model="form.userState"
											class="form-control"
											:disabled="asyncRequests.formStep == 4 || $root.loggedUser.profileId != 1"
											@change="$store.dispatch('localData/saveRowFormData', form)"
											name="departamento"
											v-validate="'required'"
										>
											<option value="0">Seleccione</option>
											<option value="1">Activo</option>
											<option value="2">Inactivo</option>
										</select>
										<span>{{ errors.first('createUserScope.departamento') }}</span>
									</div>
								</div>
							</form>
						</div>

						<div v-else class="row px-4 pt-4 text-center">
							<div v-if="asyncRequests.formStep == 1">
								<div v-if="this.formMode == 'newUser'">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<img src="/img/AppTemplate/Modules/Modals/Users/userCreatedimg.png" alt>
									</div>
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<h3>Listo!, tu nuevo usuario ha sido creado.</h3>
									</div>
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<p class="grayFont">
											Has creado un nuevo usuario, a partir de este momento
											podr&aacute; ingresar a la plataforma
										</p>
									</div>
								</div>

								<div v-if="this.formMode == 'updateLoggedUser'">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<img src="/img/AppTemplate/Modules/Modals/Users/userCreatedimg.png" alt>
									</div>
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<h3>Listo!, tus datos han sido actualizados</h3>
									</div>
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<p class="grayFont">
											Has actualizado correctamente tus datos, puedes modificarlos nuevamente en cualquier
											momento
										</p>
									</div>
								</div>
								<div v-if="this.formMode == 'editUser'">
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<img src="/img/AppTemplate/Modules/Modals/Users/userCreatedimg.png" alt>
									</div>
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<h3>Listo!, los datos han sido actualizados</h3>
									</div>
									<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
										<p class="grayFont">Has actualizado correctamente los datos de este usuario.</p>
									</div>
								</div>
							</div>
							<div v-if="asyncRequests.formStep == 2 || asyncRequests.formStep == 3">
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
									<img src="/img/AppTemplate/Modules/Users/internalerror.png" alt width="300px">
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
									<h3>Error!</h3>
								</div>
								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center">
									<p class="grayFont">
										Ocurrio un problema al actualizar la informaci&oacute;n, por favor vuelve a interntarlo
										y si el problema persiste comuniquese con el administrador del sistema.
									</p>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer text-center mx-auto">
						<button
							@click="save"
							v-if="asyncRequests.formStep == 0 || asyncRequests.formStep == 4"
							type="button"
							class="btn btn-success"
							:disabled="asyncRequests.formStep == 4"
						>
							<span>
								<i class="fas fa-save mr-2"></i>
								Guardar
							</span>
						</button>
						<button v-else @click="hideAfterUpdate()" type="button" class="btn btn-primary">
							<span>
								<i class="fas fa-times mr-2"></i>
								Cerrar ventana
							</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
	name: "createuser-modal",
	data() {
		return {
			errorMessage: '',

			profiles: [],
			departments: []
		};
	},
	methods: {
		save() {
			this.$validator.validateAll('createUserScope').then((result) => {
				if (!result) {
					this.$snotify.error('Por favor complete la informaci\u00F3n', {
						showProgressBar: false,
					});
					return;
				} else {

					if (this.formMode == 'updateLoggedUser') {
						this.updateUserData();
					}
					if (this.formMode == 'newUser') {
						this.newOrModifiedUser('users/__addUser');
					}
					if (this.formMode == 'editUser') {
						this.newOrModifiedUser('users/__modifyUser');
					}

				}
			}).catch(() => { });
		},
		hide() {
			console.log("cerrar");
			$("#createUserModal").modal("hide");
			if (this.formMode == 'newUser' || this.formMode == 'editUser') {
				this.resetFormAndDataForNewUser();
			}
		},
		hideAfterUpdate() {
			$("#createUserModal").modal("hide");
			if (this.$root.loggedUser) {
				// this.asyncRequests.formStep = 0;
				this.$store.commit('createUserModal/setAsyncRequestField', {'formStep': 0});
			}
			if (this.formMode == 'newUser' || this.formMode == 'editUser') {
				this.resetFormAndDataForNewUser();
			}
		},
		resetFormAndDataForNewUser() {
			this.resetFormData();
		},
		resetFormData() {
			if (this.$root.loggedUser) {
				for (const field in this.form) {
					if (this.form.hasOwnProperty(field)) {
						this.form[field] = '';
					}
				}
			}
		},

		setUserDataToEdit(row) {
			if (this.$root.loggedUser) {
				this.form.name = row.name;
				this.form.email = row.email;
				this.form.password = row.passwordMask;
				this.form.phoneNumber = row.phoneNumber;
				this.form.userDepartmentId = row.userDepartmentId;
				this.form.userState = row.userState;
				this.form.profileId = row.profileId;
				this.form.userId = row.userId;
				this.form.identificationNumber = row.identificationNumber;
				this.url = 'endUserFiles/usersAvatar/' + row.userAvatarFileName;
				this.form.loadedFileExistence = row.loadedFileExistence;
				this.form.createdAt = row.created_at;
			}
		},
		newOrModifiedUser(dir) {
			// this.asyncRequests.updateUser.status = "processingRequest";
			// this.asyncRequests.formStep = 4;
			this.$store.commit('createUserModal/setAsyncRequestField', {'updateUser.status': 0});
			this.$store.commit('createUserModal/setAsyncRequestField', {'formStep': 4});

			this.$IGeneral.asyncRequest(
				dir,
				this.form ? this.form : null,
				[
					response => {
						console.log(response);

						if (response) {
							/* this.asyncRequests.updateUser.status = response.type;
							this.asyncRequests.formStep = response.type; */
							this.$store.commit('createUserModal/setAsyncRequestField', {'updateUser.status': response.type} );
							this.$store.commit('createUserModal/setAsyncRequestField', { 'formStep' : response.type});
							this.$store.dispatch('users/getAllUsers', () => {
								this.$store.dispatch('paginator/setRowsData', this.$store.getters['users/getUsers']);
								// this.resetFormAndDataForNewUser();
							});
						}
					}
				],
				[this.$refs.file.files[0]]
			);

		},
		updateUserData() {
			/* this.asyncRequests.updateUser.status = "processingRequest";
			this.asyncRequests.formStep = 4; */
			this.$store.commit('createUserModal/setAsyncRequestField', {'updateUser.status': 'processingRequest'});
			this.$store.commit('createUserModal/setAsyncRequestField', {'formStep': 4} );
			this.$IGeneral.asyncRequest(
				"users/__modifiyUserData",
				this.form ? this.form : null,
				[
					response => {
						if (response) {
							/* this.asyncRequests.updateUser.status = response.type;
							this.asyncRequests.formStep = response.type; */
							this.$store.commit('createUserModal/setAsyncRequestField', {'updateUser.status': response.type} );
							this.$store.commit('createUserModal/setAsyncRequestField', {'formStep':  response.type} );
							this.$store.commit('createUserModal/setLoggedUser', response.loggedUser );
							// this.$store.commit('createUserModal/setUserData',  response.loggedUser);
							// this.$root.loggedUser = response.loggedUser;
							console.log('rrr', response.loggedUser);
						}
					}
				],
				[this.$refs.file.files[0]]
			);

		},
		onFileChange(e) {
			const file = e.target.files[0];
			let loadedFile = this.$refs.file.files[0];
			if (this.validateFileExtension(loadedFile) == 1) {
				// this.url = URL.createObjectURL(file);
				this.$store.commit('createUserModal/setFileProfileUrl', URL.createObjectURL(file))
				this.form.file = null;
				this.form.file = (this.$refs.file.files[0]);
				this.form.loadedFileExistence = true;
			}
		},

		validateFileExtension(loadedFile) {
			let allowed = 1;
			let fileExtension = loadedFile.name.split('.').pop().toLowerCase();
			let allowedExtensions = ['jpg', 'png', 'gif']
			if (!allowedExtensions.includes(fileExtension)) {
				this.errorMessage = 'La foto no cumple con el formato permitido, los formatos permitidos son: jpg, png, gif';
				allowed = 2;
			} else {
				this.errorMessage = '';
			}
			return allowed;
		},

		loadProfilesAndDepartments() {
			this.$IGeneral.asyncRequest("users/__loadProfilesAndDepartments", null, [response => {
				if (response) {
					console.log(response.data);
					this.profiles = response.data.profiles;
					this.departments = response.data.departments;
				}
			}]);
		},

		forceUserToUpdateHisData(){
			$("#createUserModal").modal("show");
			$(".customModal").fadeOut();
			this.$store.commit('createUserModal/setUserData');
			this.$store.commit('createUserModal/setFormMode', 'updateLoggedUser');
		}
	},

	mounted() {
		if (this.$root.loggedUser) {
			this.$store.commit('createUserModal/setAsyncRequestField', {'userIntegrity': this.$root.loggedUser.userIntegrity });
			if (this.$root.loggedUser.userIntegrity == 2) { //If integrity has been broken then force user logged data update
				this.forceUserToUpdateHisData();
			}
		}

		/*if (this.formMode == 'newUser') {
			this.$store.dispatch('localData/loadLocalRow', this);
		} */


		this.loadProfilesAndDepartments();
	},

	computed: {
		...mapGetters({
			form: 'createUserModal/getUserForm',
			formMode: 'createUserModal/getFormMode',
			asyncRequests: 'createUserModal/getAsyncRequests',
			loggedUser: 'createUserModal/getLoggedUser',
			url: 'createUserModal/getFileProfileUrl',
		})
	},
};
</script>

<style lang="scss" scoped>
.zx-100 {
	z-index: 100;
}
#preview {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	top: -120px;
	background: #313131;
	border-radius: 50%;
	border: 2px solid white;
}

#preview img {
	max-width: 100%;
	max-height: 500px;
	border-radius: 50%;
	z-index: 1;
	background-repeat: round;
	color: transparent;
	cursor: auto;
	width: 120px;
	height: 120px;
	opacity: 0.4;

}

#image-upload > input {
	display: none;
}

.tagsTitle {
	background: #0065cb;
	color: white;
	border-radius: 5px;
	font-size: 15px;
	font-weight: bold;
}

.blue {
	background: #0065cb;
	color: white;
}

.uploadPhotodiv-created {
	width: 120px;
	height: 120px;
	// background-image: url(/img/AppTemplate/Header/aaaa.png);
	border-radius: 50%;
	z-index: 1;
	background-repeat: round;
	color: transparent;
	cursor: auto;
}

.uploadPhotodiv-created span {
	display: none;
}

.uploadPhotodiv {
	width: 120px;
	height: 120px;
	background: #e7e7e7;
	border-radius: 50%;
	z-index: 1;
}

.v--modal-overlay[data-modal="create-user"] {
	background: rgba(0, 0, 0, 0.5);
}

.span-abs {
	position: absolute;
	top: 46px;
	left: 18px;
	// color: #585858;
	color: #fff;
	cursor: pointer;
}

.input-shadow {
	box-shadow: 1px 1px 8px 1px #d4d4d4;
}
.w-400px {
	width: 400px;
}

.modal-body {
	padding: 15px;
}

.mt-100 {
	margin-top: 100px;
}
.bluegradient {
	color: #fff;
	background-image: linear-gradient(#022b67, #1279e1);
}

.grayFont {
	color: #8a8a8a;
}

.perfectFullyfillProfileIImage{
	background-size: cover !important;
    background-position: center !important;
    background-repeat: no-repeat !important;
	height: 120px;
}
</style>