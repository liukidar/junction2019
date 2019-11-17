<template>
	<div class="cmp-notification-panel" :style="{paddingTop: offset + 'px'}">
		<notification v-for="(el) in notifications" :key="el.id" :type="el.type"
			@br="createNotification(3); removeOutlierBag()" 
			@go="createNotification(4); toggleOvercrowding(false)"
			@ua="createNotification(5); clearOutlierPerson()"></notification>
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
			offset: 0,
			id: 0,
			outlier: null
		}
	},
	computed: {
		...mapGetters('map', ['selected', 'outlierPerson'])
	},
	methods: {
		createNotification(_type) {
			setTimeout(() => this.offset += 112, 60000)
			this.notifications.push({id: this.id, type: _type})
			this.id++
		},
		...mapActions('map', ['removeOutlierBag', 'pickOutlierBag', 'toggleOvercrowding', 'pickOutlierPerson', 'clearOutlierPerson'])
	},
	mounted() {
		document.onkeypress = (e) => {
				e = e || window.event;
				if (e.keyCode == 98) { //b
					this.pickOutlierBag()
					this.createNotification(0)
				}
				if (e.keyCode == 111) {
					this.toggleOvercrowding(true)
					this.createNotification(2)
				}
				if (e.keyCode == 113) {
					this.pickOutlierPerson()
					this.outlier = setInterval(() => {
						if (this.outlierPerson.status == 1) {
							this.createNotification(1)
							clearInterval(this.outlier)
						}
					}, 100)
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