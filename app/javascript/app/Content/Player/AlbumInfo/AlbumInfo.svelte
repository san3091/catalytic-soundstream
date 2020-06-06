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
      <h3>{album.title}</h3>
      <h4>{album.artist}</h4>
      {#if album.description}
        <p>
          {album.description}
        </p>
      {/if}
      <a 
        href={album.bandcamp_url} 
        class='bandcamp-link'
        target="_blank" rel="noopener noreferrer">
        Buy on Bandcamp
      </a>
    </div>
  {/if}
</div>

<style>
  * {
    color: var(--medium-grey);
  }
  .info-container {
    width: 100%;
    margin-bottom: 50px;
  }

  .info-content {
    box-sizing: border-box;
    padding: 20px;
    border-left: 2px solid var(--orange);
  }

  p { 
    margin: 20px 0 0;
  }

  .mobile {
    margin-bottom: 25px;
  }

  .bandcamp-link {
    display: inline-block;
    margin-top: 20px;
    padding: 10px;
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