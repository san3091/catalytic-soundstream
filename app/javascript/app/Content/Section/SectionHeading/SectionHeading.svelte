<script>
  import { fade } from 'svelte/transition'

  export let headerText
  export let sectionDescription
  export let selected
  export let rotating
  export let dontMissAlbum
  export let playDontMissAlbum
  export let mousedown
</script>

<div class='section-top'>
  <div class='section-header'>
    <h2>{headerText}</h2>
    <p class='description'>{sectionDescription}</p>
  </div>
  {#if rotating && dontMissAlbum}
    <div class='button-container'>
      <button 
        transition:fade 
        class='play-last-button' 
        class:selected
        class:mousedown
        on:click|stopPropagation={playDontMissAlbum}
        on:mousedown|stopPropagation={() => { mousedown = true } }
        on:mouseup|stopPropagation={() => { mousedown = false } }
        on:mouseleave|stopPropagation={() => { mousedown = false } } >
        <h6>
          <b>DON'T MISS:</b>
          <span>{dontMissAlbum.title}</span>
        </h6>
      </button>
    </div>
  {/if}
</div>