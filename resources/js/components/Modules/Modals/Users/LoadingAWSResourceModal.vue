<template>
	<div REQUIRED-FOR-TEMPLATE="crudresultsusermodal" >
		<div
		 class="modal fade"
		 id="loadingAWS"
		 tabindex="-1"
		 role="dialog"
		 aria-labelledby="exampleModalCenterTitle"
		 aria-hidden="true"
		>
			<div
			 class="modal-dialog modal-dialog-centered recenter-to-480"
			 role="document"
			>
				<div class="modal-content ">
					<div class="modal-body pt-0">

						<div class="row bluegradient margin-title">
							<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center py-4 titleHeader">
								Un momento...
							</div>
						</div>

						<div class="row px-4 pt-4 text-left">
							<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center ">

								<div class="col-xs-12 col-md-12 col-lg-12 col-sm-12 text-center ">
									<img
									 src="/img/AppTemplate/Login/spinner.gif"
									 alt=""
									>
								</div>

								<h3>
									Estamos cargando tu recurso
								</h3>
								<p>
									Estar&aacute; disponible muy pronto para todos los usuarios.
								</p>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		name: "loadingAWSResource-modal",
	};
</script>

<style lang="scss" scoped>
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
		background-image: url(/img/AppTemplate/Header/aaaa.png);
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
		color: #585858;
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

	.titleHeader {
		font-weight: bold;
		font-size: 20px;
	}
	.margin-title {
		margin-top: 15px;
		margin-left: 0px;
		margin-right: 0px;
		border-radius: 10px;
	}
</style>