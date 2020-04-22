<script>
  import Profile from './Profile/Profile.svelte'
  import CatalyticSoundLogo from '../../assets/catalytic-sound-logo-(1)-WEB.png'
  
</script>

<div class='header'>
  <div class='header-content'>
    <img src={CatalyticSoundLogo} alt='Catalytic Sound Logo' >
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
    background-color: #f96854;
    /* border-bottom: 1px solid #f96854; */
    /* border-bottom: 1px solid #3e3e3e; */
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

  .header-right {
    display: flex;
    flex-direction: row;
    align-items: center;
  }
</style>
