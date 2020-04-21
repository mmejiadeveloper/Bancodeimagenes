<template>
	<Waterfall :maxCol="4">
		<WaterfallItem
			:width="250"
			v-for="(item, index) in posts"
			:key="index"
			class="grid-item item animated fadeIn"
		>
			<img class :src="'endUserFiles/postFiles/'+item.miniImageUrl" alt>
		</WaterfallItem>
	</Waterfall>
</template>

<script>
export default {
	name: 'post-fotografo',
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
							this.$parent.getPosts(() => {
								this.$store.dispatch('paginator/setPaginatorConfiguration', { limit: 5 });
								this.$store.dispatch('paginator/setRowsData', this.$parent.posts);
							});
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
}

.post {
	cursor: pointer;
	// height: 200px;
	// padding-top: 2px;
}
</style>