<script>
  import { onMount } from 'svelte'
  import Search from './Search/Search.svelte'
  import Section from './Section/Section.svelte'
  import Player from './Player/Player.svelte'
  import Mission from './Mission/Mission.svelte'
  import Footer from './Footer/Footer.svelte'

  import { playerIsOpen, modalIsOpen, user, mobileLayout, selectionWidth } from '../stores.js'
  import { playable } from '../helpers.js'

  let categories
  let selectedAlbum
  let playingAlbum
  let width

  const getAlbums = async () => {
    const url = '/categories'
    const response = await fetch(url)
    categories = await response.json()
  }

  const selectFirstAlbum = () => {
    const firstAlbum = categories[1].albums[0]
    SC.oEmbed(firstAlbum.soundcloud_url)
    .then(SCAlbum => {
      const { html, thumbnail_url} = SCAlbum
      Object.assign(firstAlbum, {html, thumbnail_url})
      playingAlbum = firstAlbum
    })
  }

  const playAlbum = (album) => {
    if (playable(album, $user)) {
      playerIsOpen.set(true)
      playingAlbum = album
    } else {
      modalIsOpen.set(true)
    }
  }

  const selectAlbum = (album) => { selectedAlbum = album }

  $: selectionWidth.set(width)

  onMount(async () => {
    await getAlbums()
    selectFirstAlbum()
  })

</script>

<div class='content' class:mobile={$mobileLayout}>
  <div class='music-selection' class:mobile={$mobileLayout} 
    bind:clientWidth={width} >
    <Mission />
    {#if categories}
      <Section
        headerText='Catalytic Radio'
        sectionDescription='A rotating selection of music from the expanding Catalytic Sound catalog, curated by co-op artists and staff. One album in, one out—every day.'
        sectionNumber={0}
        playAlbum={playAlbum}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        playingAlbum={playingAlbum}
        albums={categories[1].albums} />
      <!-- <Section
        headerText='Label Radio'
        sectionDescription='A curated mix of albums from core and guest labels each month. A new recording rotated daily.'
        sectionNumber={4}
        playAlbum={playAlbum}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        playingAlbum={playingAlbum}
        albums={categories[3].albums} /> -->
      <Section
        headerText='Catalytic Artist Albums'
        sectionDescription='The complete and ongoing series of member-exclusive monthly digital releases.'
        sectionNumber={1}
        highlight={true}
        playAlbum={playAlbum}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        playingAlbum={playingAlbum}
        albums={categories[2].albums} />
      <Section
        headerText="History is What's Happening"
        sectionDescription='A selection of ten classics from the Catalytic Sound catalog, updated monthly.'
        sectionNumber={2}
        playAlbum={playAlbum}
        selectAlbum={selectAlbum}
        playingAlbum={playingAlbum}
        selectedAlbum={selectedAlbum}
        albums={categories[0].albums} />
    {/if}
    <Footer />
  </div>
  <div
    class='player-container'
    class:mobile={$mobileLayout}>
    <Player playingAlbum={playingAlbum} />
  </div>
</div>

<style>
  .content {
    position: relative;
    display: flex;
    flex-direction: row;
    justify-content: stretch;
    width: 100%;
    height: calc(100vh - 82px);
    overflow: hidden;
  }

  .content.mobile {
    flex-direction: column;
  }

  .music-selection {
    padding-top: 25px;
    display: flex;
    flex-direction:column;
    overflow-y: scroll;
    overflow-x: hidden;
    width: 100%;
    max-height: 100%;
  }

  .music-selection.mobile {
    width: 100%;
  }

  .player-container {
    display: flex;
    right: 0;
  }

  .player-container.mobile {
    position: absolute;
    z-index: 4;
    pointer-events: none;
    right: unset;
    top: unset;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
  }

</style>
