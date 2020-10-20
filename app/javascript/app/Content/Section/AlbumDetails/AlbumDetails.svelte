<script>
  import { fade } from 'svelte/transition'

  import { playable } from '../../../helpers.js'
  import { user, selectionWidth } from '../../../stores.js'
  
  export let playAlbum
  export let selectedAlbum
  export let highlight
  export let deselectAlbum

  $: isPlayable = playable(selectedAlbum, $user)
  $: primaryButtonText = isPlayable ? 'PLAY' : 'UNLOCK'
</script>

<div class='album-details' class:vertical={$selectionWidth < 800} 
  class:highlight
  in:fade >
  <button class='close-button' on:click={deselectAlbum}>
    <i class='material-icons'>close</i>
  </button>
  <div class='album-details-left'>
    <div class='details-header'>
      <img class='details-header-img' 
        src={selectedAlbum.thumbnail_url} 
        alt='{selectedAlbum.title} album cover' />
      <div class='details-header-text'>
        <h2 class='title'>{selectedAlbum.title}</h2>
        <h4 class='artist'>{selectedAlbum.artist}</h4>
      </div>
    </div>
    <button 
      class='button primary-button'
      on:click|stopPropagation={() => {playAlbum(selectedAlbum)}}>
      { primaryButtonText }
    </button>
  </div>
  <div class='album-details-right'>
    {#if selectedAlbum.curator}
      <h5 class='curator'>Curated by: {selectedAlbum.curator}</h5>
    {/if}
    {#if selectedAlbum.description}
      <p class='description'>
        {selectedAlbum.description}
      </p>
    {/if}
    {#if selectedAlbum.bandcamp_url}
      <a 
        href={selectedAlbum.bandcamp_url} 
        class='soundcloud-link'
        target="_blank" rel="noopener noreferrer">
        view on bandcamp
      </a>
    {/if}
  </div>
</div>

<style>
  .album-details {
    display: flex;
    flex-direction: row;
    margin: 20px 40px 40px;
  }

  .close-button {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 40px;
    background: transparent;
    border: none;
  }

  .close-button:hover .material-icons {
    color: var(--orange);
  }

  .material-icons {
    transition: color 0.1s ease-in-out;
    font-size: 32px;
    color: var(--dark-grey);
  }

  .album-details-left {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
  
  .details-header {
    display: flex;
    flex-direction: row;
  }

  .details-header-img {
    height: 100px;
    margin: 20px 20px 0 0;
  }

  .title  {
    margin-top: 20px;
  }

  .button {
    padding: 10px 30px;
    font-size: 18px;
    text-decoration: none;
    cursor: pointer;
  }

  .primary-button {
    align-self: flex-start;
    margin-top: 40px;
    color: white;
    background-color: var(--orange);
    transition: background-color .1s ease-in;
    border: none;
  }

  .primary-button:hover {
    background-color: var(--red-orange);
  }

  .soundcloud-link {
    align-self: flex-start;
    display: inline-block;
    margin-top: 20px;
    color: var(--orange);
  }

  .curator {
    margin-bottom: 20px;
  }

  .album-details-right {
    flex: 1;
    border: 1px solid var(--orange);
    padding: 20px;
  }

  .highlight h2, .highlight h5, .highlight .material-icons {
    color: var(--white);
  }
  
  .highlight h4, .highlight p {
    color: var(--light-grey);
  }

  .album-details.vertical {
    flex-direction: column;
  }

  .vertical .album-details-left {
    flex-direction: row;
    margin-bottom: 20px;
  }

  .vertical .details-header {
    align-items: flex-end
  }

  .vertical .primary-button {
    align-self: flex-end;
  }

  .vertical .close-button {
    justify-content: flex-end;
    margin: 0;
  }

  .vertical .details-header-img {
    height: 100px;
    margin: 0 20px 0 0;
  }
</style>