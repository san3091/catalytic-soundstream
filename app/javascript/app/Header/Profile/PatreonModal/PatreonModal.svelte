<script>
  import { loading, modalIsOpen } from '../../../stores.js'
	import { onMount } from 'svelte'
	
	import BecomeAPatronButton from './BecomeAPatronButton/BecomeAPatronButton.svelte'
  import PatreonWordmarkBlack from '../../../../assets/Patreon_Wordmark_Black.png'
	
	export let user
	export let signOut

	let clientId =   "SzBWMnNTdUlZZTEyeV95RWhIbW5sVDdYSzZzZ2hVcmxXdjNCMndxLTM3MmlW\nYVg4VHN1ZDFBc1h4YVYzQi1YUg==\n"
	let redirectUri = window.location.href.replace(/\/$/, "")

  $: patreonUrl = `https://www.patreon.com/oauth2/authorize?response_type=code&client_id=${atob(clientId)}&redirect_uri=${redirectUri}`

	const openModal = () => modalIsOpen.set(true)
	const closeModal = () => modalIsOpen.set(false)
	// <Main> in App.svelte closes modal on:click
</script>

<button
	class='white-button'
	on:click|stopPropagation={openModal}>
	<h6>Connect with </h6>
	<img class='patreon-wordmark' src={PatreonWordmarkBlack} alt='connect with patreon' />
</button>

{#if $modalIsOpen}
	<div class='modal-container'>
		<div class='patreon-modal'>
			<button
				class='close-button'
				on:click|stopPropagation={closeModal} >
				<i class="material-icons">close</i>
			</button>
			{#if !$loading}
				{#if user && !user.is_member}
					<h3>You must be a subscriber at the 'Streaming Tier' to access the complete collection.</h3>
					<BecomeAPatronButton />
					<button 
						class='white-button' 
							on:click|stopPropagation={signOut}>
						<h5>Sign Out</h5>
					</button>
				{:else}
					<h3>Sign in or become a patron to access more music.</h3>
					<a
						on:click|stopPropagation
						href={patreonUrl}>
						<button
							class='white-button'
							on:click|stopPropagation={openModal}>
							<h6>Sign in with </h6>
							<img
								class='patreon-wordmark'
								src={PatreonWordmarkBlack}
								alt='sign in with patreon'/>
						</button>
					</a>
					<BecomeAPatronButton />
				{/if}
			{:else}
				<h3>Working...</h3>
			{/if}
		</div>
	</div>
{/if}

  <style>

	button {
		box-sizing: border-box;
		width: 100%;
		height: 100%;
		background-color: var(--transparent-white);
		border: none;
		display: flex;
		flex-direction: row;
		cursor: pointer;
		align-items: center;
		justify-content: center;
    padding: 10px;
		border-radius: 0;
	}

	.white-button {
		padding: 8px;
		transition: background-color 0.3s ease;
		width: 200px;
	}

	.white-button:hover {
		background-color: var(--white)
	}

	.patreon-wordmark {
		height: 32px;
		margin-left: 10px;
	}

	.modal-container {
		display: block;
		position: fixed;
		top: 0;
		left: 0;
		height: 100vh;
		width: 100vw;
		display: flex;
		justify-content: center;
		align-items: center;
		background-color: var(--translucent-grey);	
	}

	.patreon-modal {
		position: relative;
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 50px;
		background-color: var(--transparent-white);
	}

	h3 {
		margin: 20px;
	}

	a {
		box-sizing: border-box;
		text-decoration: none;
		/* margin: 4px; */
	}

	a:hover {
		background: none;
	}

	.close-button {
		position: absolute;
		width: 30px;
		height: 30px;
		top: 20px;
		right: 20px;
		padding: 0;
		margin: 0;
		border: none;
		background-color: transparent;
	}

	.material-icons {
    font-size: 28px;
  }
</style>
