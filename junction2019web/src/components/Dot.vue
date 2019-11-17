<template>
	<div @click.stop="(e) => select({x: e.clientX, y: e.clientY, id: el.id })" class="cmp-dot" :class="{overcrowded: el.status == 2, outlier: el.status == 1, selected: isSelected.id == el.id }"
			:style="{left: el.x / 74.08 + '%', top: el.y / 52.08 + '%'}"></div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
	props: ['el'],
	computed: {
		...mapGetters('map', { isSelected: 'selected' })
	},
	methods: {
		...mapActions('map', ['select'])
	}
}
</script>

<style scoped>

.cmp-dot {
	position: absolute;
	display: inline-block;
	width: 15px;
	height: 15px;
	border-radius: 100%;
	opacity: .5;
	background: white;
	box-shadow: 0 0 3px grey;
	transition: .5s;
	transform-origin: 50% 50%;
}

.cmp-dot.outlier {
	opacity: .7;
	background: red;
	box-shadow: 0 0 3px red;
  animation: pulse 2s infinite;
	z-index: 1;
	position: absolute;
}

.cmp-dot.overcrowded {
	opacity: .7;
	background: #FFDC14;
	box-shadow: 0 0 3px #FFDC14;
  animation: pulse-small 2s infinite;
	z-index: 1;
	position: absolute;
}

.cmp-dot.selected {
	opacity: .8;
	transform: scale(1.6);
}

@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 rgba(255,0,0, 0.9);
  }
  70% {
      box-shadow: 0 0 0 16px rgba(255,255,0, 0);
  }
  100% {
      box-shadow: 0 0 0 0 rgba(255,0,0, 0);
  }
}

@keyframes pulse-small {
  0% {
    box-shadow: 0 0 0 0 rgb(255, 220, 20, 0.4);
  }
  70% {
      box-shadow: 0 0 0 6px rgb(255, 220, 20, 0.4);
  }
  100% {
      box-shadow: 0 0 0 0 rgba(0,0,0, 0);
  }
}

</style>