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
          view on bandcamp
        </a>
      {/if}
    </div>
  {/if}
</div>

<style>
  .info-container {
    width: 100%;
    margin-top: 40px;
  }

  .info-content {
    box-sizing: border-box;
    margin-bottom: 20px;
  }

  .description { 
    margin: 20px 0 0;
  }
  
  .title {
    margin-top: 0;
  }
  
  .curator {
    margin-top: 40px;
  }

  .mobile {
    margin-bottom: 25px;
  }

  /* .bandcamp-link {
    display: inline-block;
    padding: 10px 30px;
    color: white;
    background-color: var(--orange);
    font-size: 18px;
    text-decoration: none;
    transition: background-color .1s ease-in;
  } */

  .bandcamp-link {
    align-self: flex-start;
    display: inline-block;
    margin: 40px 0 10px;
    color: var(--red-orange);
  }

  /* .bandcamp-link:hover {
    background-color: var(--red-orange);
  } */
</style>