<template>
	<tr>
		<td>
			<img class="essaemplogo3row" :src="'endUserFiles/postFiles/'+item.miniImageUrl" alt>
		</td>
		<td class="align-middle text-left" @click="loadPost">
			<b v-html="item.postName"></b>
			<p v-html="'ES'+item.postId">
			</p>
		</td>
		<td class="align-middle"> <span class="fs-13" v-html="item.postTypeName"></span></td>
		<td class="align-middle"> <span class="fs-13" v-html="item.userName"></span> </td>
		<td class="align-middle w-10per">
			<table class="table table-sm table-borderless">
				<tbody>
					<tr>
						<td>
							<section title=".slideThree ">
								<div
									:class="( [ item.postState ? ' slideThree-active ' : ' slideThree-inactive '] )+ ' slideThree  my-0' "
								>
									<input
										v-model="item.postState"
										type="checkbox"
										value="None"
										:id="'sslideThree' + item.postId"
										name="check"
										@click="updatePostState"
										:disabled=" asyncRequestStatus == 'pending' "
									>
									<label :for="'sslideThree' + item.postId"></label>
								</div>
							</section>
						</td>
						<td>
							<div class="deteleRow" @click="deleteRowx">
								<i class="fas fa-trash"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</template>

<script>
export default {
	name: 'post',
	data() {
		return {
			asyncRequestStatus: ''
		}
	},
	props: {
		item: {
			type: Object
		},
	},
	methods: {
		deleteRowx() {
			this.$IGeneral.vue_swal_confirmacion("Esta seguro que desea eliminar este registro ?", 'Importante', () => {
				this.asyncRequestStatus = 'pending';
				this.$IGeneral.asyncRequest("posts/__removePost", this.item, [response => {
					this.asyncRequestStatus = 'OK';
					if (response) {
						if (response.type == 1) {
							this.$parent.initialize();
							this.$snotify.success('Ok. El recurso ha sido eliminado.', {
								showProgressBar: false,
							});
						}
						else {
							this.$snotify.error('Algo salio mal, no se pudo eliminar el recurso', {
								showProgressBar: false,
							});
						}
					}
				}]);
			});
		},
		updatePostState() {
			// alert('update');
			console.log(1, this.item);

			this.asyncRequestStatus = 'pending';
			this.$IGeneral.asyncRequest("posts/__modifyPostState", this.item, [response => {
				this.asyncRequestStatus = 'OK';
				if (response) {
					console.log(2, this.item);
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
		loadPost() {
			this.$router.push({ path: 'updatePost', query: { postId: this.item.postId } })
			// this.loadPostData();
		}
	},
}
</script>

<style lang="scss" scoped>
.essaemplogo3row {
	width: 100px;
	height: 100px;
}
</style>