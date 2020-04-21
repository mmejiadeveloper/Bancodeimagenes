<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Document</title>
</head>

<body>
	<table style="width:100%" bgcolor="#ffffff">
		<tbody>
			<tr>
				<td>
					<img src="{{ $message->embed('public/img/AppTemplate/login/emailheader.jpg') }}" alt="" style="width:100%">
				</td>
			</tr>
			<tr>
				<td color="black">
					<div style="margin-right: 115px; margin-left: 115px; border-left: 1px solid #dcdcdc; border-right: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc; box-shadow: -3px 0px 5px rgba(0, 0, 0, 0.19), 3px 0px 5px rgba(0, 0, 0, 0.19); border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
						<table style="width:100%; ">
							<tbody>
								<tr>
									<td>
										<div style="padding-left:45px;padding-right:45px;">
											<h2 style="margin-top:0px">
												Hola {{ $name }}
											</h2>
										</div>
									</td>
								</tr>

								<tr>
									<td color="black">
										<div style="padding-left:85px;padding-right:85px;">
											<span>
												Has solicitado recordar tu contraseña de acceso al <b>Banco de Imágenes ESSA</b>, a partir de este momento podrás acceder utilizando esta clave temporal que te enviamos.
											</span>
											<br>
											<br>
											<span>
												Estos son tus datos de acceso.
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td color="black">
										<br>
									</td>
								</tr>
								<tr style=" ">
									<td color="black">
										<div style="border: 1px solid rgb(204,221,232)!important;;
											margin-left: 5px;
											margin-right: 5px;
											border-radius: 8px;">
											<div style="background-color: rgb(204, 221, 232) !important; padding:1px ">
												<div style="padding-left:40px;padding-right:40px;background-color: rgb(204, 221, 232) !important;">

													<table style="width:100%">
														<tbody>
															<tr>
																<td>
																	<h2>
																		Tus datos de acceso
																	</h2>
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	<span>Estos son los datos que necesitas para poder acceder a la aplicación, recuerda que
																		puedes modificarlos una vez ingreses.</span>
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	&nbsp;
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	<div style="margin-left:auto; margin-right:auto; width:50%; text-align:center;font-size: 15px;">
																		<span>Correo electr&oacute;nico</span>
																	</div>
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	<div style="margin-left:auto; margin-right:auto; width:50%; text-align:center; background-color:#ffffff; font-size: 15px; padding-top: 10px; padding-bottom: 10px; border: 1px solid #c2c2c2; border-radius: 5px">
																		<span> {{$email}} </span>
																	</div>
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	<div style="margin-left:auto; margin-right:auto; width:50%; text-align:center;font-size: 15px;">
																		<span>Contrase&ntilde;a</span>
																	</div>
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	<div style="margin-left:auto; margin-right:auto; width:50%; text-align:center; background-color:#ffffff; font-size: 15px; padding-top: 10px; padding-bottom: 10px; border: 1px solid #c2c2c2; border-radius: 5px">
																		<span>{{$password}}</span>
																	</div>
																</td>
															</tr>
															<tr>
																<td style="padding-left:20px;padding-right:20px;">
																	<br>
																	<br>
																	<br>
																</td>
															</tr>
														</tbody>
													</table>


												</div>
											</div>
										</div>

									</td>
								</tr>
								<tr>
									<td color="black">
										<div style="padding-left:110px;padding-right:110px; text-align:center; padding-top:20px;">
											<span>
												Haz clic en el botón a continuación para acceder al banco de imágenes
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td color="black">
										<div style="padding-left:110px;padding-right:110px; text-align:center; padding-top:20px;">
											<!-- <div class="btn">
												<a href="http://desarrollo.bancoimagenes.com/login">Ingresar</a></div> -->

											<div style="text-align:center;margin-left:5px;margin-right:5px;">
												<a href="http://desarrollo.bancoimagenes.com/login">
													<img src="{{ $message->embed('public/img/AppTemplate/login/ingresaremail.png') }}" alt="">
												</a>
											</div>

										</div>
									</td>
								</tr>
								<tr>
									<td color="black">
										<br>
										<br>
										<br>
									</td>
								</tr>
								<tr>
									<td style="padding-bottom:5px;">
										<div style="text-align:center;margin-left:5px;margin-right:5px;background-color:#363636">
											<img src="{{ $message->embed('public/img/AppTemplate/login/emailogo.png') }}" alt="">
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</td>
			</tr>

		</tbody>
	</table>
</body>

</html>

<style>
	.btn {
		color: rgb(255, 255, 255);
		background-image: linear-gradient(#0065CB, #002965);
		width: 35%;
		margin-left: auto;
		margin-right: auto;
		height: 30px;
		padding-top: 6px;
		border-radius: 3px;
	}

	.btn a {
		color: rgb(255, 255, 255);
		text-decoration: none;
	}
</style>