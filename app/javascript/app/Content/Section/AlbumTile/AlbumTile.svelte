<script>
  import { fade } from 'svelte/transition'

  export let album
  export let selectAlbum
  export let selected
  export let tileWidth
  export let rotating

  $: loaded = !album.loading
  $: extraTextVisibility = rotating && loaded ? 'visible' : 'hidden'
  $: padding = (tileWidth > 180) ? 10 : 5
</script>

<div 
  class='tile-container' 
  style='
    --size:{tileWidth - (padding * 2)}px; 
    --visibility:{extraTextVisibility};
    --padding:{padding}
  ' >
  {#if !album.loading && tileWidth}
    <button 
      transition:fade
      class='album-tile'
      class:selected
      style='--color:{album.color || "#666a86"};'
      on:click={ selectAlbum(album) } >
      <img src={album.thumbnail_url} />
      <div class='album-info'>
        <h5>{album.title}</h5>
        <h6>{album.author_name}</h6>
      </div>
    </button>
  {/if}
</div>


<style>
  .tile-container {
    box-sizing: border-box;
    width: var(--tile-width);
    position: relative;
    display: flex;
    z-index: 1;
    padding: var(--padding);
    margin-bottom: 15px;
  }

  .tile-container:first-child::after {
    visibility: var(--visibility);
    opacity: 0;
    content: 'NEW TODAY';
    position: absolute;
    bottom: -30px;
    size: 20px;
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;

  }
 
  .tile-container:nth-child(30)::after {
    visibility: var(--visibility);
    opacity: 0;
    content: "DON'T MISS";
    position: absolute;
    bottom: -30px;
    size: 20px;
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;
  }

  .album-tile {
    position: relative;
    display: flex;
    flex-direction: column;
    cursor: pointer;
    background-color: var(--color);
    border: none;
  }

  .album-tile::after {
    content: '';
    position: absolute;
    background-color: #222;
    opacity: 0;
    top: 4px;
    left: 4px;
    height: 100%;
    width: 100%;
    z-index: -2;
    animation: fade-in 1s 0.5s ease-in forwards;
  }

  .album-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    flex-grow: 1;
    width: var(--size);
    box-sizing: border-box;
    padding: 10px;
    background-color: hsl(0, 0%, 0%, 50%);
  }

  .album-info * {
    text-align: left;
  }
  
  img {
    height: var(--size);
  }

  .album-tile:hover{
    top: -2px;
    left: -2px;
  }

  .album-tile:hover::after {
    top: 6px;
    left: 6px;
  }

  .selected, .album-tile.selected:hover {
    top: -4px;
    left: -4px;
  }

  .selected::after, .album-tile.selected:hover::after {
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