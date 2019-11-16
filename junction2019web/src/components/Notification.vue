<template>
	<transition name="fade" appear>
		<div class="cmp-notification" :class="[style[type].class, {closed}]" @click="$emit('close')">
			<div class="cmp-img">
				<i class="material-icons">{{style[type].class}}</i>
			</div>
			<div class="cmp-body">
				<div class="cmp-title">{{style[type].title}}<i @click="closed = true" class="material-icons" style="float:right; cursor: pointer; position: relative; bottom: 8px;">close</i></div>
				<div class="cmp-action" @click="actionclick">{{style[type].action}}</div>
			</div>
		</div>
	</transition>
</template>

<script>
export default {
	props: ['type'],
	data: function() {
		return {
			closed: false,
			style: {
				0: { class: 'warning', title: 'ABANDONED LUGGAGE', action: 'Send Security', msg: 'br' },
				1: { class: 'error', title: 'UNAUTHORIZED ACCESS', action: 'Send Security', msg: '' },
				2: { class: 'warning', title: 'OVERCROWDING DETECTED', action: 'Open Extra Gate', msg: ''},
				3: { class: 'info', title: 'LUGGAGE RECOVERED!', action: 'Noted!', msg: ''},
			}
		}
	},
	methods: {
		actionclick() {
			this.$emit('action')
			setTimeout(() => { this.$emit(this.style[this.type].msg) }, 10000)
			setTimeout(() => this.closed = true)
		}
	}
}
</script>

<style scoped>

.cmp-notification {
	width: 372px;
	height: 92px;
	border-radius: 2px;
	border-top-left-radius: 16px;
	border-bottom-left-radius: 16px;
	box-shadow: 0 2px 5px rgba(0,0,0,0.8);
	margin-bottom: 20px;
	transition: .5s;
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px;
	overflow: hidden;
}

.cmp-notification.closed {
	opacity: .25;
	height: 0;
	margin: 0;
}

.cmp-img {
	width: 92px;
	height: 92px;
	float: left;
	box-shadow: 0px 3px 6px #00000029;
	position: relative;
}

.cmp-img > i {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	position: block;
	margin: auto;
	color: white;
	font-size: 36px;
	height: 36px;
}

.cmp-body {
	background: white;
	width: 280px;
	height: 92px;
	float: right;
	text-align: left;
	box-shadow: 0 0 5px rgba(0,0,0,0.5);
	padding: 4px 40px;
	box-sizing: border-box;
	display: flex;
	flex-flow: column;
}

.cmp-title {
	text-transform: uppercase;
	padding: 4px 0px 2px 0px;
	font-weight: bold;
	font-size: 18px;
	flex-grow: 1;
}
.cmp-action {
	height: 28px;
	line-height: 28px;
	font-size: 12px;
	color: white;
	background: radial-gradient(closest-side at 50% 50%, #611A67 0%, #4D0C53 100%);
	text-align: center;
	box-shadow: 0px 3px 6px #00000029;
	transition: .5s;
	border-radius: 14px;
	cursor: pointer;
}
.cmp-action:hover {
	box-shadow: 0px 3px 12px #00000088;
}

.cmp-notification.warning .cmp-img {
	background: #FFDC14;
}

.cmp-notification.error .cmp-img {
	background: #D94B4A;
}

.cmp-notification.info .cmp-img {
	background: green;
}

.fade-enter-active, .fade-leave-active {
  transition: .5s;
}
.fade-enter, .fade-leave-to {
  transform: translateX(100%) scale(0);
}

</style>