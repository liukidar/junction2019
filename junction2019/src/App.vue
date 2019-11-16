<template>
  <div id="app">
		<layered-map></layered-map>
		<notification-panel></notification-panel>
  </div>
</template>

<script>
import LayeredMap from './components/Map'
import NotificationPanel from './components/NotificationPanel'

export default {
  name: 'app',
  components: {
    LayeredMap, NotificationPanel
  }
}
</script>

<style>

@font-face {
	font-family: Arboria-Bold;
	src: url(assets/fonts/Arboria-Bold.otf);
}
* {
	font-family: 'Arboria-Bold';
	margin: 0;
	padding: 0;
}
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
	background-color: #131313;
	width: 100vw;
	height: 100vh;
	overflow: hidden;
}

</style>
