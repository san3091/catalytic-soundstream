<script>
  import { onMount } from 'svelte'

  export let selectedAlbum

</script>

<div  class='player-container'>
  {#if selectedAlbum}
    {@html selectedAlbum && selectedAlbum.html}
  {/if}
</div>

<style>
</style>
 