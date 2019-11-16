<template>
	<div class="cmp-room" :style="{'background-color': el.bkg, top: el.y + 'px', left: el.x + 'px', transform: 'translate(-50%, -50%) rotate('+ el.r +'deg)', width: el.w + 'px', height: el.h + 'px'}"></div>
</template>

<script>
export default {
	props: ['el']
}
</script>

<style>

.cmp-room {
	position: absolute;
	display: inline-block;
	transform-origin: 50% 50%;
}

</style>