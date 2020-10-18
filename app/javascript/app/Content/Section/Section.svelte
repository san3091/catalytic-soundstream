<script>

  import Carousel from './Carousel/Carousel.svelte'
  import SectionHeading from './SectionHeading/SectionHeading.svelte'
  import AlbumDetails from './AlbumDetails/AlbumDetails.svelte'
  import { user, padding } from '../../stores.js'

  export let headerText
  export let sectionDescription
  export let sectionNumber
  export let selectAlbum
  export let selectedAlbum
  export let playingAlbum
  export let playAlbum
  export let highlight
  export let albums = []

  let width

  const setPadding = (width) => {
    if (width < 1000) { return 10 }
    else if (width < 1100) { return 20 }
    else { return 50 }
  }

  const setDontMissAlbum = (albums, user) => albums[albums.length - 1]

  const assignIndices = (albums) => {
    albums.reverse().forEach((album, index) => {
      album.index = index
    });
  }

  const deselectAlbum = () => { selectedAlbum = null }

  $: assignIndices(albums)
  $: padding.set(setPadding(width))
  $: dontMissAlbum = setDontMissAlbum(albums, $user)
  $: rotating = sectionNumber == 0
</script>

<div 
  class='section' 
  class:highlight
  bind:clientWidth={width} 
  style='--padding:{$padding}px' >
  <SectionHeading 
    headerText={headerText} 
    sectionDescription={sectionDescription}
    rotating={rotating}
    dontMissAlbum={dontMissAlbum}
    highlight={highlight}
    selectAlbum={selectAlbum}
    selectedAlbum={selectedAlbum}
    />
  <Carousel 
    albums={albums} 
    playAlbum={playAlbum} 
    selectAlbum={selectAlbum}
    playingAlbum={playingAlbum}
    rotating={rotating}
    highlight={highlight}
    selectedAlbum={selectedAlbum}
    dontMissIndex={dontMissAlbum && dontMissAlbum.index} />
  {#if albums.includes(selectedAlbum)}
    <AlbumDetails 
      playAlbum={playAlbum}
      selectedAlbum={selectedAlbum}
      highlight={highlight}
      deselectAlbum={deselectAlbum} />
  {/if}
</div>

<style>
  .section {
    box-sizing: border-box;
    padding: 0 var(--padding);
  }

  .highlight {
    background-color: var(--dark-grey);
  }
</style>