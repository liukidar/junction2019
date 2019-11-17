// import Vue from 'vue'

String.prototype.hashCode = function() {
  var hash = 0, i, chr
  if (this.length === 0) return hash
  for (i = 0; i < this.length; i++) {
    chr   = this.charCodeAt(i)
    hash  = ((hash << 5) - hash) + chr
    hash |= 0
  }
  return hash
}

let luggageOffset = [[40, 60], [-20, -30], [-60, 10], [30, -10], [-50, 20]]
let counter = 0
let crowdedCenter = [50 / 0.11474, 85 / 0.11474]
let crowdedRadius = 100 / 0.11474
let maxX = 650 / 0.11474
let maxY = 350 / 0.11474
let targetX = [440 / 0.11474, 640 / 0.11474, 790 / 0.11474]
let targetY = [410 / 0.11474, 480 / 0.11474, 430 / 0.11474]

export const module = {
	namespaced: true,
	state: {
		layers: { 1: {}, 2: {}, 3: {} },
		people: {},
		luggage: {},
		selected: {},
		outlierBag: {},
		outlierPerson: {},
		crowdDetection: false,
		rooms: {
			1: [{ x: 173.5, y: 59.67, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 317.03, y: 59.67, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 461.25, y: 59.86, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 48.35, y: 93.86, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 172.11, y: 152.03, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 316.68, y: 153.03, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 461.25, y: 153.75, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 36.71, y: 192.75, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 39.5, y: 278.81, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 172.5, y: 247.81, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 314.9, y: 246.81, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 173.9, y: 340.21, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 328.1, y: 337.21, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 459.5, y: 302.9, bkg: 'white', w: 121.6, h: 51.6, r: -14 },
				{ x: 321.2, y: 446.9, bkg: 'white', w: 121.6, h: 51.6, r: 14 },
				{ x: 570.2, y: 429.9, bkg: 'white', w: 227.6, h: 59.6, r: 14 },
				{ x: 438.8, y: 511.1, bkg: 'white', w: 112.5, h: 112.5, r: 14 },
				{ x: 765.8, y: 434.8, bkg: 'white', w: 144.5, h: 50.5, r: -14 },
				{ x: 599.8, y: 536.8, bkg: 'white', w: 213.5, h: 65, r: -14 }]
		}
	},
	getters: {
		layers(_state) {
			return _state.layers
		},
		people(_state) {
			return (_layer) => _state.people[_layer]
		},
		luggage(_state) {
			return (_layer) => _state.luggage[_layer]
		},
		selected(_state) {
			return _state.selected
		},
		rooms(_state) {
			return _state.rooms
		},
		outlierPerson(_state) {
			return _state.outlierPerson
		}
	},
	mutations: {
		listLayers(_state, _data) {
			_state.layers = _data
		},
		updatePeople(_state, _data) {
			_state.people = _data
		},
		updateLuggage(_state, _data) {
			_state.luggage = _data
		},
		select(_state, _data) {
			_state.selected = _data
		}
	},
	actions: {
		listLayers(_ctx) {
			return new Promise((resolve, reject) => {
				_ctx.rootState.api.request('GET', '', []).then((r) => {
					_ctx.commit('listLayers', r)

					return resolve(r)
				}).catch((e) => reject(e))
			})
		},
		updatePeople(_ctx) {
			return new Promise((resolve, reject) => {
				_ctx.rootState.api.request('GET', '', []).then((r) => {
					let layers = { 1: [], 2: [], 3: [] }
					let luggage = []
					for (let key in r) {
						if (r[key].floor) {
							if (r[key].x > maxX && r[key].y > maxY) {
								continue
							}
							if (r[key].floor == 1 && (key.hashCode() % 4 == 0)) {
								let offset = luggageOffset[Math.floor(Math.random() * luggageOffset.length)]
								if (key != _ctx.state.outlierBag.id) {
									luggage.push({ id: key, x: r[key].x + offset[0], y: r[key].y + offset[1], floor: r[key].floor, status: 0 })
								}
							}
							if (key != _ctx.state.outlierBag.id) {
								if (_ctx.state.crowdDetection && r[key].floor == 1) {
									if ((r[key].x - crowdedCenter[0])*(r[key].x - crowdedCenter[0]) + (r[key].y - crowdedCenter[1])*(r[key].y - crowdedCenter[1]) < crowdedRadius * crowdedRadius) {
										r[key].status = 2
									}
								}
								layers[r[key].floor].push({...r[key], id: key})
							}
						}
					}
					if (_ctx.state.outlierPerson.id) {
						let vx = -_ctx.state.outlierPerson.x + targetX[_ctx.state.outlierPerson.step]
						let vy = -_ctx.state.outlierPerson.y + targetY[_ctx.state.outlierPerson.step]
						if (vx*vx < 400 && vy*vy < 400) {
							if (_ctx.state.outlierPerson.step < targetX.length - 1) {
								_ctx.state.outlierPerson.step++
							}
						}
						let mul = 1 / Math.sqrt(vx*vx + vy*vy) * 200 * Math.random()
						_ctx.state.outlierPerson.x += vx * mul
						_ctx.state.outlierPerson.y += vy * mul
						if (_ctx.state.outlierPerson.x > maxX && _ctx.state.outlierPerson.y > maxY) {
							_ctx.state.outlierPerson.status = 1
						}
						layers[1].push(_ctx.state.outlierPerson)
					}
					if (_ctx.state.outlierBag.id) {
						luggage.push(_ctx.state.outlierBag)
					}
					_ctx.commit('updatePeople', layers)
					if (counter % 3 == 0) {
						_ctx.commit('updateLuggage', { 1: luggage })
					}
					counter++

					return resolve(r)
				}).catch((e) => reject(e))
			})
		},
		select(_ctx, _data) {
			_ctx.commit('select', _data)
		},
		pickOutlierBag(_ctx) {
			_ctx.state.outlierBag = _ctx.state.luggage[1][3]
			_ctx.state.outlierBag.status = 1
		},
		removeOutlierBag(_ctx) {
			_ctx.state.outlierBag = {}
		},
		toggleOvercrowding(_ctx, _val) {
			_ctx.state.crowdDetection = _val
		},
		pickOutlierPerson(_ctx) {
			_ctx.state.outlierPerson = _ctx.state.people[1][3]
			_ctx.state.outlierPerson.id += 'x'
			_ctx.state.outlierPerson.step = 0
		},
		clearOutlierPerson(_ctx) {
			_ctx.state.outlierPerson = {}
		}
	}
}
