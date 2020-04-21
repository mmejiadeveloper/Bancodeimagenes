<template>
	<div REQUIRED-FOR-TEMPLATE="bodyheaderpart1">
		<CreateuserModal ref="createUserModal"/>
		<CrudresultsUsermodal :actionData="actionData"/>

		<div v-if="loggedUser.profileId != 3" class="row pt-38px px-3 row-card-top pb-4">
			<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
				<div>
					<span class="user-tag">{{ loggedUser.name }}</span>
				</div>
				<div>
					<span v-if="loggedUser.profileId == 2" class="user-tag-small">
						<small>Usted tiene {{posts.length}} recursos.</small>
					</span>
					<div v-if="loggedUser.profileId == 1" class="user-tag-small">
						<small>Se encontraron {{posts.length}} recursos.</small>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right" v-if="actionData">
				<button
					@click="actionData.view.functions.createPost"
					v-if="actionData.view.id == 'posts' "
					type="button"
					class="btn btn-success px-4"
				> <b class="fs-12">Crear nuevo recurso</b></button>
				<button
					@click="actionData.view.functions.createUser"
					v-if="actionData.view.id == 'users' "
					type="button"
					class="btn btn-success px-4"
				><i class="fas fa-user  mx-2  "></i> <b class="fs-12">Crear nuevo usuario</b>  </button>
				
				<button
					@click="actionData.view.functions.cancel"
					v-if="actionData.view.id == 'createPost' "
					type="button"
					class="btn btn-light px-4"
				>
					<b class="fs-12">Regresar</b> 
				</button>

				<button
					@click="actionData.view.functions.savePost"
					v-if="actionData.view.id == 'createPost' "
					type="button"
					class="btn btn-success px-4"
				>
					<i class="fas fa-save"></i> <b class="fs-12">Guardar recurso</b> 
				</button>
			</div>
		</div>
	</div>
</template>

<script>
import CreateuserModal from "../../modules/modals/users/CreateUserModal";
import CrudresultsUsermodal from "../../modules/modals/users/CrudResultsUserModal";
import { mapGetters } from 'vuex'
export default {
	name: "body-header-part1",
	methods: {
		show() {
			if (this.actionData) {
				$("#" + this.actionData.modalId).modal("show");
			}
		},

	},
	components: {
		CreateuserModal,
		CrudresultsUsermodal,
	},
	props: {
		actionData: {
			type: Object,
		},
		mode: {
			type: String,
		},

	},
	computed: {
		...mapGetters({
			posts: 'posts/getPosts',
			loggedUser: 'createUserModal/getLoggedUser',

		})
	},
};
</script>

<style lang="scss" scoped>
.row-card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	background: white;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border: 1px solid white;
	z-index: 3;
}

.list-card {
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	z-index: 3;
	background: white;
	border: 1px solid white;
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

.user-tag-nobold{
	font-size: 20px;
    color: #777575;
}
</style>