<template>
	<div REQUIRED-FOR-TEMPLATE="settings.tags.taggroup.tag" class="tag p-2 d-inherit form-check">
		<input
			v-model="tag.options.checked"
			v-if="!tag.options.editable && !tag.options.hasDependecies"
			type="checkbox"
			class="form-check-input d-none inp-cbx"
			:key="'ck_' + tag.tagId + '_tag_index_' + index "
			:id="'ck_' + tag.tagId + '_tag_index_' + index "
		>
		<label v-if="!tag.options.editable" class="cbx" :for="'ck_' + tag.tagId + '_tag_index_' + index ">
			<span>
				<svg width="12px" height="10px" viewbox="0 0 12 10">
					<polyline points="1.5 6 4.5 9 10.5 1"></polyline>
				</svg>
			</span>
		</label>
		<label
			@click="setEditable"
			v-if="!tag.options.editable"
			class="form-check-label cpointer pl-2"
			:for="'ck_' + tag.tagId + '_tag_index_' + index "
			v-tooltip="tag.options.hasDependecies ? 'Este etiqueta no puede ser borrada porque tiene recursos asginados' : '' "
		>
			<span v-if="tag.tagName.length > 0">{{ tag.tagName }}</span>
			<span v-else style="color:red">Sin nombre</span>
		</label>
		<input
			v-if="tag.options.editable"
			:id="'id_sections_tag__' + index"
			v-model="tag.tagName"
			type="text"
			class="form-control form-control-sm input-yellow-backg-color w-100 small-input"
			aria-describedby="helpId"
			@blur="modifyTag"
			v-on:keyup.enter="$parent.$parent.save"
		>
	</div>
</template>

<script>
export default {
	name: 'tag',
	props: {
		tag: {
			type: Object,
		},
		index: {
			type: Number,
		}
	},
	methods: {
		modifyTag() {
			console.log(this.tag);
			if (this.tag.tagId != 'localItem') {
				this.$IGeneral.asyncRequest("tags/__modifyTags", this.tag, [response => {
					if (response) {
						if (response.type == 1) {
							this.tag.options.editable = false;
							this.$parent.actionGroup = 'list';
							this.$snotify.success('Ok. El nombre de la etiqueta ha sido actualizado.', {
								showProgressBar: false,
							});
						}
						else {
							this.$snotify.error('Algo salio mal, no se pudo actualizar el nombre de la etiqueta', {
								showProgressBar: false,
							});
						}
					}
				}]);
			}
		},
		setEditable() {
			this.tag.options.editable = !this.tag.options.editable;
			this.$parent.actionGroup = 'delete';
		}
	},
}
</script>

<style lang="scss" >
.d-inherit {
	display: inherit;
}
.small-input {
	height: 24px !important;
	font-size: 15px !important;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}
.tag {
	border-radius: 6px;
	color: black;
	background: transparent;
}


.cpointer {
	cursor: pointer;
}

.tooltip {
	&[aria-hidden="true"] {
		visibility: hidden;
		opacity: 0;
		transition: opacity 0.15s, visibility 0.15s;
	}

	&[aria-hidden="false"] {
		visibility: visible;
		opacity: 1;
		transition: opacity 0.15s;
	}

	/*Your styles.*/

	display: block !important;
	z-index: 10000;
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
	border: 1px solid #9098A9;
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