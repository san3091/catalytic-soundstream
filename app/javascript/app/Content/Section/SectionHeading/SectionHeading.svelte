<script>
  import { fade } from 'svelte/transition'

  export let headerText
  export let sectionDescription
  export let playing
  export let rotating
  export let dontMissAlbum
  export let selectAlbum
  export let mousedown
  export let highlight
</script>

<div class='section-top' class:highlight>
  <div class='section-header'>
    <h1>{headerText}</h1>
    <p class='description'>{sectionDescription}</p>
  </div>
  {#if rotating && dontMissAlbum}
    <div class='button-container'>
      <button 
        transition:fade 
        class='play-last-button' 
        class:playing
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
  {/if}
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

  .highlight h1 {
    color: var(--white);
  }

  .highlight p {
    color: var(--light-grey);
  }

  .section-top {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: flex-end;
  }

  .description {
    margin-bottom: 30px;
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
    border: 1px solid var(--transparent-orange);
    background-color: var(--light-grey);
    border-radius: 0;
    cursor: pointer;
  }

  .play-last-button::after {
    content: '';
    position: absolute;
    background-color: var(--black);
    opacity: 0;
    top: 4px;
    left: 4px;
    height: 100%;
    width: 100%;
    z-index: -2;
    animation: fade-in 1s 0.5s ease-in forwards;
    border-radius: 0;
  }

  .play-last-button:hover{
    top: -1px;
    left: -1px;
  }

  .play-last-button:hover::after {
    top: 5px;
    left: 5px;
  }
  
  .play-last-button.mousedown {
     top: 0px;
     left: 0px;
  }

 .play-last-button.mousedown::after {
    top: 2px;
    left: 2px;
  }

  .playing, .play-last-button.playing:hover {
    top: -2px;
    left: -2px;
  }

  .playing::after, .play-last-button.playing:hover::after {
    top: 5px;
    left: 5px;
  }

  @keyframes fade-in {
    0% {
      opacity: 0;
      background-color: transparent;
    }
    50% {
      background-color: transparent;
    }
    100% {
      opacity: 1;
    }
  }
</style>