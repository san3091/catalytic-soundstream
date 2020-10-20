<script>
  import { fade } from 'svelte/transition'

  import { playable } from '../../../../../helpers'
  import { user } from '../../../../../stores'
  export let playing
  export let thumbnail
  export let album
  export let highlight
  export let hover
  export let selected
  export let mousedown
</script>

<div class='album-art' 
  class:highlight 
  class:hover
  class:selected
  class:mousedown
  class:playable={playable(album, $user)} >
  <div class='thumbnail'>
    {#if playing}
      <i class='material-icons' in:fade >play_circle_outline</i>
    {:else if !playable(album, $user)}
      <div class='lock-icon'>
        <i class='material-icons lock'>lock</i>
      </div>
    {:else if selected && hover}
      <i class='material-icons' in:fade >play_arrow</i>
    {/if}
    <img src={thumbnail} alt={`${album.title} album art`} />
  </div>
</div>

<style>
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

  .highlight.album-art::after {
    background-color: var(--transparent-orange);
  }

  i {
    position: absolute;
    z-index: 1;
    font-size: 50px;
    color: var(--orange);
  }

  .lock-icon {
    display: flex;
    position: absolute;
    width: 100%;
    height: 100%;
    justify-content: flex-end;
    align-items: flex-end;
  }

  .lock {
    font-size: 30px;
    color: var(--red-orange);
    margin: 10px;
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

  .hover.album-art {
    top: -3px;
    left: -4px;
  }

  .hover.album-art::after {
    opacity: 1;
    top: 3px;
    left: 4px;
  }

  .selected.album-art {
    top: -6px;
    left: -8px;
  }

  .selected.album-art::after {
    top: 6px;
    left: 8px;
    opacity: 1;
    background-color: var(--red-orange);
  }

  .selected.playable.album-art::after {
    background-color: var(--orange);
  }

  .mousedown.album-art {
    top: -2px;
    left: -3px;
  }

 .mousedown.album-art::after {
    top: 2px;
    left: 3px;
  }
</style>