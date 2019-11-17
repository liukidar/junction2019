<template>
	<div class="cmp-map" :style="{'padding-top': mapShift}" @mouseleave="highlightLayer(null)">
		<map-layer v-for="(el, index) in maplayers" :key="index" :highlighted="hoverLayer == index" :selected="activeLayer == index" :visible="activeLayer == index || activeLayer == null"
			:layer = index
			@click.native="selectLayer(index)"
			@mouseenter.native="highlightLayer(index)"
			@mouseleave.stop
			:style="{left: (60) + '%'}"></map-layer>
		<notification @close="select({})" @action="select({})" v-if="selected.id" :style="{left: selected.x + 40 + 'px', top: selected.y - 40 + 'px'}" class="cmp-selected-box"></notification>
	</div>
</template>

<script>

import MapLayer from './MapLayer'
import Notification from './Notification'
import { mapGetters, mapActions } from 'vuex'

export default {
	data: function() {
		return {
			activeLayer: null,
			hoverLayer: null
		}
	},
	computed: {
		...mapGetters('map', { maplayers: 'layers', selected: 'selected'}),
		mapShift() {
			return (12 - 9 * (2 - (this.hoverLayer == null ? 1.5 : this.hoverLayer))) + '%'
		}
	},
	methods: {
		...mapActions('map', ['select', 'updatePeople', 'pickOutlierBag']),
		selectLayer(_index) {
			if (this.activeLayer == _index) {
				this.activeLayer = null
			}
			else {
				this.activeLayer = _index
			}
			this.select({})
		},
		highlightLayer(_index) {
			if (this.hoverLayer != _index) {
				this.select({})
			}
			if (this.activeLayer == null) this.hoverLayer = _index
		},
		update() {
			this.updatePeople().then(() => {
				setTimeout(this.update, 300)
			})	
		}
	},
	mounted() {
		this.update()
	},
	components: {
		MapLayer, Notification
	}
}
</script>

<style scoped>

.cmp-map {
	position: relative;
	transition: .5s;
	float: left;
	width: 1300px;
	height: 100%;
	display: flex;
	flex-flow: column-reverse;
}


.cmp-selected-box {
	position: fixed;
	z-index: 999;
}

.fade-enter-active, .fade-leave-active {
  transition: .5s;
}
.fade-enter, .fade-leave-to {
  transform: translate(40px, -50%) scale(0%)  !important;
}

</style>