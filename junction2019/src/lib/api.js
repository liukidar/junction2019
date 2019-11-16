function isIterable(obj) {
	if (obj == null) {
		return false
	}
	return Array.isArray(obj) || typeof obj === 'object'
}

export function API(path) {
	function request(method, target, data, headers) {
		return new Promise((resolve, reject) => {
			let ajaxRequest = new XMLHttpRequest()
			let payload = ''

			if (method === 'GET' || method === 'DELETE') {
				if (isIterable(data)) {
					for (let value in data) {
						if (data[value] !== undefined) {
							payload += '/' + encodeURIComponent(data[value])
						}
					}
				} else {
					payload = '/' + encodeURIComponent(data)
				}
				ajaxRequest.open(method, target + payload)
			} else {
				ajaxRequest.open(method, target)
				ajaxRequest.setRequestHeader('Content-Type', 'application/json')
				payload = JSON.stringify(data)
			}

			for (let header in headers.data) {
				ajaxRequest.setRequestHeader(header, headers.data[header])
			}
			ajaxRequest.setRequestHeader('Cache-Control', 'no-cache')
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState === XMLHttpRequest.DONE) {
					if (ajaxRequest.status === 200) {
						let r = JSON.parse(ajaxRequest.responseText)
						r.status = ajaxRequest.status

						resolve(r)
					} else {
						reject(ajaxRequest.status)
					}
				}
			}

			if (method === 'GET' || method === 'DELETE') {
				ajaxRequest.send()
			} else {
				ajaxRequest.send(payload)
			}
		})
	}

	return {
		headers: {
			data: {},
			set: function(name, data) { this.data[name] = data }
		},
		request: function(method, target, data) { return request(method, path + '/' + target, data, this.headers) }
	}
}
