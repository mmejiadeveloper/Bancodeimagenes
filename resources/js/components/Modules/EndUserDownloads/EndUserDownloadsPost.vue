<template>
	<tr @click="loadPost(item)">
		<td class="text-center py-3">
			<img class="essaemplogo3row" :src="'endUserFiles/postFiles/'+item.miniImageUrl" alt>
		</td>
		<td class="align-middle text-left">
			{{ item.postName }}
			<p>
				<b>ES{{ item.postId }}</b>
			</p>
		</td>
		<td class="align-middle text-center">{{ item.postTypeName }}</td>
		<td class="align-middle text-center">{{ projectName }}</td>
		<td class="align-middle w-10per text-center">{{item.created_at}}</td>
	</tr>
</template>

<script>
export default {
	name: 'end-user-downloads-post',
	data() {
		return {
			asyncRequestStatus: ''
		}
	},
	props: {
		item: {
			type: Object
		},
		projectName: {
			type: String
		}
	},
	methods: {
		loadPost(item) {
			this.$router.push({ path: 'checkOutPost', query: { postId: item.postId } });
			item.cerrarModal = true;
			this.$store.dispatch('posts/openModalDetail', item, true)
		},
		
	},
}
</script>

<style lang="scss" >
.essaemplogo3row {
	width: 100px;
	height: 100px;
	border-radius: 0%;
	border: 1px solid transparent;
}

/* tr:nth-child(even) {
	background-color: #e6e6e6;
} */
</style>