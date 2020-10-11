<script>
  import { fade } from 'svelte/transition'

  export let playAlbum
  export let selectedAlbum
</script>

<div class='album-info'>
  <div class='album-info-left'>
    <div class='album-headings'>
      <h2 class='title'>{selectedAlbum.title}</h2>
      <h4 class='artist'>{selectedAlbum.artist}</h4>
    </div>
    
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
    justify-content: space-between;
  }
  
  .title  {
    margin-top: 0;
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