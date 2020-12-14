<script>
	import { onMount } from 'svelte'
	import { user, loading, userIsOpen, modalIsOpen } from './stores.js'
	import Header from './Header/Header.svelte'
	import Content from './Content/Content.svelte'
	import { authenticateUser } from './authHelpers.js'
  import { appWidth, mobileLayout } from './stores.js'
	
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
		if ($user && !$user.is_member) { modalIsOpen.set(true)}
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
		--black: #242424;
		--dark-grey: #3e3e3e;
		--medium-grey: #747373;
		--light-grey: #dbdedf;
		--orange: hsl(3, 98%, 58%);
		--red-orange: #D3372B;
		--transparent-white: hsl(0, 0%, 100%, 80%);
		--transparent-black: hsl(0, 0%, 0%, 50%);
		--transparent-orange: hsl(3, 98%, 58%, 60%);
		--translucent-grey: hsl(0, 0%, 24%, 90%);
		--white: hsl(0, 0%, 100%, 95%);
		--transparent-grey: hsl(0, 0%, 0%, 30%);

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

	:global(button:focus) {
		outline: none;
	}


	:global(p) {
		font-size: 0.9rem;
		margin-bottom: 20px;
		line-height: 23px;
		color: var(--medium-grey);
	}

	:global(h1) {
		font-size: 1.7rem;
		margin: 40px 0 10px;
		color: var(--black);
	}

	:global(h2) {
		font-size: 1.5rem;
		margin: 40px 0 10px;
		color: var(--dark-grey);
	}

	:global(h4) {
		font-size: 1.15rem;
		font-weight: 500;
		color: var(--medium-grey);
	}

	:global(h5) {
		font-size: 1rem;
		color: var(--black)
	}

	:global(h6) {
		font-size: 0.9rem;
		white-space: nowrap;
    color: var(--dark-grey);
	}

	@media screen and (max-width: 700px) {
		:global(p) {
			font-size: 1.25rem;
		}

		:global(h2) {
			font-size: 1.75rem;
			margin-top: 25px;
		}

		:global(h4) {
			font-size: 1.5rem;
		}

		:global(h5) {
			font-size: 1.25rem;
		}
		
		:global(h6) {
			font-size: 1.125rem;
		}
	}

	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		font-family: 'Raleway';
	}
</style>
