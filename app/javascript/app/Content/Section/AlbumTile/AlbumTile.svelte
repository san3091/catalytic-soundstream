<script>
  import { onMount } from 'svelte'
  import { fade } from 'svelte/transition'
  import { user } from '../../../stores.js'
  import LoadingTile from './LoadingTile/LoadingTile.svelte'

  export let album
  export let selectAlbum
  export let selected
  export let tileWidth
  export let dontMiss
  export let newToday

  let mousedown
  let thumbnail = album.thumbnail_url

  const loadSoundcloudData = async () => {
    await SC.oEmbed(album.soundcloud_url)
      .then(SCAlbum => {
        const { html, thumbnail_url} = SCAlbum
        const free = album.index == 0
        thumbnail = thumbnail_url
        Object.assign(album, {html, free})
      })
  }

  $: enabled = $user || album.index == 0
  $: tilePadding = (tileWidth > 180) ? 8 : 4
  
  onMount(async () => {
    await loadSoundcloudData()
  })
</script>

<div 
  class='tile-container' 
  class:new-today={newToday}
  class:dont-miss={dontMiss}
  on:click|stopPropagation={() => {selectAlbum(album)}}
  on:mousedown|stopPropagation={() => { mousedown = true } }
  on:mouseup|stopPropagation={() => { mousedown = false } }
  on:mouseleave|stopPropagation={() => { mousedown = false } } 
  style='
    --size:{tileWidth - (tilePadding * 2)}px; 
    --tile-padding:{tilePadding}px;
  ' >
  {#if thumbnail && tileWidth}
    {#if !enabled}
      <div class='album-art-screen'>
        <i class='material-icons'>lock_open</i>
      </div>
    {/if}
    <button 
      transition:fade
      class='album-tile'
      class:selected
      class:enabled
      class:mousedown
      style='--color:{album.color || "#666a86"};'>
      <div class='album-art'>
        <div class='thumbnail'>
          <img src={thumbnail} alt={`${album.title} album art`} />
        </div>
      </div>
      <div class='album-info'>
        <h4 class='truncate'>{album.title}</h4>
        <h6 class='truncate'>{album.artist}</h6>
      </div>
    </button>
  {:else if tileWidth}
    <LoadingTile tileWidth={tileWidth} tilePadding={tilePadding} />
  {/if}
</div>

<style>

  h4 {
    margin-bottom: 4px;
    color: black;
  }

  h6 {
    font-weight: 500;
  }
  
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
    padding: var(--tilePadding);
    margin-bottom: 2px;
  }

  .tile-container.new-today::after {
    opacity: 0;
    content: 'NEW TODAY';
    position: absolute;
    color: var(--orange);
    bottom: -20px;
    left: -8px;
    font-size: 20px;
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;
  }
 
  .tile-container.dont-miss::after {
    opacity: 0;
    content: "DON'T MISS";
    position: absolute;
    bottom: -20px;
    left: -8px;
    font-size: 20px;
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
    border: none;
  }

  .album-art {
    position: relative;
    box-sizing: border-box;
  }

  .album-art::after {
    content: '';
    position: absolute;
    background-color: var(--medium-grey);
    top: 0;
    left: 0;
    opacity: 0;
    height: 100%;
    width: 100%;
    z-index: -2;
    animation: fade-in 1s 0.5s ease-in forwards;
  }

  .enabled .album-art {
    border: none;
  }

  .enabled .album-art::after {
    background-color: var(--black);
  }

  .selected.enabled .album-art::after {
    background-color: var(--dark-grey);
  }
  
  .thumbnail { 
    overflow: hidden
  }

  .album-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    flex-grow: 1;
    width: var(--size);
    box-sizing: border-box;
    padding: 10px 0 10px 20px;
  }

  .album-art-screen {
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    z-index: 1;
    width: var(--size);
    height: var(--size);
    opacity: 0;
    transition: opacity .4s ease;
    background-color: var(--transparent-grey);
  }

  .material-icons {
    font-size: 32px;
    color: var(--light-grey);
  }

  .tile-container:hover .album-art-screen {
    opacity: 1;
  }

  .album-info * {
    text-align: left;
  }
  
  img {
    height: var(--size);
  }

  .enabled img {
    filter: none;
  }

  .album-tile.enabled .album-art {
    top: -2px;
    left: -2px;
  }

  .album-tile.enabled .album-art::after {
    top: 2px;
    left: 2px;
  }

  .album-tile.enabled:hover .album-art {
    top: -4px;
    left: -4px;
  }

  .album-tile.enabled:hover .album-art::after {
    top: 4px;
    left: 4px;
  }

 .album-tile.enabled.mousedown .album-art {
    top: -2px;
    left: -2px;
  }

 .album-tile.enabled.mousedown .album-art::after {
    top: 2px;
    left: 2px;
  }

  .enabled.selected .album-art {
    top: -6px;
    left: -6px;
  }
  
  .enabled.selected .album-art::after {
    top: 6px;
    left: 6px;
  }
 
  .enabled.selected:hover .album-art {
    top: -6px;
    left: -6px;
  }
  
  .enabled.selected:hover .album-art::after {
    top: 6px;
    left: 6px;
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