<script>
  import { fade } from 'svelte/transition'
  export let album

</script>

<div class='info-container'>
  {#if album}
    <div 
      class='info-content' 
      transition:fade
      >
      <h3>{album.title}</h3>
      <h4>{album.author_name}</h4>
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
    color: #3e3e3e;
  }
  .info-container {
    width: 100%;
    margin-bottom: 50px;
  }

  .info-content {
    padding: 20px;
    /* border-bottom: 2px solid #3e3e3e; */
    border-bottom: 2px solid #f96854;
    background-color: hsl(0, 0%, 100%, 80%);
  }

  p { 
    margin: 20px 0 0;
  }

</style>