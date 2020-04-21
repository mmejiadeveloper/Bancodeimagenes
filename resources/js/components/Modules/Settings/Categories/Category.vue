<template>
	<table class="categoryShadow table table-sm table-borderless w-100 backg-color-white m-0 py-2">
		<tbody>
			<tr>
				<td class="py-3 px-3">
					<div
						@click="$parent.makeEditable(category,'id_sections_category__' + index)"
						:class=" ([ !category.options.editable ? '  ' : ' py-0  ' ]) + 'border-category' "
					>
						<span v-if="!category.options.editable ">{{category.categoryName}}</span>
						<input
							style="height:43px; "
							:id="'id_sections_category__' + index"
							@blur="$parent.editCategory(category)"
							v-else
							v-model="category.categoryName"
							type="text"
							class="form-control input-yellow-backg-color"
							aria-describedby="helpId"
							placeholder
						>
					</div>
				</td>
				<td
					v-if="category.options.editable == false && sections.categories.mode == 'list'"
					class="py-3 px-0"
				>
					<span style="cursor:pointer;" v-if="!category.options.hasDependecies" @click="$parent.deleteCategory(category)">
						<i class="fas fa-trash mt-12px color-red1"></i>
					</span>
				</td>
			</tr>
		</tbody>
	</table>
</template>

<script>

export default {
	name: 'category',

    props: {
		category: {
			type: Object,
        },
        sections: {
            type: Object,
        },
        index: {
            type: Number,
        }
    },
}
</script>

<style lang="scss" scoped>
</style>