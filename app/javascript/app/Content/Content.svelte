<script>
  import { onMount } from 'svelte'
  import { fade } from 'svelte/transition'
  import Search from './Search/Search.svelte'
  import Section from './Section/Section.svelte'
  import Player from './Player/Player.svelte'
  import { playerIsOpen, modalIsOpen, user, mobileLayout, logoHover, padding} from '../stores.js'
  
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
    if (album.free || $user) {
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
    {#if $logoHover}
      <div 
        class='mission'
        style='--mission-padding:{$padding}px'
        transition:fade >
          <p>
            The music streaming industry makes over ten billion dollars each year selling music made by more than a million artists. Despite their reliance on the creativity and labor of musicians, Spotify, Apple, Google, and other streaming services pay artists almost nothing, and treat musicians as replaceable cogs in a content-production machine.
          </p>
          <p>
            The Catalytic Soundstream is our solution to this systemic imbalance: a subscription-based, artist owned and curated streaming service that pays Catalytic Sound co-op musicians 2/3 of all streaming revenue.  
          </p>
          <p>
            Subscribers will enjoy a constantly shifting set of albums on the Soundstream each month: a Radio selection of thirty rotating albums chosen by Catalytic artists and staff, the continuing set of Catalytic Artist Album editions, and History Is What's Happening, a handpicked selection of records released before the new millennium. In the process they'll contribute to a new kind of music streaming service, one that provides an ongoing and equitable source of income for the musicians responsible for its creative content.
          </p>
        </div>
      {/if}
    {#if categories}
      <Section
        headerText='Catalytic Radio'
        sectionDescription='Explore a rotating selection of music from Catalytic Sound, curated by co-op artists. One album in, one out—every day'
        sectionNumber={0}
        selectAlbum={selectAlbum}
        selectedAlbum={selectedAlbum}
        albums={categories[1].albums} />
      <Section 
        headerText='Catalytic Artist Albums'
        sectionDescription='Experience the complete series of member-exclusive monthly digital releases.'
        sectionNumber={1}
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
    <div class='footer' class:mobile-player-open={$playerIsOpen && $mobileLayout}></div>
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
    overflow-y: scroll;
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
  }

  .music-selection.mobile {
    width: 100%;
  }

  .footer {
    display: inline-block;
    position: relative;
    min-height: 150px;
  }

  .footer.mobile-player-open {
    min-height: 700px;
  }

  .player-container {
    display: flex;
    position: sticky;
    right: 0;
    top: 0;
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

  .mission {
    position: relative;
    margin: 10px var(--mission-padding) 0;
  }

  .mission p {
    line-height: 28px;
  }
</style>