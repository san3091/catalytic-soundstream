<script>
  import { onMount } from 'svelte'
  import { fade } from 'svelte/transition'
  import { user } from '../../../../stores.js'
  import LoadingTile from './LoadingTile/LoadingTile.svelte'
  import AlbumArt from './AlbumArt/AlbumArt.svelte'
  import AlbumTileInfo from './AlbumTileInfo/AlbumTileInfo.svelte'

  export let album
  export let selected
  export let selectAlbum
  export let playAlbum
  export let playing
  export let tileWidth
  export let highlight
  export let dontMiss
  export let newToday

  let mousedown
  let hover

  $: thumbnail = album.thumbnail_url
  $: enabled = ($user && $user.is_member) || album.index == 0
  $: tilePadding = (tileWidth > 180) ? 8 : 4

  const loadSoundcloudData = async (album) => {
    await SC.oEmbed(album.soundcloud_url, { auto_play: true })
      .then(SCAlbum => {
        const { html, thumbnail_url} = SCAlbum
        Object.assign(album, {html, thumbnail_url})
      })
    return album
  }

  const selectOrPlay = (album) => {
    selected ? playAlbum(album) : selectAlbum(album)
  }

  onMount(async () => {
    album = await loadSoundcloudData(album)
  })
</script>

<div
  class='tile-container'
  class:highlight
  class:new-today={newToday}
  class:dont-miss={dontMiss}
  on:click|stopPropagation={() => {selectOrPlay(album)}}
  on:mousedown|stopPropagation={() => { mousedown = true } }
  on:mouseup|stopPropagation={() => { mousedown = false } }
  on:mouseover|stopPropagation={() => { hover = true } }
  on:mouseleave|stopPropagation={() => { mousedown = false; hover = false } }
  style='
    --size:{tileWidth - (tilePadding * 2)}px;
    --tile-padding:{tilePadding}px;
  ' >
  {#if album.thumbnail_url && tileWidth}
    <button
      transition:fade
      class='album-tile' >
      <AlbumArt 
        playing={playing} 
        album={album} 
        thumbnail={thumbnail} 
        highlight={highlight}
        hover={hover}
        selected={selected}
        mousedown={mousedown} />
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
    content: 'JUST ADDED';
    position: absolute;
    color: var(--red-orange);
    bottom: -10px;
    left: -8px;
    font-size: 14px;
    text-align: center;
    width: var(--tile-width);
    animation: fade-in 1s 2s ease-in forwards;
  }

  .tile-container.dont-miss::after {
    opacity: 0;
    content: "DON'T MISS";
    position: absolute;
    bottom: -10px;
    left: -8px;
    font-size: 14px;
    color: var(--red-orange);
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
