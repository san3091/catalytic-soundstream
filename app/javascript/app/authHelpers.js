const authenticateUser = async () => {
  const localStorage = window.localStorage
  const urlParams = new URLSearchParams(window.location.search) // IE not supported
  let user = null
  const code = urlParams.get('code')
  const accessToken = localStorage.getItem('catalyticStreamingAccessToken')

  if (code) {
    user = await authenticatePatreon(code)
    localStorage.setItem('catalyticStreamingAccessToken', user.access_token)
    window.history.replaceState({}, document.title, '/')

    return user
  } else if (accessToken) {
    user = await authenticateLocalStorage(accessToken)
    return user.error ? null : user
  } 
}

const authenticatePatreon = async (code) => {
  const url = '/patreon/authenticate'
		const data = {code}
		
		const response = await fetch(url, {
			method: 'POST',
			mode: 'same-origin',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(data) 
		});
	
  	return response.json(); 
}

const authenticateLocalStorage = async (accessToken) => {
  const url = `/patreon/user?access_token=${accessToken}`
  const response = await fetch(url)

  return response.json()
}

export default authenticateUser