<script>
  import { fade } from 'svelte/transition'
  import { logoHover, padding } from '../../stores.js'
</script>


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

<style>    
  .mission {
    position: relative;
    margin: 20px var(--mission-padding) -20px;
  }

  .mission p {
    line-height: 32px;
    margin-bottom: 24px;
  }
</style>