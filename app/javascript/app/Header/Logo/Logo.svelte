<script>
  import { fade } from 'svelte/transition'
  import CatalyticSoundImage from '../../../assets/catalytic-sound.png'
  import StreamImage from '../../../assets/stream.png'
  import { padding } from '../../stores.js'

</script>
 
<a 
  href='https://catalyticsound.com/' 
  target="_blank" 
  rel="noopener noreferrer" 
  style='--padding:{$padding}px' >
  <div class='left-logo'>
    <img 
      class='catalytic-sound' 
      src={CatalyticSoundImage} 
      alt='Catalytic Sound' />
    <div class='divider'></div>
  </div>
  <img 
    class='stream'
    src={StreamImage} 
    alt='Stream' />
</a>

<style>
  a {
    padding-left: var(--padding);
    display: flex;
    flex-direction: row;
    align-items: center;
  }

  img {
    height: 60px;
  }

  .left-logo {
    display: flex;
    flex-direction: row;
    align-items: center;
    background-color: var(--light-grey);
  }

  .divider {
    width: 2px;
    background-color: var(--medium-grey);
    height: 32px;
    border-radius: 1px;
    animation: expand .2s ease-in-out 1.4s;
    animation-fill-mode: both;
  }

  .catalytic-sound {
    animation: fade-in .4s ease-in;
    animation-fill-mode: both;
    background-color: var(--light-grey);
    margin-right: 4px;
  }

  .stream {
    position: relative;
    opacity: 0;
    z-index: -1;
    margin-left: 4px;
    animation: slide .4s ease-out 1.6s forwards;
    animation-fill-mode: both;
  }

  @keyframes slide {
    from {
      left: -150px;
    }
    to {
      left: 0px;
      opacity: 1;
    }
  }

  @keyframes expand {
    0% {
       opacity: 0;
      transform: rotateX(87deg);
    }

    50% {
      opacity: 1;
    }

    100% {
      opacity: 1;
      transform: rotateX(0deg);
    }
  }
</style>