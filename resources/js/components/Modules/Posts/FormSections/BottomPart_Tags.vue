<template>
	<div style="width:47%" class="div-table-col row-card-white" id="tagsManager">
		<div class="tagsTitle mx-1 mt-2 mb-2 py-2">Etiquetas</div>

		<div :id="'groupId'+taggroup.tagGroupId" v-for="(taggroup, index) in tags" :key="'gtag_'+index" class="mx-2 mt-4 mb-2 py-1 px-4">
			<div class="row fs-12 subtagTitle py-1">
				<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-left">
					<span class="font-weight-bold">{{ taggroup.tagGroupName }}</span>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-6 col-xl-6 text-right">
					<a href="#" @click.prevent="selectEmAll('groupId'+taggroup.tagGroupId)">Seleccionar todas</a>
				</div>
			</div>

			<div class="mx-1 mt-2 mb-2">
				<div class="row fs-12">
					<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 text-center mt-2 form-inline px-0">
						<div
							v-for="(tag, sindex) in taggroup.tags"
							:key="'tag_'+sindex"
							class="form-check pr-2 pb-2"
							title
							v-tooltip="tag.tagName <= 0 ? 'Este etiqueta no puede ser asginada porque no tiene un nombre asignado, dirijase a la parametrizacion para asginar un nombre a esta etiqueta' : '' "
						>
							<input
								:disabled="tag.tagName <= 0 || form.asyncRequests.status == 1 "
								type="checkbox"
								class="form-check-input d-none inp-cbx"
								:id="'exampleCheck' + tag.tagId"
								v-model="form.tagsForm['groupId:'+taggroup.tagGroupId+'_tagId:'+tag.tagId]"
							>

							<label class="cbx pt-2" :for="'exampleCheck' + tag.tagId">
								<span>
									<svg width="12px" height="10px" viewbox="0 0 12 10">
										<polyline points="1.5 6 4.5 9 10.5 1"></polyline>
									</svg>
								</span>
							</label>


							<label class="form-check-label pl-1" :for="'exampleCheck' + tag.tagId">
								<span v-if="tag.tagName <= 0" >Sin nombre</span>
								<span v-else>{{tag.tagName}}</span>
							</label>
						</div>
						<div v-if=" taggroup.tags.length <= 0" class="form-check pr-2 pb-2">
							<span>No hay etiquetas agregadas para este grupo</span>
						</div>
					</div>
				</div>
			</div>
			<hr v-if="index < tags.length - 1 " class="mx-auto">
		</div>

	</div>
</template>

<script>
import { mapGetters, mapState } from 'vuex';
export default {
	name: 'bottompart-tags-form',
	computed: {
		...mapGetters({
			tags: 'posts/getTags',
			form: 'posts/getFormData',
		}),
	},
	methods: {
		selectEmAll(tagsGroup) {
			$('#' + tagsGroup).find('input:checkbox').each(function (index, element) {
				$(element).click();
				$(element).prop('checked',true);
			});
		}
	},
	mounted() {

	},


}
</script>

<style lang="scss" scoped>

.subtagTitle {
	background-color: #eeeeee;
	color: #797979;
	border-radius: 3px !important;
	border: 1px solid #dddddd;
}

hr {
	border: none;
    border-top: 1px dotted #c2c2c2;
    color: #fff;
    background-color: #fff;
    height: 1px;
    width: 470px;
    margin-bottom: 1px;
    left: -13px;
    position: relative;
    top: 8px;
}





.cbx {
	margin: auto;
	-webkit-user-select: none;
	user-select: none;
	cursor: pointer;
}
.cbx span {
	display: inline-block;
	vertical-align: middle;
	transform: translate3d(0, 0, 0);
}
.cbx span:first-child {
	position: relative;
	width: 18px;
	height: 18px;
	border-radius: 3px;
	transform: scale(1);
	vertical-align: middle;
	border: 1px solid rgb(221, 221, 221);
	transition: all 0.2s ease;
}
.cbx span:first-child svg {
	position: absolute;
	top: 3px;
	left: 2px;
	fill: none;
	stroke: #FFFFFF;
	stroke-width: 2;
	stroke-linecap: round;
	stroke-linejoin: round;
	stroke-dasharray: 16px;
	stroke-dashoffset: 16px;
	transition: all 0.3s ease;
	transition-delay: 0.1s;
	transform: translate3d(0, 0, 0);
}
.cbx span:first-child:before {
	content: "";
	width: 100%;
	height: 100%;
	background: #506EEC;
	display: block;
	transform: scale(0);
	opacity: 1;
	border-radius: 50%;
}
.cbx span:last-child {
	padding-left: 8px;
}
.cbx:hover span:first-child {
	border-color: #506EEC;
}

.inp-cbx:checked + .cbx span:first-child {
	background: #506EEC;
	border-color: #506EEC;
	animation: wave 0.4s ease;
}
.inp-cbx:checked + .cbx span:first-child svg {
	stroke-dashoffset: 0;
}
.inp-cbx:checked + .cbx span:first-child:before {
	transform: scale(3.5);
	opacity: 0;
	transition: all 0.6s ease;
}

@keyframes wave {
	50% {
		transform: scale(0.9);
	}
}



</style>