<script>
  import { tweened } from 'svelte/motion'
  import { cubicOut } from 'svelte/easing'
  import { fade } from 'svelte/transition'
  import AlbumTile from './AlbumTile/AlbumTile.svelte'
  import ProgressIndicator from './ProgressIndicator/ProgressIndicator.svelte'

  export let albums
  export let playAlbum
  export let selectAlbum
  export let playingAlbum
  export let rotating
  export let highlight
  export let dontMissIndex
  export let selectedAlbum
  
  let carouselWidth, itemsWidth
  let currentSection = 0
  let resizing = false
  let carouselOffset = tweened(0, { easing: cubicOut })
  let tileWidth = tweened(0, { easing: cubicOut, duration: 400 })

  const scroll = (section) => {
    if (scrollable) {
      const lastSection = numberOfSections - 1
      
      if (section > lastSection) { section = lastSection }

      const newScrollPosition = section * carouselWidth
      
      if ((newScrollPosition + carouselWidth) > itemsWidth) {
          carouselOffset.set(itemsWidth - carouselWidth)
      } else {
        carouselOffset.set(section * carouselWidth)
      }
      currentSection = section
    }
  }

  const calcSections = (itemsWidth) => {
    let sections = 0
    if (itemsWidth && carouselWidth) {
      sections = Math.ceil(itemsWidth / carouselWidth)
    }
    return sections
  }

  const previousSection = () => {
    if (currentSection > 0) { currentSection -= 1 }
    scroll(currentSection)
  }

  const nextSection = () => {
    if (currentSection < numberOfSections) { currentSection += 1 }
    scroll(currentSection)
  }

  const resizeTiles = async (carouselWidth) => {
    resizing = true
    await tileWidth.set((carouselWidth / tilesPerScroll))
    resizing = false
  }

  const setNumberOfVisibleTiles = (carouselWidth) => {
    if (carouselWidth < 800) { return 4 }
    else if (carouselWidth < 1300) { return 5 }
    else { return 6 }
  }

  $: tilesPerScroll = setNumberOfVisibleTiles(carouselWidth)
  $: scrollable = itemsWidth > carouselWidth
  $: resizeTiles(carouselWidth)
  $: numberOfSections = calcSections(itemsWidth)
  $: if (carouselWidth || resizing) { scroll(currentSection) }
</script>

<div class='carousel-container'>
  {#if scrollable }
    <ProgressIndicator 
      highlight={highlight}
      numberOfSections={numberOfSections}
      currentSection={currentSection}
      scroll={scroll} />
  {/if}
  <div 
    class='album-carousel'
    class:scrollable
    bind:clientWidth={carouselWidth}>
    {#if currentSection > 0}
      <button 
        class='previous-button'
        transition:fade
        on:click={previousSection}
      >
        <i class="material-icons">keyboard_arrow_left</i>
      </button>
    {/if}
    <div 
      class='carousel-items' 
      style='
        --carousel-offset:{$carouselOffset}px; 
        --tile-width:{$tileWidth}px; 
      '
      bind:clientWidth={itemsWidth}
    >
      {#each albums as album}
        <AlbumTile 
          album={album} 
          selectAlbum={selectAlbum}
          selected={selectedAlbum == album}
          highlight={highlight}
          playAlbum={playAlbum}
          playing={playingAlbum == album}
          tileWidth={$tileWidth}
          newToday={rotating && album.index == 0}
          dontMiss={rotating && album.index == dontMissIndex} />
      {/each}
    </div>
    {#if currentSection < (numberOfSections - 1) }
      <button 
        class='next-button'
        transition:fade
        on:click={nextSection}
      >
        <i class="material-icons">keyboard_arrow_right</i>
      </button>
    {/if}
  </div>
</div>

<style>
  .carousel-container {
    position: relative;
    margin-bottom: 30px;
    width: 100%;
  }
  
  .album-carousel {
    position: relative;
    display: flex;
    overflow: hidden;
    padding: 5px 5px 2px;
  }

  .carousel-items {
    position: relative;
    display: flex;
    flex-direction: row;
    right: var(--carousel-offset);
    margin-bottom: 12px;
  }
  
  button {
    height: 100%;
    position: absolute;
    bottom: 10px;
    width: 80px;
    z-index: 3;
    border: none;
    opacity: 0;
    animation: invisible .4s ease-out forwards;
    margin-bottom: 12px;
  }
  
  .previous-button{
    left: 0;
    background: linear-gradient(-90deg, transparent, var(--transparent-black));
  }

  .next-button {
    right: 0;
    background: linear-gradient(90deg, transparent, var(--transparent-black));
  }

  .material-icons { 
    color: var(--white);
    font-size: 48px;
  }
 
  .scrollable:hover button {
    animation: visible .4s ease-out forwards, lighten .4s ease-out forwards
  }

  .scrollable:hover button:hover {
    animation: darken .4s ease-out forwards, visible .4s ease-out forwards;
  }

  button:hover .material-icons {
    font-size: 52px;
  }

  @keyframes darken {
    0% {
      background-color: transparent;
    }

    100% {
      background-color: var(--tranparent-grey);
    }
  }
 
  @keyframes lighten {
    0% {
      background-color: var(--tranparent-grey);
    }

    100% {
      background-color: transparent;
    }
  }
  
  @keyframes visible {
    0% {
      opacity: 0;
    }

    100% {
      opacity: 1;
    }
  }
  
  @keyframes invisible {
    0% {
      opacity: 1;
    }

    100% {
      opacity: 0;
    }
  }
</style>