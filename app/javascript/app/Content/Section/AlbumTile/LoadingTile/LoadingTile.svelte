<script>
  export let tileWidth
  export let tilePadding
</script>

<div class='loading' 
  style='
    --size:{tileWidth - (tilePadding * 2)}px; 
    --tilePadding:{tilePadding}px;
  '>
  <svg viewBox="0 0 100 100" height='100' width='100'>
    <path d='M60,60 L60,40 L40,40 L40,60 Z' />
  </svg>
</div>

<style>
  .loading {
    padding: var(--tilePadding);
  }

  svg {
    width: var(--size);
    height: var(--size);
  }

  path {
    stroke: var(--medium-grey);
    fill: none;
    stroke-dasharray: 80;
    animation: loading 2s ease infinite;
  }

  @keyframes loading {
    0% {
      stroke-dashoffset: -80;
    }
    100% {
      stroke-dashoffset: 80;
    }
  }
</style>