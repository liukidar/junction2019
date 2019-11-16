<template>
	<div class="cmp-notification-panel" :style="{paddingTop: offset + 'px'}">
		<notification v-for="(el) in notifications" :key="el.id" :type="el.type" @br="createNotification(4, 3); removeOutlierBag()"></notification>
	</div>
</template>

<script>
import Notification from './Notification'
import { mapGetters, mapActions } from 'vuex'

export default {
	data: function() {
		return {
			notifications: [],
			active: false,
			offset: 0
		}
	},
	computed: {
		...mapGetters('map', ['selected'])
	},
	methods: {
		createNotification(_id, _type) {
			setTimeout(() => this.offset += 112, 60000)
			this.notifications.push({id: _id, type: _type})
		},
		...mapActions('map', ['removeOutlierBag', 'pickOutlierBag'])
	},
	mounted() {
		this.createNotification(3, 2)
		setTimeout(() => this.createNotification(2, 1), 2000)

		document.onkeypress = (e) => {
				e = e || window.event;
				if (e.keyCode == 98) { //b
					this.pickOutlierBag()
					this.createNotification(1, 0)
				}
		};
	},
	components: {
		Notification
	}
}
</script>

<style scoped>

.cmp-notification-panel {
	position: relative;
	transition: .5s;
	float: right;
	width: 360px;
	padding: 10px;
	height: 100%;
	display: flex;
	flex-direction: column-reverse;
}

</style>