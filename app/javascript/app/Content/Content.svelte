<script>
  import { onMount } from 'svelte'
  import Search from './Search/Search.svelte'
  import Section from './Section/Section.svelte'
  import Player from './Player/Player.svelte'
  import { playerIsOpen, modalIsOpen, user, mobileLayout } from '../stores.js'
  
  const albumURLs = [
    'https://soundcloud.com/user-861231864/sets/streaming-test-1/s-q4DAH',
    'https://soundcloud.com/playlist/sets/love-hurts',
    'https://soundcloud.com/soundcloud-hustle/sets/hip-hop-party-starters',
    'https://soundcloud.com/soundcloud-hustle/sets/hip-hop-love-songs',
    'https://soundcloud.com/soundcloud-hustle/sets/mac-millers-definitive-1',
    'https://soundcloud.com/soundcloud-shine/sets/chill-pop',
    'https://soundcloud.com/soundcloud-shine/sets/playback-2019',
    'https://soundcloud.com/soundcloud-shine/sets/2019-shine-playback',
    'https://soundcloud.com/badbunny15/sets/yhlqmdlg-1',
    'https://soundcloud.com/badbunny15/sets/x-100pre-2',
    'https://soundcloud.com/soundcloud-the-peak/sets/midnight-dark-electro',
    'https://soundcloud.com/soundcloud-the-peak/sets/atmospheric-edm',
    'https://soundcloud.com/fresh-pressed/sets/fresh-pressed-tracks',
    'https://soundcloud.com/user-861231864/sets/streaming-test-1/s-q4DAH',
    'https://soundcloud.com/soundcloud-scenes/sets/psychedelic-indie',
    'https://soundcloud.com/monstercat/sets/monstercat-instinct',
    'https://soundcloud.com/monstercat/sets/dream-in-color-the-remixes',
    'https://soundcloud.com/soundcloud-la-onda/sets/tropical-pop',
    'https://soundcloud.com/soundcloud-la-onda/sets/rap-en-espanol',
    'https://soundcloud.com/soundcloud-la-onda/sets/afro-latinx-diaspora',
    'https://soundcloud.com/soundcloud-la-onda/sets/amor-norteno-love-ballads',
    'https://soundcloud.com/soundcloud-circuits/sets/equalizers-female-electronic-producers',
    'https://soundcloud.com/soundcloud-circuits/sets/zero-in-electronic-deep-focus',
    'https://soundcloud.com/soundcloud-mainroom/sets/dance-new-hot',
    'https://soundcloud.com/soundcloud-mainroom/sets/jack-chicago-house-icons',
    'https://soundcloud.com/soundcloud-mainroom/sets/the-sounds-of-acid',
    'https://soundcloud.com/soundcloud-mainroom/sets/a-history-of-detroit-techno',
    'https://soundcloud.com/soundcloud-mainroom/sets/divas-women-of-house-music',
    'https://soundcloud.com/soundcloud-shine/sets/chill-pop',
    'https://soundcloud.com/soundcloud-scenes/sets/dreamo-emo-indie-rap',
    'https://soundcloud.com/soundcloud-auras/sets/queen-things-women-of-r-b'
  ]

  let albums = []
  let selectedAlbum

  const caaAlbums = (albums) => {
    const albumsCopy = albums.slice(3, 22).map(album => {
      const albumCopy = Object.assign({}, album)
      return albumCopy
    })
    return albumsCopy
  }
  
  const hwhAlbums = (albums) => {
    const albumsCopy = albums.slice(24, 29).map(album => {
      const albumCopy = Object.assign({}, album)
      return albumCopy
    })
    return albumsCopy
  }

  const loadAlbumData = (index=0) => {
    albumURLs.forEach((url, index) => {
      albums.push({ loading: true })
      SC.oEmbed(albumURLs[index])
      .then(newAlbum => {
        newAlbum.url = url
        newAlbum.index = index
        albums[index] = newAlbum
        newAlbum.free = index < 6 ? true : false
      })
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

  onMount(() => {
    loadAlbumData()
  })
</script>

<div class='content' class:mobile={$mobileLayout}>
  <div class='music-selection' class:mobile={$mobileLayout}> 
    <Section
      headerText='Rotating Selection'
      sectionDescription='Explore a rotating selection of music from Catalytic Sound, curated by co-op artists.  [One album in, one out—every day.]'
      sectionNumber={0}
      selectAlbum={selectAlbum}
      selectedAlbum={selectedAlbum || albums[1]}
      albums={albums} />
    <Section 
      headerText='Catalytic Artist Albums'
      sectionDescription='Experience the complete series of member-exclusive monthly digital releases.'
      sectionNumber={1}
      selectAlbum={selectAlbum}
      selectedAlbum={selectedAlbum || albums[1]}
      albums={caaAlbums(albums)} />
    <Section 
      headerText="History is What's Happening"
      sectionDescription='Discover classics from the Catalytic Sound catalog.'
      sectionNumber={2}
      selectAlbum={selectAlbum}
      selectedAlbum={selectedAlbum || albums[1]}
      albums={hwhAlbums(albums)} />
    <div class='footer' class:mobile-player-open={$playerIsOpen && $mobileLayout}></div>
  </div>
  <div 
    class='player-container' 
    class:mobile={$mobileLayout}>
    <Player selectedAlbum={selectedAlbum || albums[1]} />
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
</style>