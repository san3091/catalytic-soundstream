<script>
	import { onMount } from 'svelte'
	import { user } from '../../stores.js'
  import { disconnectUser } from '../../authHelpers.js'

	
	import PatreonModal from './PatreonModal/PatreonModal.svelte'
	import User from './User/User.svelte'

	const signOut = () => {
    disconnectUser()
    user.set(null)
  }
</script>

<div class='container'>
	{#if $user && $user.is_member}
		<User signOut={signOut}/>
	{:else}
		<PatreonModal user={$user} signOut={signOut} />
	{/if}
</div>

<style>
	.container {
		position: relative;
		min-width: 200px;
		margin: 10px;
	}
</style>