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
</style>