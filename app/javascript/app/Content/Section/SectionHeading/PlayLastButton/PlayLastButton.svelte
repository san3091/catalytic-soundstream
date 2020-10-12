<script>
    import { fade } from 'svelte/transition'

    export let dontMissAlbum
    export let selected
    export let selectAlbum

    let mousedown
</script>

<div class='button-container'>
  <button 
    transition:fade 
    class='play-last-button'
    class:selected 
    class:mousedown
    on:click|stopPropagation={() => selectAlbum(dontMissAlbum) }
    on:mousedown|stopPropagation={() => { mousedown = true } }
    on:mouseup|stopPropagation={() => { mousedown = false } }
    on:mouseleave|stopPropagation={() => { mousedown = false } } >
    <h6>
      <b>DON'T MISS:</b>
      <span>{dontMissAlbum.title}</span>
    </h6>
  </button>
</div>

<style>
  b {
    font-weight: 400;
    margin-right: 10px;
    color: var(--orange);
  }

  span {
    color: var(--black);
  }

  h6 {
    text-align: left;
		white-space: unset;
  }

  .button-container {
    padding-bottom: 40px;
    margin-right: 20px;
  }

  .play-last-button {
    position: relative;
    padding: 5px 15px;
    border: none;
    box-sizing: border-box;
    border: 1px solid var(--medium-grey);
    background-color: var(--light-grey);
    border-radius: 0;
    cursor: pointer;
  }

  .play-last-button::after {
    content: '';
    position: absolute;
    background-color: var(--black);
    opacity: 0;
    /* top: 4px;
    left: 4px; */
    height: 100%;
    width: 100%;
    z-index: -2;
    border-radius: 0;
  }

  .play-last-button:hover {
    top: -3px;
    left: -4px;
  }

  .play-last-button:hover::after {
    opacity: 1;
    top: 3px;
    left: 4px;
  }

  .play-last-button.selected {
    top: -6px;
    left: -8px;
  }

  .play-last-button.selected::after {
    top: 6px;
    left: 8px;
    opacity: 1;
    background-color: var(--orange);
  }

</style>