<script>
	import { onMount } from 'svelte'
	import { user, loading, userIsOpen, modalIsOpen, redirectUri, clientId } from './stores.js'
	import Header from './Header/Header.svelte'
	import Content from './Content/Content.svelte'
	import { authenticateUser } from './authHelpers.js'
  import { appWidth, mobileLayout } from './stores.js'
  export let patreonRedirect
  export let patreonClientId

  let width


	const closeOpenThings = () => {
		userIsOpen.set(false)
		modalIsOpen.set(false)
	}

	const setMobileLayout = (width) => {
		if (width < 1000) { mobileLayout.set(true) }
		else { mobileLayout.set(false) }
	}

	onMount(async () => {
    let authenticatedUser = await authenticateUser()
    user.set(authenticatedUser)
    redirectUri.set(patreonRedirect)
    clientId.set(patreonClientId)
		loading.set(false)
	})

	$: appWidth.set(width)
	$: setMobileLayout(width)
</script>

<main
	on:click={closeOpenThings}
	bind:clientWidth={width}>
	<Header />
	<Content />
</main>

<style>
	:global(body) {
		--black: #000;
		--dark-grey: #3e3e3e;
		--medium-grey: #8D8E8F;
		--light-grey: #dbdedf;
		--orange: #f96854;
		--red-orange: #D3372B;
		--transparent-white: hsl(0, 0%, 100%, 80%);
		--transparent-black: hsl(0, 0%, 0%, 50%);
		--transparent-orange: hsl(7, 93%, 65%, 40%);
		--translucent-grey: hsl(0, 0%, 24%, 90%);
		--white: hsl(0, 0%, 100%, 95%);
		--transparent-grey: hsl(0, 0%, 0%, 10%);

		background-color: var(--light-grey);
		padding: 0px;
	}

	:global(*) {
		margin: 0;
		padding: 0;
		color: var(--dark-grey);
	}

	:global(button) {
		margin: 0;
		padding: 0;
	}

	:global(h2) {
		margin: 50px 0 10px;
	}

	:global(h4) {
		font-size: 15px;
	}

	:global(h5) {
		font-size: 12px;
	}

	:global(h6) {
		font-size: 10px;
	}

	:global(h5) {
		color: var(--black)
	}

	:global(h6) {
    color: var(--dark-grey);
	}

	:global(p) {
		margin-bottom: 20px;
	}

	@media screen and (max-width: 1300px) {
		:global(p) {
			font-size: 14px;
		}
		:global(h2) {
			margin-top: 25px;
			font-size: 20px;
		}
		:global(h3) {
			font-size: 17px;
		}

		:global(h4) {
			font-size: 14px;
		}

		:global(h5) {
			font-size: 10px;
		}
		:global(h6) {
			font-size: 8px;
		}
	}

	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		font-family: 'Raleway';
	}
</style>
