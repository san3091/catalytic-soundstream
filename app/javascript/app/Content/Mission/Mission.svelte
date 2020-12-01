<script>
  import { fade } from 'svelte/transition'
  import { logoHover, padding } from '../../stores.js'
</script>


{#if $logoHover}
  <div 
    class='mission'
    style='--mission-padding:{$padding}px'
    in:fade >
      <p>
        The music streaming industry makes over ten billion dollars each year selling music made by millions of artists. Despite their reliance on the creativity and labor of musicians, streaming companies pay artists almost nothing, and treat musicians as cogs in a content-production machine.</p>
      </p>
      <p>
        The Catalytic Soundstream is our solution to this systemic imbalance: an artist owned and curated, subscription-based streaming service that pays Catalytic Sound co-op musicians 2/3 of net income generated through listeners' subscriptions. Independent record labels represented on the Label Radio tier will also compensate their artists a proportional amount.
      </p>
      <p>
        Each month, subscribers will enjoy a constantly shifting set of albums on the Soundstream. Catalytic Radio presents a rotating selection of thirty albums chosen by Catalytic artists and staff. Label Radio showcases a rotating selection of records curated by the core group of Corbett vs. Dempsey, NoBusiness Records, Relative Pitch Records, and Astral Spirits, as well as at least one guest label each month.
      </p>
      <p>
        In addition, the ever-expanding series of Catalytic Artist Album editions is included, along with the History Is What's Happening collection, which spotlights a handpicked selection of older records.  By subscribing, listeners will contribute to a new kind of music streaming service, one that provides an ongoing and equitable source of income for the musicians responsible for its creative content.
      </p>
    </div>
  {/if}

<style>    
  .mission {
    position: relative;
    margin: 20px var(--mission-padding) -20px;
    background-color: var(--dark-grey);
    padding: 50px 50px 26px;
  }

  .mission p {
    margin-bottom: 24px;
    color: var(--white);
  }
</style>
