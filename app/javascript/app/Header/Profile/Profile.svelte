<script>
	import { onMount } from 'svelte'
	import { user } from '../../stores.js'
	
	import PatreonModal from './PatreonModal/PatreonModal.svelte'
</script>

{#if !$user || !$user.is_member}
	<PatreonModal user=$user/>
{/if}


