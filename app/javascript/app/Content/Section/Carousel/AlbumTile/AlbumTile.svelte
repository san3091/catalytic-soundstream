<script>
  import { onMount } from 'svelte'
  import { fade } from 'svelte/transition'
  import { user } from '../../../../stores.js'
  import LoadingTile from './LoadingTile/LoadingTile.svelte'
  import AlbumTileInfo from './AlbumTileInfo/AlbumTileInfo.svelte'

  export let album
  export let selected
  export let selectAlbum
  export let playing
  export let tileWidth
  export let highlight
  export let dontMiss
  export let newToday

  let mousedown
  let thumbnail = album.thumbnail_url
  
  const loadSoundcloudData = async () => {
    await SC.oEmbed(album.soundcloud_url, { auto_play: true })
      .then(SCAlbum => {
        const { html, thumbnail_url} = SCAlbum
        const free = album.index == 0
        thumbnail = thumbnail_url
        Object.assign(album, {html, free})
      })
  }

  $: enabled = ($user && $user.is_member) || album.index == 0
  $: tilePadding = (tileWidth > 180) ? 8 : 4

  onMount(async () => {
    await loadSoundcloudData()
  })
</script>

<div
  class='tile-container'
  class:highlight
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
    <button
      transition:fade
      class='album-tile'
      class:playing
      class:selected
      class:mousedown >
      <div class='album-art'>
        <div class='thumbnail'>
          {#if playing}
            <i in:fade class='material-icons'>play_circle_outline</i>
          {/if}
          <img src={thumbnail} alt={`${album.title} album art`} />
        </div>
      </div>
      <AlbumTileInfo album={album} highlight={highlight} />
    </button>
  {:else if tileWidth}
    <LoadingTile tileWidth={tileWidth} tilePadding={tilePadding} />
  {/if}
</div>

<style>
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
    font-size: 18px;
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
    font-size: 18px;
    color: var(--orange);
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;
  }

  .album-tile {
    z-index: 1;
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
    top: -1px;
    left: -1px;
    height: 100%;
    width: 100%;
    z-index: -1;
    opacity: 0;
    background-color: var(--black);
  }

  .highlight .album-art::after {
    background-color: var(--transparent-orange);
  }

  i {
    position: absolute;
    z-index: 4;
    font-size: 50px;
    color: var(--orange);
  }

  .thumbnail {
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  img {
    height: var(--size);
  }

  .album-tile:hover .album-art {
    top: -3px;
    left: -4px;
  }

  .album-tile:hover .album-art::after {
    opacity: 1;
    top: 3px;
    left: 4px;
  }

  .album-tile.selected .album-art {
    top: -6px;
    left: -8px;
  }

  .album-tile.selected .album-art::after {
    top: 6px;
    left: 8px;
    opacity: 1;
    background-color: var(--orange);
  }

  .album-tile.mousedown .album-art {
    top: -2px;
    left: -3px;
  }

 .album-tile.mousedown .album-art::after {
    top: 2px;
    left: 3px;
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
