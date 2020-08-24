<script>
  import { onMount } from 'svelte'
  import Search from './Search/Search.svelte'
  import Section from './Section/Section.svelte'
  import Player from './Player/Player.svelte'
  import Mission from './Mission/Mission.svelte'
  import Footer from './Footer/Footer.svelte'

  import { playerIsOpen, modalIsOpen, user, mobileLayout } from '../stores.js'
  
  let categories
  let selectedAlbum

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
      selectedAlbum = firstAlbum
    })
  }

  const selectAlbum = (album) => {
    if (album.free || ($user && $user.is_member)) {
      playerIsOpen.set(true)
      selectedAlbum = album
    } else {
      modalIsOpen.set(true)
    }
  }

  onMount(async () => {
    await getAlbums()
    selectFirstAlbum()
  })

</script>

<div class='content' class:mobile={$mobileLayout}>
  <div class='music-selection' class:mobile={$mobileLayout}> 
    <Mission />
    {#if categories}
      <Section
        headerText='Radio'
        sectionDescription='Explore a rotating selection of music from Catalytic Sound, curated by co-op artists. One album in, one out—every day'
        sectionNumber={0}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        albums={categories[1].albums} />
      <Section 
        headerText='Catalytic Artist Albums'
        sectionDescription='Experience the complete series of member-exclusive monthly digital releases.'
        sectionNumber={1}
        highlight={true}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        albums={categories[2].albums} />
      <Section 
        headerText="History is What's Happening"
        sectionDescription='Discover classics from the Catalytic Sound catalog.'
        sectionNumber={2}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        albums={categories[0].albums} />
    {/if}
    <Footer />
  </div>
  <div 
    class='player-container' 
    class:mobile={$mobileLayout}>
    <Player selectedAlbum={selectedAlbum} />
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
  }
   
  .content.mobile {
    flex-direction: column;
  }

  .music-selection {
    position: relative;
    padding-top: 25px;
    display: flex;
    flex-direction:column;
    width: 0;
    flex-grow: 1;
    overflow-y: scroll;
  }

  .music-selection.mobile {
    width: 100%;
  }

  .player-container {
    display: flex;
    right: 0;
  }

  .player-container.mobile {
    position: fixed;
    z-index: 5;
    pointer-events: none;
    right: unset;
    top: unset;
    bottom: 0;
    width: 100%;
  }

</style>