<template>
	<div class="row py-3 px-3 mt-2  list-card-paginator  row-card-white" v-if="rowsLength > 0">
		<!-- <div :class="'row ' + styleClasses"> -->
		<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2 text-left">
			<span class="paginator-tag-text">
				<a @click.prevent="$store.dispatch('paginator/paginatorPrevious')" :href="pagex!=1">ANTERIOR</a>
			</span>
		</div>
		<div class="col-sm-8 col-md-8 col-lg-8 col-xl-8 text-center">
			<span class>
				<div
					@click.prevent="$store.dispatch('paginator/goToPage', n )"
					v-for="n in numberOfPages"
					:key="n+'--page'"
					class="d-inline-block pag-item mx-2"
				>
					<a href="#" class>{{ n }}</a>
				</div>
			</span>
		</div>
		<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2 text-right">
			<span class="paginator-tag-text">
				<a
					@click.prevent="$store.dispatch('paginator/paginatorNext')"
					:href="(pagex*limit)/(rowsLength) < 1  "
				>SIGUIENTE</a>
			</span>
		</div>
	</div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from 'vuex';
export default {
	name: 'IPaginator',
	computed: mapGetters({
		limit: 'paginator/getLimitOfRows',
		pagex: 'paginator/getPage',
		rowsLength: 'paginator/getRowsLength',
		numberOfPages: 'paginator/getNumberOfPages',
	})

}
</script>

<style lang="scss" >
.pag-item {
	width: 30px;
	height: 30px;
	border-radius: 15px;
	position: relative;
	top: 2px;
	color: #fff;
}
.pag-item:hover {
	width: 30px;
	background: #0065cb;
	height: 30px;
	border-radius: 15px;
	color: #fff;
}
.pag-item-active {
	width: 30px;
	background: #0065cb;
	height: 30px;
	border-radius: 15px;
	color: #fff;
}
.pag-item > a:hover {
	color: #fff;
	position: relative;
	top: 2px;
}
a {
	width: 30px;
	height: 30px;
}
</style>