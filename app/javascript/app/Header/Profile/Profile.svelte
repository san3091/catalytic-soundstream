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
		<User user={$user} />
	{/if}
</div>

<style>
	.container {
		min-width: 250px;
		margin: 10px;
		background-color: var(--transparent-white);
		border: 1px solid var(--medium-grey);
	}
</style>