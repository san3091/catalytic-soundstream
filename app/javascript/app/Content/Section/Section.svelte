<script>
  import { fade } from 'svelte/transition'
  import Carousel from './Carousel/Carousel.svelte'

  export let headerText
  export let sectionDescription
  export let sectionNumber
  export let selectedAlbum
  export let selectAlbum
  export let albums = []

  let width

  const playLastAlbum = () => {
    selectAlbum(lastAlbum)
  }

  $: albums = rotating ? albums.slice(1) : albums
  $: padding = (width > 1300) ? '100px' : '50px'
  $: lastAlbum = albums[albums.length - 1]
  $: rotating = sectionNumber == 0
  $: selected = lastAlbum == selectedAlbum
</script>


{#if albums.length}
  <div class='section' bind:clientWidth={width} style='--padding:{padding}' >
    <div class='section-top'>
      <div class='section-header'>
        <h2>{headerText}</h2>
        <p>{sectionDescription}</p>
      </div>
      {#if rotating && lastAlbum.title}
        <div class='button-container'>
          <button 
            transition:fade 
            class='play-last-button' 
            class:selected
            on:click={playLastAlbum}>
            <h5>
              <b>DON'T MISS:</b>{lastAlbum.title}
            </h5>
          </button>
        </div>
      {/if}
    </div>
    <Carousel 
      albums={albums} 
      selectAlbum={selectAlbum} 
      selectedAlbum={selectedAlbum}
      rotating={rotating} />
  </div>
{/if} 

<style>
  h2, p {
    margin-left: 50px;
  }

  b {
    margin-right: 10px;
    color: var(--medium-grey)
  }

  .section {
    box-sizing: border-box;
    width: 100%;
    padding: 0 var(--padding);
  }

  .section-top {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: flex-end;
  }

  .button-container {
    padding-bottom: 40px;
    margin-right: 20px;
  }

  .play-last-button {
    position: relative;
    padding: 5px 15px;
    border: none;
    background: #666a86;
    color: var(--light-grey);
    height: 40px;
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
  }

  .play-last-button:hover{
    top: -2px;
    left: -2px;
  }

  .play-last-button:hover::after {
    top: 6px;
    left: 6px;
  }

  .selected, .play-last-button.selected:hover {
    top: -4px;
    left: -4px;
  }

  .selected::after, .play-last-button.selected:hover::after {
    top: 8px;
    left: 8px;
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