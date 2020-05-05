<script>
  import { loading, modalIsOpen } from '../../../stores.js'
  export let user

	import PatronButton from '../../../../assets/become_a_patron_button@2x.png'
  import PatreonWordmarkBlack from '../../../../assets/Patreon_Wordmark_Black.png'

  const clientId = 'K0V2sSuIYe12y_yEhHmnlT7XK6sghUrlWv3B2wq-372iVaX8Tsud1AsXxaV3B-XR'
	const redirect_uri = 'https://bbb8ac2d.ngrok.io'
	const patreonUrl = `https://www.patreon.com/oauth2/authorize?response_type=code&client_id=${clientId}&redirect_uri=${redirect_uri}`

	const openModal = () => modalIsOpen.set(true)
	const closeModal = () => modalIsOpen.set(false)
	// <Main> in App.svelte closes modal on:click
</script>

<button on:click|stopPropagation={openModal}>
	<h4>Connect with </h4>
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
					<h3>You must be a subsciber at the 'Streaming Tier' to access the complete collection.</h3>
					<a
						class='become-patron-button'
						href='https://www.patreon.com/catalyticsound'>
						<img 
							class='become-patron-img' 
							src={PatronButton} 
							alt='become a patron' />
					</a>
				{:else}
					<h3>Sign in or become a patron to access more free jazz.</h3>
					<a class='sign-in-button' href={patreonUrl}>
						<h4>Sign in with </h4>
						<img 
							class='patreon-wordmark' 
							src={PatreonWordmarkBlack} 
							alt='sign in with patreon'/>
					</a>
					<a
						class='become-patron-button'
						href='https://www.patreon.com/catalyticsound'
						target="_blank" rel="noopener noreferrer">
						<img 
							class='become-patron-img' 
							src={PatronButton} 
							alt='become a patron' />
					</a>
				{/if}
			{:else}
				<h3>Working...</h3>
			{/if}
		</div>
	</div>
{/if}

  <style>
	* {
		color: var(--medium-grey);
	}

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
		border: 1px solid var(--medium-grey);
	}

	.patreon-wordmark {
		height: 40px;
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
		/* background-color: var(--translucent-orange); */
		background-color: var(--translucent-grey);	}

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
		border: 1px solid var(--medium-grey);
		margin: 5px;
	}

	a:hover {
		background: none;
	}

	.sign-in-button {
		width: 240px;
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
		padding: 10px;
	}

	.become-patron-button {
		width: 240px;
		height: 62px;
		border: none;
	}

	.become-patron-img {
		width: 100%;
		height: 100%;
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

	h4 {
		color: var(--medium-grey);
	}
</style>