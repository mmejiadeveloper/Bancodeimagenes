<template>
	<div REQUIRED-FOR-TEMPLATE="footer">
		<div class="footer-part1 py-5">
			<div class="row centeredFrom1100">
				<div class="col-sm-5 col-md-5 col-lg-5 col-xl-5 text-left px-0">
					<div class="row">
						<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
							<img class="essaemplogo1left" src="/img/AppTemplate/Header/essaemplogo1.png" alt>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 pt-5">
							<p>
								El banco de ima&aacute;genes de la organizaci&oacute;n ESSA GRUPO EPM, es un
								repositorio con las ima&aacute;genes aprobadas por la organizaci&oacute;n y que
								pueden ser usadas para los diferentes proyectos dentro de la empresa.
								De ninguna manera estas imagenes puede ser usadas en proyectos
								diferentes.
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
				<div class="col-sm-5 col-md-5 col-lg-5 col-xl-5 px-0">
					<div class="row">
						<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6"></div>
						<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6">
							<table class="table table-sm borderless categories-table-footer">
								<thead>
									<tr>
										<th class="pb-3" colspan="2">CATEGOR&Iacute;AS</th>
									</tr>
								</thead>
								<tbody >
									<tr :key="index" v-for="(category, index) in categories.slice(0, 5)">
										<td class="w-75">{{ category.categoryName }}</td>
										<td>
											<div>{{ category.numberOfPosts }}</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<hr>
										</td>
									</tr>
									<tr v-if="categories.length <= 0">
										<td colspan="2" >
											No se encontraron categorias existentes.
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="footer-part2 py-3">
			<div class="row centeredFrom1200">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-left">
					Copyright 2019 @
					<b>ESSA EPM</b> | Todos los derechos reservados
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
	name: 'app-footer',
	mounted() {
		//this.categories = this.$root.$refs.dashboard.$refs.appheader.bd_categorias;
	},
	computed: {
		...mapGetters({
			categories: "header/getCategories",
			totalNumberOfPosts: "header/getTotalNumberOfPosts",
			searchInfomation: "header/getSearchInformationObject"
		}),
	},
}
</script>

<style lang="css" scoped>
.footer-part1 {
	background-color: #1f1f1f;
	color: #fff;
}
.footer-part2 {
	background-color: #000;
	border-top: 1px solid #3d3d3d;
	color: #fff;
	font-size: 13px;
}

p {
	font-size: 12px;
}

.essaemplogo1left {
	width: 180px;
}

.borderless td,
.borderless th {
	border: none;
}

.categories-table-footer td {
	color: #fff;
	font-size: 10px;
}

.categories-table-footer th {
	color: #777777;
	font-size: 13px;
}

.categories-table-footer hr {
	margin-top: 0px;
	border-top: 1px solid #c2c2c2;
}

.categories-table-footer tbody > tr > td:nth-of-type(2n + 0) div {
	background: #000;
	color: #c2c2c2;
	font-size: 8px;
	padding: 3px;
	text-align: center;
	font-weight: bold;
	border-radius: 5px;
}

table > tbody > tr:hover{
	background: transparent;
}
</style>