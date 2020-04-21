<template>
	<div REQUIRED-FOR-TEMPLATE="users.admin">
		<div class="row text-center centeredFrom1100 upperRow">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
				<BodyHeaderPart1 :mode="this.mode" :actionData="actionData"/>

				<div class="row py-3 px-3 row-card-admin-noshadow ">
					<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-left">
						<span v-if="filters.searchByText.length <= 0" class="user-tag">Listado de usuarios</span>
						<span v-else class="user-tag">Has buscado : {{ filters.searchByText }}</span>
					</div>
					<div class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-left form-inline">
						<small class="px-2">Filtrar usuarios</small>
						<select @change="filterUser('type')" v-model="filters.profileId" class="form-control w-50">
							<option value>Tipo de usuario:</option>
							<option
								v-for="(type, index) in usersTypes"
								:key="'type_'+index"
								:value="type.profileId"
							>{{ type.profileName }}</option>
						</select>
					</div>
					<div
						class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-left form-inline"
						v-if="  filters.profileId != 1 "
					>
						<small class="px-2">Acciones lote</small>
						<select
							@change="filterUser('department')"
							v-model="filters.userDepartmentId"
							class="form-control"
							style="width:70%"
						>
							<option value>Seleccionar acci&oacute;n</option>
							<option
								v-for="(userDep, index) in usersDepartments"
								:key="'type_'+index"
								:value="userDep.userDepartmentId"
							>{{ userDep.departmentName }}</option>
						</select>
					</div>
				</div>

				<div v-if="users.length > 0">
					<div class="row row-card-white">
						<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 px-0">
							<table class="table w-10 borderless mb-0">
								<thead class="tablegrayheader">
									<tr>
										<th>USUARIO</th>
										<th>DEPARTAMENTO</th>
										<th>FECHA CREACI&Oacute;N</th>
										<th>TIPO</th>
										<th>ITEMS</th>
										<th>DESCARGAS</th>
										<th>ESTADO {{ $store.getters.getPage }}</th>
									</tr>
								</thead>
								<tbody>
									<User
										v-show="( page - 1 ) * limit <= index && page * limit > index"
										v-for="( user, index ) in users "
										:key="'user_' + index"
										:item="user"
									/>
								</tbody>
							</table>
						</div>
					</div>
					<IPaginator/>
				</div>

				<div v-else class="row row-card-white pb-5">
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3">
						<img class src="/img/AppTemplate/Modules/Posts/notfound.png" alt>
					</div>
					<div
						class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center pb-3"
					>La búsqueda que realizaste no arrojó ningún resultado, aprovecha esta oportunidad para subir un nuevo recurso teniendo en cuenta esta búsqueda.</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
import CreateuserModal from "../../modules/modals/users/CreateUserModal";
import IPaginator from "../../Internal/_IPaginator";
import User from "./User";
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
// import CreateuserModal from "../Modals/Users/CreateUserModal";
export default {
	name: "users-admin",
	components: {
		BodyHeaderPart1,
		CreateuserModal,
		IPaginator,
		User,
	},
	data() {
		return {
			filter: {
				enable: false
			},
			filters: {
				searchByText: "",
				profileId: '',
				userDepartmentId: '',
				param: ''
			},

			mode: "admin",
			actionData: {
				message: {
					title: "",
					bodyh1: "",
					bodysmall: ""
				},
				modalId: "createUserModal",
				view: {
					id: 'users',
					functions: {
						createUser: () => {
							$('#createUserModal').modal('show');
							this.$store.commit('createUserModal/resetFormUserData');
							this.$store.commit('createUserModal/setFormMode', 'newUser');
						}
					}
				}
			},
		};
	},

	methods: {
		...mapActions({
			getUsers: 'users/getAllUsers',
			initialize() {
				//window.scrollTo(0, 0);
				this.getUsers(() => {
					this.$store.dispatch('paginator/setPaginatorConfiguration', { limit: 25 });
					this.$store.dispatch('paginator/setRowsData', this.users);
					console.log(this.limit, this.$store.users);
				});
				this.$store.dispatch('users/loadUsersTypes', this.users);
				this.$store.dispatch('users/loadUserDepartments');
			},
		}),
		filterUser(param) {
			this.filters.param = param;
			console.log(this.filters)
			this.$IGeneral.asyncRequest("users/__filterUsers", this.filters, [response => {
				if (response) {
					if (response.type == 1) {
						this.$store.commit('users/setUsers', response.data);
					}
				}
			}]);
		}
	},
	computed: mapGetters({
		limit: 'paginator/getLimitOfRows',
		page: 'paginator/getPage',
		users: 'users/getUsers',
		usersTypes: 'users/getUsersTypes',
		usersDepartments: 'users/getUsersDepartments',
	}),

	created() {
		this.initialize();
	},
	watch: {
		$route(to, from) {
			if(to.name == 'adminusers') {
				this.initialize();
			}

		}
	}


};
</script>

<style lang="css" >

.row-card-admin-noshadow {
	box-shadow: none;
	background: #f1f1f1;
	border-radius: 0%;
}


.paginator-tag-text {
	color: #777575;
}

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

.essaemplogo3row{
    width: 45px;
    border: 1px solid #c2c2c2;
    border-radius: 50%;
    height: 45px;
}
</style>
