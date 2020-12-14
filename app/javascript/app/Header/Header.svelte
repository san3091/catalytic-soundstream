<script>
  import Profile from './Profile/Profile.svelte'
  import Logo from './Logo/Logo.svelte'
</script>

<div class='header'>
  <div class='header-content'>
    <Logo />
    <Profile />
  </div>
</div>

<style>
  .header {
    width: 100%;
    display: flex;
    z-index: 5;
    border-bottom: 1px solid var(--red-orange);
  }

  .header-content {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;
  }
</style>
