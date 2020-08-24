<script>
  import Profile from './Profile/Profile.svelte'
  import Logo from './Logo/Logo.svelte'
  import BetaBanner from './BetaBanner/BetaBanner.svelte'
</script>

<div class='header'>
  <BetaBanner />
  <div class='header-content'>
    <Logo />
    <Profile />
  </div>
</div>

<style>
  .header {
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
</style>
