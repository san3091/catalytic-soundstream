<script>	
	import { onMount } from 'svelte'
	import { user, loading } from './stores.js'
	import Header from './Header/Header.svelte'
	import Content from './Content/Content.svelte'
	import authenticateUser from './authHelpers.js'

	onMount(async () => {
		let authenticatedUser = await authenticateUser()
		user.set(authenticatedUser)
		loading.set(false)
	})
</script>

<main>
	<Header />
	<Content />
</main>

<style>
	:global(body) {
		--black: #222;
		--medium-grey: #3e3e3e;
		--light-grey: #dbdedf;
		--orange: #f96854;
		--transparent-white: hsl(0, 0%, 100%, 80%);
		--transparent-black: hsl(0, 0%, 0%, 50%);
		--transparent-orange: hsl(7, 93%, 65%, 40%);
		--translucent-orange: hsl(7, 93%, 65%, 90%);
		--translucent-grey: hsl(0, 0%, 24%, 90%);
		--white: #fff;
		--transparent-grey: hsl(0, 0%, 0%, 10%);
		

		background-color: var(--medium-grey);
		/* background-color: var(--orange); */
		padding: 0px;
	}

	:global(*) {
		margin: 0;
		padding: 0;
		/* color: var(--medium-grey); */
		color: var(--light-grey);
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
		font-size: 14px;
	}

	:global(h6) {
		font-size: 12px;
	}

	:global(h5, h6) {
    color: var(--light-grey);
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
			font-size: 12px;
		}
		:global(h6) {
			font-size: 10px;
		}
	}
	
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		font-family: 'Raleway';
	}
</style>