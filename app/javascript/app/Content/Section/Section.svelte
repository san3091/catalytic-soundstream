<script>
  import { fade } from 'svelte/transition'
  import { tweened } from 'svelte/motion'
  import { cubicOut } from 'svelte/easing'
  import Carousel from './Carousel/Carousel.svelte'
  import { user } from '../../stores.js'

  export let headerText
  export let sectionDescription
  export let sectionNumber
  export let selectedAlbum
  export let selectAlbum
  export let albums = []

  let width
  let mousedown
  let padding = tweened(100, { easing: cubicOut, duration: 400 })
  const playDontMissAlbum = () => {
    selectAlbum(dontMissAlbum)
  }

  const setPadding = (width) => {
    if (width < 1000) { return 10 }
    else if (width < 1100) { return 50 }
    else { return 100 }
  }

  const setDontMissAlbum = (albums, user) => {
    if (!user) { 
      const loadedAlbums = albums.filter(album => !album.loading)
      const freeAlbums = loadedAlbums.filter(album => album.free)
      const lastFreeAlbum = freeAlbums[freeAlbums.length - 1]
      if (lastFreeAlbum) { return lastFreeAlbum }
    }
    
    return albums[albums.length - 1]
  }

  $: albums = rotating ? albums.slice(1) : albums
  $: padding.set(setPadding(width))
  $: dontMissAlbum = setDontMissAlbum(albums, $user)
  $: rotating = sectionNumber == 0
  $: selected = dontMissAlbum == selectedAlbum
</script>


{#if albums.length}
  <div class='section' bind:clientWidth={width} style='--padding:{$padding}px' >
    <div class='section-top'>
      <div class='section-header'>
        <h2>{headerText}</h2>
        <p>{sectionDescription}</p>
      </div>
      {#if rotating && dontMissAlbum.title}
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
            <h5>
              <b>DON'T MISS:</b>{dontMissAlbum.title}
            </h5>
          </button>
        </div>
      {/if}
    </div>
    <Carousel 
      albums={albums} 
      selectAlbum={selectAlbum} 
      selectedAlbum={selectedAlbum}
      rotating={rotating}
      dontMissIndex={dontMissAlbum.index} />
  </div>
{/if} 

<style>
  h2, p {
    margin-left: 50px;
  }

  b {
    margin-right: 10px;
    color: var(--medium-grey);
    /* color: var(--light-grey); */
    /* color: white; */
  }

  h5 {
    color: white;
    /* color: var(--black); */
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
    /* background-color: var(--medium-grey); */
    background-color: var(--orange);
    /* background-color: var(--light-grey); */
    height: 40px;
    border-radius: 0;
    cursor: pointer;
  }

  .play-last-button::after {
    content: '';
    position: absolute;
    background-color: var(--black);
    opacity: 0;
    top: 2px;
    left: 2px;
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
    top: 3px;
    left: 3px;
  }
  
  .play-last-button.mousedown {
     top: 0px;
     left: 0px;
  }

 .play-last-button.mousedown::after {
    top: 2px;
    left: 2px;
  }

  .selected, .play-last-button.selected:hover {
    top: -2px;
    left: -2px;
  }

  .selected::after, .play-last-button.selected:hover::after {
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