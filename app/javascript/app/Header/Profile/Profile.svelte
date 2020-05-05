<script>
	import { onMount } from 'svelte'
	import { user } from '../../stores.js'
	
	import PatreonModal from './PatreonModal/PatreonModal.svelte'
	import User from './User/User.svelte'
</script>

<div class='container'>
	{#if !$user || !$user.is_member}
		<PatreonModal user={$user} />
	{:else}
		<User/>
	{/if}
</div>

<style>
	.container {
		position: relative;
		min-width: 250px;
		margin: 10px;
	}
</style>