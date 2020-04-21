<template>
	<tr>
		<td @click="loadUserDataInModal">
			<img class="essaemplogo3row" :src="'/endUserFiles/usersAvatar/'+item.userAvatarFileName" alt @error="imgUrlAlt">
			<span class="pl-3" v-html="item.name" ></span>
		</td>
		<td class="align-middle">{{ item.departmentName }}</td>
		<td class="align-middle">{{ item.created_at }}</td>
		<td class="align-middle">{{ item.profileName }}</td>
		<td class="align-middle">{{ item.items }}</td>
		<td class="align-middle">{{ item.downloads }}</td>
		<td class="align-middle w-10per">
			<section title=".slideThree ">
				<div
					:class="( [ item.ckuserState ? ' slideThree-active ' : ' slideThree-inactive '] )+ ' slideThree  my-0' "
				>
					<input
						v-model="item.userState"
						type="checkbox"
						value="None"
						:id="'slideThree' + item.userId"
						name="check"
						@change="updateUserState"
						:disabled=" asyncRequestStatus == 'pending' "
					>
					<label :for="'slideThree' + item.userId"></label>
				</div>
			</section>
		</td>
	</tr>
</template>

<script>
export default {
	name: "user",
	props: {
		item: {
			type: Object,
		},
	},
	data() {
		return {
			asyncRequestStatus: ''
		}
	},
	methods: {
		updateUserState() {
			this.asyncRequestStatus = 'pending';
			this.$IGeneral.asyncRequest("users/__modifyUserState", this.item, [response => {
				this.asyncRequestStatus = 'OK';
				if (response) {
					this.$parent.initialize();
					if (response.type == 1) {
						this.$snotify.success('Ok. El estado del usuario ha sido actualizado.', {
							showProgressBar: false,
						});
					}
					else {
						this.$snotify.error('Algo salio mal, no se pudo actualizar el estado del usuario', {
							showProgressBar: false,
						});
					}
				}
			}]);
		},
		loadUserDataInModal(){
			$('#createUserModal').modal('show');
			//this.item.userState = this.item.userState ? 1: 0;
			this.$store.commit('createUserModal/setUserData', this.item);
			this.$store.commit('createUserModal/setFormMode', 'editUser');
		},
		imgUrlAlt(event) {
			event.target.src = "endUserFiles/usersAvatar/default.png"
		},
	},
}
</script>

<style lang="scss" scoped>
.essaemplogo3row {
	width: 45px;
	height: 45px;
	border: 1px solid #c2c2c2;
	border-radius: 50%;
}
</style>