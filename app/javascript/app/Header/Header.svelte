<script>
  import Profile from './Profile/Profile.svelte'
  import Logo from './Logo/Logo.svelte'
</script>

<div class='header'>
  <div class='beta-banner'>
    <h3 class='beta-text'>beta</h3>
  </div>
  <div class='header-content'>
    <Logo />
    <Profile />
  </div>
</div>

<style>
  .header {
    position: sticky;
    top: 0;
    width: 100%;
    display: flex;
    z-index: 3;
    border-bottom: 1px solid var(--orange);
  }

  .header-content {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;
  }

  .beta-banner {
    position: absolute;
    top: 15px;
    left: -45px;
    display: flex;
    justify-content: center;
    transform: rotate(-45deg);
    width: 150px;
    background-color: var(--transparent-orange);
  }

  .beta-text {
    margin: 2px;
    font-weight: bold;
    color: white;
  }
</style>
