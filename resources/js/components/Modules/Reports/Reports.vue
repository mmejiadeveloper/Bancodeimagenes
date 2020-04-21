<template>
	<div REQUIRED-FOR-TEMPLATE="reports.reports">
		<CreateuserModal />
		<div class="row text-center centeredFrom1100 upperRow">

			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
				<BodyHeaderPart1
				 :mode="this.mode"
				 :actionData="actionData"
				/>

				<div>
					<div class="row row-card-white px-3">
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/downloadByResources.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Descargas por recurso
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/downloadByDepartments.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Descargas por usuario
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/downloadByDepartments.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Descargas por departamento
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/downloadByProyects.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Descargas por proyecto
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/downloadByProyects.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Descargas por creador
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/postsByCreator.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Recursos por creador
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/usersList.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Listado de usuarios
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
						<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 py-4">
                            <div class="borderReport mx-2" >
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-3">
                                    <img
                                    class="essaemplogo3row"
                                    src="/img/AppTemplate/Modules/Reports/creatorsList.png"
                                    alt
                                    >
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-4">
                                    <h3>
                                        Listado de creadores
                                    </h3>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
                                    <select
                                    class="form-control w-100"
                                    name=""
                                    id=""
                                    >
                                        <option>Rango por fecha</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-4 pb-3">
                                    <button type="button" class="btn btn-primary w-100">Generar informe</button>
                                </div>
                            </div>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>
</template>

<script>
	import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
	import CreateuserModal from "../../modules/modals/users/CreateUserModal";
	// import CreateuserModal from "../Modals/Users/CreateUserModal";
	export default {
		name: "reports",
		components: {
			BodyHeaderPart1,
			CreateuserModal
		},
		data() {
			return {
				filter: {
					enable: false
				},
				filters: {
					searchByText: ""
				},

				foundUsers: [{}],
				mode: "admin",
				actionData: {
					message: {
						title: "",
						bodyh1: "",
						bodysmall: ""
					},
					modalId: "createUserModal"
				}
			};
		},
		methods: {
			loadRowDataInModal() {
				$("#createUserModal").modal("show");
			}
		}
	};
</script>

<style lang="css" scoped>
	.row-card {
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		background: #f1f1f1;
	}
	.row-card-white {
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		background: #fff;
	}

	.list-card {
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		z-index: 3;
		background: white;
		border: 1px solid white;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	.list-card-filter {
		z-index: 3;
		background: #f1f1f1;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	.list-card-titles {
		z-index: 3;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}

	.list-card-titles table > thead {
		background: #cccccc;
		color: #a0a0a0;
		font-size: 11px;
	}

	.list-card-titles table > tbody {
		background: #fff;
		color: #000;
		font-size: 15px;
	}
	.list-card-titles table > tbody > tr:hover {
		background: rgb(255, 255, 218);
	}

	.list-card-paginator {
		z-index: 3;
		background: #fff;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		padding-top: 80px;
		padding-bottom: 80px;
	}

	.boxShadow {
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}

	.user-tag {
		font-size: 23px;
		font-weight: bold;
		color: #777575;
	}
	.user-tag-small {
		color: #777575;
	}

	.btn-dark {
		background-color: #474747;
		color: #fff;
	}

	.filterdiv {
		background-color: #c2c2c2;
	}

	.deteleRow {
		height: 26px;
		width: 26px;
		background-color: #979797;
		font-size: 12px;
		border-radius: 50%;
		padding-top: 3px;
		cursor: pointer;
	}

	.deteleRow:hover {
		background: #cccbcb;
	}

	.paginator-tag-text {
		color: #777575;
	}

	.upperRow {
		position: relative;
		top: -95px;
	}

	.tablegrayheader {
		background: #c5c5c5;
		font-size: 11px;
		color: #707070;
	}

	table > tbody > tr {
		cursor: pointer;
	}
	table > tbody > tr:hover {
		cursor: pointer;
		background-color: rgb(255, 255, 218);
    }

    .borderReport{
        border: 1px solid #c2c2c2;
        border-radius: 15px;
    }
</style>
