<script>
  import Profile from './Profile/Profile.svelte'
  import CatalyticSoundLogo from '../../assets/catalytic-sound-logo-(1)-WEB.png'
  
</script>

<div class='header'>
  <div class='header-content'>
    <a href='https://catalyticsound.com/' 
    target="_blank" rel="noopener noreferrer">
      <img src={CatalyticSoundLogo} alt='Catalytic Sound Logo' >
    </a>
    <div class='header-right'>
      <Profile />
    </div>
  </div>
</div>

<style>
  .header {
    position: sticky;
    top: 0;
    width: 100%;
    display: flex;
    z-index: 3;
    background-color: var(--transparent-orange);
    /* background-color: var(--medium-grey); */
    border-bottom: 1px solid var(--orange);
  }

  .header-content {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    width: 100%;
  }

  img {
    height: 60px;
    margin-left: 50px;
    position: relative;
    top: 5px;
  }

  a:hover {
    background-color: transparent;
  }

  .header-right {
    display: flex;
    flex-direction: row;
    align-items: center;
  }
</style>
