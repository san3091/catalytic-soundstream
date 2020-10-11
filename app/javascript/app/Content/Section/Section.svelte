<script>

  import Carousel from './Carousel/Carousel.svelte'
  import SectionHeading from './SectionHeading/SectionHeading.svelte'
  import { user, padding } from '../../stores.js'

  export let headerText
  export let sectionDescription
  export let sectionNumber
  export let selectedAlbum
  export let selectAlbum
  export let highlight
  export let albums = []

  let width
  let mousedown
  
  const playDontMissAlbum = () => {
    selectAlbum(dontMissAlbum)
  }

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

  $: assignIndices(albums)
  $: padding.set(setPadding(width))
  $: dontMissAlbum = setDontMissAlbum(albums, $user)
  $: rotating = sectionNumber == 0
  $: selected = dontMissAlbum == selectedAlbum
</script>

<div 
  class='section' 
  class:highlight
  bind:clientWidth={width} 
  style='--padding:{$padding}px' >
  <SectionHeading 
    headerText={headerText} 
    sectionDescription={sectionDescription}
    selected={selected}
    rotating={rotating}
    dontMissAlbum={dontMissAlbum}
    mousedown={mousedown}
    />
  <Carousel 
    albums={albums} 
    selectAlbum={selectAlbum} 
    selectedAlbum={selectedAlbum}
    rotating={rotating}
    highlight={highlight}
    dontMissIndex={dontMissAlbum && dontMissAlbum.index} />
</div>

<style>
  h2, p {
    margin-left: 50px;
  }

  b {
    font-weight: 400;
    margin-right: 10px;
    color: var(--orange);
  }

  span {
    color: var(--black);
  }

  h6 {
    text-align: left;
		white-space: unset;
  }

  .section {
    box-sizing: border-box;
    padding: 0 var(--padding);
  }

  .highlight {
    background-color: var(--dark-grey);
  }

  .highlight h2 {
    color: var(--white);
  }

  .highlight p {
    color: var(--light-grey);
  }

  .section-top {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: flex-end;
  }

  .description {
    margin-bottom: 30px;
  }

  .button-container {
    padding-bottom: 40px;
    margin-right: 20px;
  }

  .play-last-button {
    position: relative;
    padding: 5px 15px;
    border: none;
    box-sizing: border-box;
    /* background-color: var(--transparent-orange); */
    border: 1px solid var(--transparent-orange);
    background-color: var(--light-grey);
    border-radius: 0;
    cursor: pointer;
  }

  .play-last-button::after {
    content: '';
    position: absolute;
    background-color: var(--black);
    opacity: 0;
    top: 4px;
    left: 4px;
    height: 100%;
    width: 100%;
    z-index: -2;
    animation: fade-in 1s 0.5s ease-in forwards;
    border-radius: 0;
  }

  .play-last-button:hover{
    top: -1px;
    left: -1px;
  }

  .play-last-button:hover::after {
    top: 5px;
    left: 5px;
  }
  
  .play-last-button.mousedown {
     top: 0px;
     left: 0px;
  }

 .play-last-button.mousedown::after {
    top: 2px;
    left: 2px;
  }

  .selected, .play-last-button.selected:hover {
    top: -2px;
    left: -2px;
  }

  .selected::after, .play-last-button.selected:hover::after {
    top: 5px;
    left: 5px;
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