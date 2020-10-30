<script>
  export let album
  export let highlight
</script>

<div class='album-tile-info' class:highlight>
  <h4 class='truncate'>{album.title}</h4>
  <h6 class='truncate'>{album.artist}</h6>
</div>

<style>
  .album-tile-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    flex-grow: 1;
    width: var(--size);
    box-sizing: border-box;
    padding: 10px 0 10px 10px;
  }

  .album-tile-info * {
    text-align: left;
  }

  h4 {
    margin-bottom: 4px;
    color: var(--black);
  }

  h6 {
    font-weight: 500;
  }

  .highlight h4 {
    color: var(--white);
  }

  .highlight h6 {
    color: var(--light-grey);
  }
  
  .truncate {
    position: relative;
    right: 10px;
    width: calc(var(--tile-width) - 35px);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
</style>