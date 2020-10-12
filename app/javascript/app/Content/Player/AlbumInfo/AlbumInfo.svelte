<script>
  import { fade } from 'svelte/transition'
  export let album
  import { mobileLayout } from '../../../stores.js'

</script>

<div class='info-container' class:mobile={$mobileLayout}>
  {#if album}
    <div 
      class='info-content' 
      transition:fade
      >
      <h2 class='title'>{album.title}</h2>
      <h4 class='artist'>{album.artist}</h4>
      {#if album.curator}
        <h5 class='curator'>Curated by: {album.curator}</h5>
      {/if}
      {#if album.description}
        <p class='description'>
          {album.description}
        </p>
      {/if}
      {#if album.bandcamp_url}
        <a 
          href={album.bandcamp_url} 
          class='bandcamp-link'
          target="_blank" rel="noopener noreferrer">
          BUY
        </a>
      {/if}
    </div>
  {/if}
</div>

<style>
  * {
    color: var(--dark-grey);
  }

  .info-container {
    width: 100%;
    margin-top: 40px;
  }

  .info-content {
    box-sizing: border-box;
  }

  .description { 
    margin: 20px 0 0;
    line-height: 26px;
  }
  
  .title {
    color: var(--black);
    margin-top: 0;
  }
  
  .curator {
    margin-top: 40px;
    color: black;
  }

  .mobile {
    margin-bottom: 25px;
  }

  .bandcamp-link {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 30px;
    color: white;
    background-color: var(--orange);
    font-size: 18px;
    text-decoration: none;
    transition: background-color .1s ease-in;
  }

  .bandcamp-link:hover {
    background-color: var(--red-orange);
  }
</style>