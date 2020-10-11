<script>
  import { fade } from 'svelte/transition'

  import { playable } from '../../../helpers.js'
  import { user } from '../../../stores.js'
  
  export let playAlbum
  export let selectedAlbum

  $: primaryButtonText = playable(selectedAlbum, $user) ? 'PLAY' : 'UNLOCK'
</script>

<div class='album-info'>
  <div class='album-info-left'>
    <h2 class='title'>{selectedAlbum.title}</h2>
    <h4 class='artist'>{selectedAlbum.artist}</h4>
    <button 
      class='primary-button'
      on:click|stopPropagation={() => {playAlbum(selectedAlbum)}}>
      { primaryButtonText }
    </button>
  </div>
  <div class='album-info-right'>
    {#if selectedAlbum.description}
      <p class='description'>
        {selectedAlbum.description}
      </p>
    {/if}
    {#if selectedAlbum.curator}
      <h5 class='curator'>Curated by: {selectedAlbum.curator}</h5>
    {/if}
  </div>
  
  <!-- {#if selectedAlbum.bandcamp_url}
    <a 
      href={selectedAlbum.bandcamp_url} 
      class='bandcamp-link'
      target="_blank" rel="noopener noreferrer">
      BUY
    </a>
  {/if} -->
</div>

<style>
  .album-info {
    display: flex;
    flex-direction: row;
    margin: 20px 40px 40px;
  }

  .album-info-left {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .title  {
    margin-top: 0;
  }

  .primary-button {
    align-self: flex-start;
    margin-top: 40px;
    padding: 10px 30px;
    color: white;
    background-color: var(--orange);
    font-size: 18px;
    transition: background-color .1s ease-in;
    border: none;
  }

  .curator {
    justify-self: flex-end;
  }

  .album-info-right {
    flex: 1;
    border: 1px solid var(--orange);
    padding: 20px;
  }
</style>