<script>
  import PlayLastButton from './PlayLastButton/PlayLastButton.svelte'

  export let headerText
  export let sectionDescription
  export let rotating
  export let dontMissAlbum
  export let selectAlbum
  export let selectedAlbum
  export let highlight
</script>

<div class='section-top' class:highlight>
  <div class='section-header'>
    <h1>{headerText}</h1>
    <p class='description'>{sectionDescription}</p>
  </div>
  {#if rotating && dontMissAlbum}
    <PlayLastButton 
      dontMissAlbum={dontMissAlbum}
      selected={selectedAlbum == dontMissAlbum}
      selectAlbum={selectAlbum} />
  {/if}
</div>

<style>
  .highlight h1 {
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
</style>