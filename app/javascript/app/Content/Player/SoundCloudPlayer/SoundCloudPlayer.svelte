<script>
  import { onMount } from 'svelte'

  export let playingAlbum

</script>

<div  class='player-container'>
  {#if playingAlbum}
    {@html playingAlbum && playingAlbum.html}
  {/if}
</div>

<style>
</style>
 