<script>
  import { tweened } from 'svelte/motion'
  import { cubicOut } from 'svelte/easing'
  import { fade } from 'svelte/transition'

  import SoundCloudPlayer from './SoundCloudPlayer/SoundCloudPlayer.svelte'
  import AlbumInfo from './AlbumInfo/AlbumInfo.svelte'
  import { playerOpen } from '../../stores.js'
  
  export let selectedAlbum

  let width = tweened(50, { easing: cubicOut, duration: 400 })
  let isClosed = false
  
  const toggleOpen = () => {
    playerOpen.set(!$playerOpen)
  }

  const close = () => {
    playerOpen.set(false)
    isClosed = true
  }

  $: $playerOpen ? width.set(500) : width.set(50)
  $: if ($playerOpen) { isClosed = false }
</script>

<div class='player' style='--width:{$width}px'>
  <button class='slide-button' on:click={toggleOpen} >
    {#if $playerOpen}
      <i transition:fade class="material-icons">keyboard_arrow_right</i>
    {:else}
      <i transition:fade class="material-icons">keyboard_arrow_left</i>
    {/if}
  </button>
  {#if $playerOpen}
    <button 
      transition:fade
      class='close-button' 
      on:click={close}>
      <i class="material-icons">close</i>
    </button>
  {/if}
  {#if !isClosed}
    <div transition:fade class='player-content'>
      <AlbumInfo album={selectedAlbum} />
      <SoundCloudPlayer selectedAlbum={selectedAlbum} />
    </div>
  {/if}

</div>

<style>
  .player {
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    position: relative;
    min-width: var(--width);
    max-width: var(--width);
    /* border-left: 1px solid #3e3e3e; */
    border-left: 1px solid #f96854;
  }

  .player-content {
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    overflow-y: scroll;

    width: 100%;
    margin: 50px 0;
    padding: 25px 50px 0 0;
  }

  button, button:active {
    background-color: transparent;
    cursor: pointer;
    border: none;
  }

  .close-button {
    position: absolute;
    top: 0;
    right: 0;
    margin: 10px;
  }

  .slide-button {
    position: relative;
    height: 100%;
    min-width: 50px;
  }

  .slide-button i {
    position: absolute;
    left: 0;
    margin-left: 10px;
  }

  .material-icons {
    margin: 10px;
    font-size: 28px;
  }
</style>