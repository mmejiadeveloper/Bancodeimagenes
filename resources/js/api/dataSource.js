const _users = []
export default {
	getUsers(cb) {
		cb(_users);
		// setTimeout(() => cb(_users), 100)
	},

	buyProducts(products, cb, errorCb) {
		setTimeout(() => {
			// simulate random checkout failure.
			(Math.random() > 0.5 || navigator.userAgent.indexOf('PhantomJS') > -1)
				? cb()
				: errorCb()
		}, 100)
	},
}