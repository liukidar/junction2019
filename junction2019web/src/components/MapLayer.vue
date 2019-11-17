<template>
	<div class="cmp-map-layer" :class="{highlighted, selected, visible}">
		<div class="cmp-bkg" :style="{'background-image': 'url(floor' + layer + '.png)'}"></div>
		<div class="cmp-body">
			<div class="cmp-number">{{layer}}°</div>
			<transition-group name="fade">
				<dot v-for="(el) in people" :key="el.id" :el="el">
				</dot>
			</transition-group>
			<transition-group name="fade">
				<square v-for="(el) in luggage" :key="el.id" :el="el">
				</square>
			</transition-group>
		</div>
	</div>
</template>

<script>

import Dot from './Dot'
import Square from './Square'

export default {
	props: ['layer', 'highlighted', 'selected', 'visible'],
	computed: {
		people: function() {
			return this.$store.getters['map/people'](this.layer)
		},
		luggage: function() {
			return this.$store.getters['map/luggage'](this.layer)
		},
		rooms: function() {
			return this.$store.getters['map/rooms'][this.layer]
		}
	},
	components: {
		Dot, Square
	}
}
</script>

<style scoped>

.cmp-map-layer {
	background: radial-gradient(closest-side at 50% 50%, #611A67 0%, #4D0C53 100%);
	width: 850px; 
	height: 600px;
	transform: rotateX(-60deg) rotateY(0) rotateZ(-45deg) translateY(-50%);
	margin-top: -30%;
	box-shadow:0 0 5px rgba(0, 0, 0, 0.5);
	opacity: 0.25;
	transition: .5s;
	position: relative;
	overflow: hidden;
	border-radius: 36px;
}

.cmp-map-layer.highlighted {
	opacity: 0.8;
	transform: scale(1.2) rotateX(-60deg) rotateY(0) rotateZ(-45deg) translateY(-50%);
	margin-top: -20%;
	margin-bottom: 10%;
	z-index: 1;
}

.cmp-map-layer:not(.visible) {
	opacity: 0;
	transform: scale(0) rotateX(-60deg) rotateY(0) rotateZ(-45deg) translateY(-50%) !important;
}

.cmp-map-layer.selected {
	z-index: 1;
	opacity: 1;
	transform: scale(1.5) translateX(8%) rotateX(-60deg) rotateY(0) rotateZ(-45deg) translateY(-50%) !important;
}
.cmp-bkg {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
	opacity: .6;
}

.cmp-body {
	width: 100%;
	height: 100%;
	position: relative;
}

.cmp-number {
	color: #FFF;
	font-size: 48px;
	position: absolute;
	top: 32px;
	right: 48px;
}

.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}

</style>