<template>
	<transition name="fade" appear>
		<div class="cmp-small-note">
			<div class="cmp-body">
				<div class="cmp-title">{{title}}</div>
				<div class="cmp-subtitle"><i>User MAC address</i></div>
			</div>
			<div class="cmp-square"></div>
		</div>
	</transition>
</template>

<script>
export default {
	props: ['title']
}
</script>

<style scoped>

.cmp-small-note {
	transition: .5s;
	text-align: left;
	font-weight: thin;
	position: relative;
}

.cmp-body {
	box-shadow: 0 0 10px rgba(0,0,0,1);
	background: #363636;
	padding: 6px 16px;
	color: white;
	border-radius: 16px;
	width: 100%;
	height: 100%;
	position:relative;
	z-index: 1;
}
.cmp-title {
	font-size: 18px;
}
.cmp-subtitle {
	font-size: 12px;
	color: #DDD;
	padding-top: 2px;
}

.cmp-square {
	background: #363636;
	width: 16px;
	height: 16px;
	transform: translate(-50%, -50%) rotate(45deg);
	position: absolute;
	top: 60%;
	left: 0;
	z-index: -1;
	box-shadow: 0 0 10px rgba(0,0,0,1);
}

.fade-enter-active, .fade-leave-active {
  transition: .5s;
}
.fade-enter, .fade-leave-to {
  transform: translateX(100%) scale(0);
}

</style>