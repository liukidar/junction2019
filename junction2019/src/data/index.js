import Vue from 'vue'
import Vuex from 'vuex'
import { module as map } from './map'
import { API } from '../lib/api'

Vue.use(Vuex)

export const store = new Vuex.Store({
	state: {
		api: API('http://130.233.87.45:5000')
	},
	modules: {
		map
	}
})
