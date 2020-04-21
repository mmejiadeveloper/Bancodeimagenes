<template>
	<div class="row row-card-white p-3">
		<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
			<div class="row">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3 text-left table-header">
					<i class="fas fa-newspaper mx-2"></i> Tabla de tipos de usuarios
				</div>
			</div>

			<div class="row py-3 px-3 usertypes-backgroundcolor">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center">
					<div class="row">
						<div
							v-for="(user, index) in userProfiles"
							:key="index"
							class="col-sm-4 col-md-4 col-lg-4 col-xl-4 text-center py-4"
						>
							<table
								class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0 py-2"
							>
								<tbody>
									<tr>
										<td class="py-3 px-3">
											<div
												@click="user.options.editable = true"
												:class=" ([ !user.options.editable ? '  ' : ' py-0  ' ]) + 'border-category' "
											>
												<span v-if="!user.options.editable">{{user.profileName}}</span>
												<input
													style="height:43px; "

													v-else
													v-model="user.profileName"
													type="text"
													class="form-control input-yellow-backg-color"
													aria-describedby="helpId"
													placeholder
												>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row row-card-darkgray py-4 usertypes-row-card-darkgray">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center">
					<button :disabled=" updateUserTypesAysncRequestStatus == 'pending' || itemsPendingToBeUpdated.length <= 0 " @click="updateUserTypes" type="button" class="btn btn-success px-2 w-25">
						<i class="fas fa-save"></i> Guardar
					</button>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: 'settings-users-types',

	props: {
		sections: {
			type: Object,
		},
    },

    data() {
        return {
            userProfiles: [],
			updateUserTypesAysncRequestStatus: ''
        }
    },

	methods: {
		loadUserProfiles() {
			this.$IGeneral.asyncRequest("usersTypes/__loadUserProfiles", null, [response => {
				if (response) {
					if (response.type == 1) {
						this.userProfiles = response.userProfiles;
					}
				}
			}]);
		},
		updateUserTypes(){
			this.updateUserTypesAysncRequestStatus = 'pending';
			this.$IGeneral.asyncRequest("usersTypes/__modifyUserProfiles", this.userProfiles, [response => {
				if (response) {
					if (response.type == 1) {
						this.updateUserTypesAysncRequestStatus = 'OK';
						this.switchBackToReadOnly();
						this.$snotify.success('Ok. La informacion se ha actualizado.',{
							showProgressBar: false,
						});
					}
					else{
						this.$snotify.error('Algo salio mal, no se pudo actualizar la informacion',{
							showProgressBar: false,
						});
					}
				}
			}]);
		},
		switchBackToReadOnly(){
			this.userProfiles.forEach(userProfile => {
				userProfile.options.editable = false;
			});
		},
	},
	mounted () {
		this.loadUserProfiles();
	},
	computed: {
		itemsPendingToBeUpdated() {
			return (
				$.grep(this.userProfiles, function (userProfile) {
					return userProfile.options.editable == true ;
				})
			);
		}
	},
}
</script>

<style lang="scss" scoped>
.usertypes-backgroundcolor{
	background: #DBDBED !important;
}

.usertypes-row-card-darkgray {
    background-color: #d5d5e4;
    box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}
</style>