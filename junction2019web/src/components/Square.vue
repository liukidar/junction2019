<template>
	<div @click.stop class="cmp-square" :class="{outlier: el.status == 1, selected: isSelected.id == el.id }"
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

.cmp-square {
	position: absolute;
	display: inline-block;
	width: 15px;
	height: 15px;
	opacity: .6;
	background: blue;
	box-shadow: 0 0 3px blue;
	transition: .5s;
	transform-origin: 50% 50%;
	transform: rotate(45deg);
	border-radius: 3px;
}

.cmp-square.outlier {
	opacity: .8;
	background: red;
	box-shadow: 0 0 3px red;
  animation: pulse 2s infinite;
	z-index: 1;
	position: absolute;
}

.cmp-square.selected {
	opacity: .8;
	transform: rotate(45deg) scale(1.6);
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
    box-shadow: 0 0 0 0 rgba(0,0,0, 0.4);
  }
  70% {
      box-shadow: 0 0 0 6px rgba(0,0,0, 0);
  }
  100% {
      box-shadow: 0 0 0 0 rgba(0,0,0, 0);
  }
}

</style>