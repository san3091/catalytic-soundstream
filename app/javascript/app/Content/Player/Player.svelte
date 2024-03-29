<script>
  import { tweened } from 'svelte/motion'
  import { cubicOut } from 'svelte/easing'
  import { fade } from 'svelte/transition'

  import SoundCloudPlayer from './SoundCloudPlayer/SoundCloudPlayer.svelte'
  import AlbumInfo from './AlbumInfo/AlbumInfo.svelte'
  import { playerIsOpen, appWidth, mobileLayout } from '../../stores.js'
  
  export let playingAlbum

  let width = tweened(50, { easing: cubicOut, duration: 400 })
  let heightOffset = tweened(-9000, { easing: cubicOut, duration: 400 })
  let isClosed = false
  let playerArrow = 'keyboard_arrow_right'
  let playerHeight = -9000
  
  const toggleOpen = () => {
    playerIsOpen.set(!$playerIsOpen)
  }

  const close = () => {
    playerIsOpen.set(false)
    isClosed = true
  }

  const calcPlayerWidth = () => {
    return $appWidth < 1200 ? 400 : 550
  }

  const layout = $mobileLayout
  const open = $playerIsOpen

  const setArrowIcon = (playerIsOpen, mobileLayout) => {
    if (layout) {
      if (open) {
        playerArrow = 'keyboard_arrow_down'
      } else {
        playerArrow = 'keyboard_arrow_up'
      }
    } else {
      if (open) {
        playerArrow = 'keyboard_arrow_right'
      } else {
        playerArrow = 'keyboard_arrow_left'
      }
    }
  }
  
  $: setArrowIcon($playerIsOpen, $mobileLayout)
  $: $playerIsOpen ? width.set(calcPlayerWidth($appWidth)) : width.set(48)
  $: $playerIsOpen ? heightOffset.set(0) : heightOffset.set(-playerHeight + 48)
  $: if ($playerIsOpen) { isClosed = false }
</script>

<div 
  class='player' 
  class:mobile={$mobileLayout}
  bind:clientHeight={playerHeight}
  style='--width:{$width}px; --height-offset:{$heightOffset}px'>
  <button class='slide-button' on:click={toggleOpen} >
    <i transition:fade class="material-icons">{playerArrow}</i>
  </button>
  {#if !isClosed}
    <div transition:fade class='player-content'>
      <SoundCloudPlayer playingAlbum={playingAlbum} />
      <AlbumInfo album={playingAlbum} />
    </div>
  {/if}
</div>

<style>
  .player {
    pointer-events: all;
    box-sizing: border-box;
    display: flex;
    flex-direction: row;
    min-width: var(--width);
    max-width: var(--width);
    border-left: 1px solid var(--red-orange);
    background-color: var(--light-grey);
    z-index: 1;
  }

  .player-content {
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    overflow-y: scroll;
    width: 100%;
    padding: 48px;
    padding-left: 0;
  }

  button, button:active {
    background-color: transparent;
    cursor: pointer;
    border: none;
  }

  .slide-button {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
  }

  .slide-button i {
    flex: 1;
    margin: 10px;
    font-size: 32px;
    transition: color 0.1s ease-in-out;
  }

  .slide-button:hover i {
    color: var(--orange);
  }

  .mobile {
    z-index: 2;
    flex-direction: column;
    min-width: 100%;
    border-left: none;
    border-top: 1px solid var(--orange);
    overflow: visible;
    position: absolute;
    bottom: var(--height-offset);
  }

  .mobile .player-content {
    margin: 0;
    padding: 0 25px 25px;
  }

  .mobile .slide-button {
    width: 100%;
  }
  
  .mobile .slide-button i {
    max-width: 28px;
  }
</style>