<script>
  import { fade } from 'svelte/transition'
  import CatalyticSoundImage from '../../../assets/catalytic-sound.png'
  import StreamImage from '../../../assets/stream.png'

</script>
 
<a 
  href='https://catalyticsound.com/' 
  target="_blank" 
  rel="noopener noreferrer" >
  <img 
    class='catalytic-sound' 
    src={CatalyticSoundImage} 
    alt='Catalytic Sound' />
  <div class='divider'></div>
  <img 
    class='stream'
    src={StreamImage} 
    alt='Stream' />
</a>

<style>
  a {
    margin-left: 50px;
    display: flex;
    flex-direction: row;
    align-items: center;
  }

  img {
    height: 60px;
  }

  .divider {
    width: 2px;
    background-color: var(--medium-grey);
    height: 50px;
    border-radius: 1px;
    animation: expand .2s ease-in-out 1.4s;
    animation-fill-mode: both;
  }

  .catalytic-sound {
    animation: fade-in .4s ease-in;
    animation-fill-mode: both;
    background-color: var(--light-grey);
  }

  .stream {
    position: relative;
    opacity: 0;
    z-index: -1;
    margin-left: -36px;
    animation: slide .4s ease-out 1.6s forwards;
    animation-fill-mode: both;
    margin-top: 0.5px; 
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