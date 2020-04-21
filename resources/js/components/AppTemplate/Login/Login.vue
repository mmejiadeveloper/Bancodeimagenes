<template>
	<div
		REQUIRED-FOR-TEMPLATE="login"
		class="loginbody centerheight"
		:style=" $root.backGroundData.length > 0 ?
	 ' background: linear-gradient(0deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url(/endUserFiles/postFiles/'+$root.backGroundData[0].miniImageUrl+'); ' :
	 ' background: linear-gradient(0deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url(/img/fondologin.png); ' "
	>
		<div
			v-if="$root.backGroundData.length > 0"
			class="form-inline mx-4"
			style="position: absolute; bottom: 2%;"
		>
			<div :style="' background-image: url(/endUserFiles/usersAvatar/'+$root.backGroundData[0].userAvatarFileName+'); '" class="autorBackground"></div>
			<div class="mx-4 color-white">
				<b class="autorName" v-html="$root.backGroundData[0].userName" ></b>
				<div class="fs-11" v-html="$root.backGroundData[0].postName"></div> 
			</div>
		</div>

		<div class="row align-items-center h-100 centeredAutoScreen">
			<div class="col-sm-6 col-md-6 col-xl-6 col-lg-6 pl-0">
				<img
					class="img-fluid"
					:src="'/img/AppTemplate/Login/bancodeimagenes.png'"
					alt="Chania"
					width="500"
				>
			</div>
			<div class="col-sm-6 col-md-6 col-xl-6 col-lg-6">
				<div class="card mx-auto formResizedAutoHight borderedCard">
					<div class="card-body px-4-1">
						<div class="row text-center pb-4">
							<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12">
								<img class="w-55" src="/img/AppTemplate/Login/loginlogo1.png" alt>
							</div>
						</div>
						<form v-if="mode == 'login'" v-on:keyup.enter="check">
							<div class="input-group form-group mb-2">
								<input v-model="user.email" type="text" class="form-control" placeholder="E-mail">
							</div>
							<div class="input-group form-group">
								<input v-model="user.password" type="password" class="form-control" placeholder="Clave">
							</div>
							<div class="input-group form-group remember mt-4-1">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" value id="defaultCheck1">
									<label class="form-check-label fs-12" for="defaultCheck1">Recordar contrase&ntilde;a</label>
								</div>
							</div>

							<div class="form-group text-center pt-4">
								<input
									@click="sendLoginRequest"
									type="button"
									value="Ingresar"
									class="btn login_btn"
									:disabled="loginAsyncRequest.done == 'pending'"
								>
							</div>
							<!-- <div v-if="loginAsyncRequest.status == true || loginAsyncRequest.status == false" class="form-group text-center pt-4">
								<span :class=" [loginAsyncRequest.status == true ? ' successMessage ' : ' errorMessage ' ] "  v-html="">
									{{ loginAsyncRequest.message }}
								</span>
							</div>-->
						</form>
						<form v-if="mode == 'restorePassword'">
							<div class="row text-center mt-5">
								<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12">Ingresa tu correo electr&oacute;nico</div>
								<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12 py-3">
									<input v-model="user.email" type="text" class="form-control" placeholder="E-mail">
								</div>
								<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12 pb-2">
									<input
										:disabled="loginAsyncRequest.done == 'pending' "
										@click="restorePassword"
										type="button"
										value="Recuperar"
										class="btn login_btn"
									>
									<img
										v-if="loginAsyncRequest.done == 'pending' "
										src="/img/AppTemplate/Login/ajax-loader.gif
									"
										alt
									>
								</div>
							</div>
						</form>
						<form>
							<div class="row text-center ">
								<div v-if="mode == 'passswordSentToEmail'" class="col-sm-12 col-lg-12 col-md-12 col-xl-12">
									<img
										class="img-fluid"
										:src=" loginAsyncRequest.done == 'OK' ? '/img/AppTemplate/Login/passwordSent.png' : '/img/AppTemplate/Login/internalerror.png'"
										alt="Chania"
										width="200"
									>
								</div>
								<div
									v-if="mode == 'passswordSentToEmail'"
									class="col-sm-10 col-lg-10 col-md-10 col-xl-10 py-3 offset-lg-1"
								>
									<h5 class="font-weight-bold" v-if="loginAsyncRequest.done == 'OK' ">Listo! revisa to correo electr&oacute;nico</h5>
									<h5 class="font-weight-bold" v-else>Algo salio mal...</h5>
								</div>
								<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12 px-5">
									<div
										:class=" ' fs-12 lh-14 ' + [loginAsyncRequest.status == 'OK' ? '  ' : ' errorMessage ' ] " v-html="loginAsyncRequest.message"
									></div>
								</div>
							</div>
						</form>
					</div>
					<div v-if=" mode == 'login' || mode == 'restorePassword' " class="row text-center">
						<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12">
							<img width="80%" src="/img/AppTemplate/Login/lineor.png" alt>
						</div>
					</div>
					<div class="row text-center card-login-footer">
						<div class="col-sm-12 col-lg-12 col-md-12 col-xl-12">
							<a
								class="fs-12"
								v-if="mode == 'login'"
								@click.prevent="resetAsyncRequest "
								href
							>&iquest; Olvidaste tu contrase&ntilde;a ?</a>
							<a class="fs-12" v-if="mode == 'restorePassword'" @click.prevent="resetToLoginForm" href>Regresar</a>
							<a class="fs-12" v-if="mode == 'passswordSentToEmail'" @click.prevent="resetToLoginForm" href>Regresar</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script >
export default {
	name: "login",
	data() {
		return {
			mode: "login",
			user: {
				email: "",
				password: ""
			},
			loginAsyncRequest: {
				done: '',
				status: '',
				message: ''
			},

		};
	},
	methods: {
		sendLoginRequest() {
			this.cleanLoginAsyncRequest();
			this.loginAsyncRequest.done = 'pending';
			this.$IGeneral.asyncRequest("auth/__validate", this.user, [
				response => {
					this.loginAsyncRequest.done = 'error';
					if (response) {
						this.setLoginAsyncRequest(response);

						if (response.exists == true) {
							location.reload();
						}
					}
				}
			]);
		},
		check(event){
			// alert(this.mode);
			if(this.mode == 'login') {
				this.sendLoginRequest();
			}
			if(this.mode == 'restorePassword') {
			event.preventDefault()

				//this.restorePassword();
			}
		},
		restorePassword() {
			$(".borderedCard").removeClass("formResized");
			$(".borderedCard").addClass("formResizedAutoHight");
			this.loginAsyncRequest.done = 'pending';
			this.$IGeneral.asyncRequest("__restorePassword", this.user, [
				response => {
					console.log(response);

					if (response) {
						this.loginAsyncRequest.message = response.message;
						this.loginAsyncRequest.done = response.type == 1 ? 'OK' : 'failed';
						this.loginAsyncRequest.status = response.type == 1 ? 'OK' : 'failed';
						// this.loginAsyncRequest.done = response.message;
						if (response.type == 1) {
							this.mode = "passswordSentToEmail";
						}
					}
				}
			]);

			// this.mode = "passswordSentToEmail";
		},
		resetToLoginForm() {
			this.mode = "login";
			this.cleanLoginAsyncRequest();
		},
		setLoginAsyncRequest(response) {
			this.loginAsyncRequest.done = 'OK';
			this.loginAsyncRequest.message = response.message;
			this.loginAsyncRequest.status =  response.type == 1 ? 'OK' : 'failed';
			console.log(response);
		},
		resetAsyncRequest(){
			this.mode = 'restorePassword'
			this.cleanLoginAsyncRequest();
		},
		cleanLoginAsyncRequest(){
			this.loginAsyncRequest.status = "";
			this.loginAsyncRequest.message = "";
			this.loginAsyncRequest.done = "";
		}
	},
	mounted() {
		console.log(this.$root.backGroundData);
	}
};
</script>

<style scoped >
.successMessage {
	color: green;
}

.errorMessage {
	color: red;
}
.autorBackground {
	border-radius: 50%;
	border: 4px solid #fff;
	margin: auto;
	/* background-image: url(/img/AppTemplate/Login/autorAvatar.jpg); */
	background-position: bottom;
	background-size: contain;
	height: 80px;
	width: 80px !important;
	background-position: center right !important;
    background-size: cover !important;
}
.borderedCard {
	border-radius: 16px;
}
.w-55 {
	width: 55%;
}
.formResized {
	width: 467px !important;
	height: 461px !important;
}
.formResizedAutoHight {
	width: 467px !important;
	height: auto !important;
}
.centerheight {
	height: calc(100vh) !important;
}

.cardtranspartent {
	background-color: transparent;
}
.form-control {
	border-color: #bac8ef;
}

.card-login-footer {
	padding-top: 25px;
	padding-bottom: 25px;
}
.loginbody {
	height: 100%;
	width: 100%;
	background-repeat: no-repeat;
	height: calc(100vh) !important;
	background-position: center right !important;
	background-size: cover !important;
}

.container {
	height: 100%;
	align-content: center;
}

.card {
	margin-top: auto;
	margin-bottom: auto;
	width: 400px;
}

.remember {
	color: #697cb1;
}

.login_btn {
	color: white;
	background-color: #0065cb;
	/* width: 100px; */
	font-weight: bold;
	font-size: 16px;
	padding-top: 12px;
	padding-bottom: 12px;
	padding-left: 50px;
	padding-right: 50px;
}

.login_btn:hover {
	color: white;
	background-color: rgb(29, 121, 212);
}
</style>