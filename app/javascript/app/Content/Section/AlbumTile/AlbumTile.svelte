<script>
  import { onMount } from 'svelte'
  import { fade } from 'svelte/transition'
  import { user } from '../../../stores.js'

  export let album
  export let selectAlbum
  export let selected
  export let tileWidth
  export let rotating
  export let dontMiss

  let mousedown

  $: disabled = album.free || $user ? false : true

  $: loaded = !album.loading
  $: extraTextVisibility = rotating && loaded ? 'visible' : 'hidden'
  $: padding = (tileWidth > 180) ? 12 : 8
  
  onMount(() => {
    SC.oEmbed(album.soundcloud_url)
    .then(SCAlbum => {
      const { html, thumbnail_url} = SCAlbum
      Object.assign(album, {html, thumbnail_url})
      album.free = true
    })
  })
</script>

<div 
  class='tile-container' 
  class:dont-miss={dontMiss}

  style='
    --size:{tileWidth - (padding * 2)}px; 
    --visibility:{extraTextVisibility};
    --padding:{padding}
  ' >
  {#if album.thumbnail_url && tileWidth}
    {#if disabled}
      <div class='album-art-screen'>
        <i class='material-icons'>lock_open</i>
      </div>
    {/if}
    <button 
      transition:fade
      class='album-tile'
      class:selected
      class:disabled
      class:mousedown
      style='--color:{album.color || "#666a86"};'
      on:click|stopPropagation={() => {selectAlbum(album)}}
      on:mousedown|stopPropagation={() => { mousedown = true } }
      on:mouseup|stopPropagation={() => { mousedown = false } }
      on:mouseleave|stopPropagation={() => { mousedown = false } } >
      <div class='album-art'>
        <img src={album.thumbnail_url} alt={`${album.title} album art`} />
      </div>
      <div class='album-info'>
        <h5 class='truncate'>{album.title}</h5>
        <h6 class='truncate'>{album.artist}</h6>
      </div>
    </button>
  {/if}
</div>


<style>
  .truncate {
    position: relative;
    right: 10px;
    width: calc(var(--tile-width) - 35px);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .tile-container {
    box-sizing: border-box;
    width: var(--tile-width);
    position: relative;
    display: flex;
    padding: var(--padding);
    margin-bottom: 2px;
  }

  .tile-container:first-child::after {
    visibility: var(--visibility);
    opacity: 0;
    content: 'NEW TODAY';
    position: absolute;
    color: var(--orange);
    bottom: -20px;
    size: 20px;
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;
  }
 
  .tile-container.dont-miss::after {
    visibility: var(--visibility);
    opacity: 0;
    content: "DON'T MISS";
    position: absolute;
    bottom: -20px;
    size: 20px;
    color: var(--orange);
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;
  }

  .album-tile {
    position: relative;
    display: flex;
    flex-direction: column;
    cursor: pointer;
    background-color: transparent;
    /* background-color: var(--light-grey); */
    /* background-color: var(--color); */
    border: none;
  }

  .album-art {
    position: relative;
    box-sizing: border-box;
  }

  .album-art::after {
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
  }

  .selected .album-art::after {
    background-color: var(--medium-grey);
  }

  .album-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    flex-grow: 1;
    width: var(--size);
    box-sizing: border-box;
    margin-top: 8px;
    padding: 10px 0 10px 20px;
  }

  .album-art-screen {
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    top: 2px;
    left: 2px;
    z-index: 1;
    width: var(--size);
    height: var(--size);
    background-color: var(--translucent-grey);
    pointer-events: none;
  }

  .material-icons {
    font-size: 32px;
    color: var(--light-grey);
  }

  .album-info * {
    text-align: left;
    /* color: white; */
  }
  
  img {
    height: var(--size);
  }

  .album-tile:hover .album-art {
    top: -1px;
    left: -1px;
  }

  .album-tile:hover .album-art::after {
    top: 3px;
    left: 3px;
  }


  .album-tile.mousedown .album-art{
     top: 0px;
     left: 0px;
  }
  
  .album-tile.mousedown .album-art::after {
    top: 2px;
    left: 2px;
  }
  
  .selected .album-art, .album-tile.selected:hover .album-art {
    top: -4px;
    left: -4px;
  }

  .selected .album-art::after, .album-tile.selected:hover .album-art::after {
    top: 6px;
    left: 6px;
  }

  .album-tile.disabled .album-art {
    top: 2px;
    left: 2px;
  }

  .album-tile.disabled .album-art:after {
    top: 0px;
    left: 0px;
  }

  .album-tile.disabled:hover .album-art::after {
    top: 0px;
    left: 0px;
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