<script>
  export let numberOfSections
  export let currentSection
  export let scroll

  const iterableDashes = (numberOfSections) => {
    return [...Array(numberOfSections).keys()]
  }

  $: indicatorLength = numberOfSections * 30 + 10
  $: dashes = iterableDashes(numberOfSections)
</script>

<svg viewBox="0 0 {indicatorLength} 20" class='progress-indicator' style='--width:{indicatorLength}'>
  {#each dashes as { id, dash }, i}
    <line 
      class:active="{i == currentSection}"
      on:click={scroll(i)}
      x1={10 + i * 30} y1="10" 
      x2={30 + i * 30} y2="10" />
  {/each}
</svg>

<style>
  .progress-indicator {
    position: absolute;
    right: 0;
    top: -25px;
    height: 20px;
    width: var(--width);
  }

  line {
    cursor: pointer;
    stroke-width: 4;
    stroke: var(--light-grey)
  }

  .active {
    stroke: var(--orange);
  }
</style>