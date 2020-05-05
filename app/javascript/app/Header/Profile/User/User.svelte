<script>
  import { disconnectUser } from '../../../authHelpers.js'
  import { user, userIsOpen } from '../../../stores.js'

  const firstInitial = () => $user.first_name.charAt(0)
  const toggleUserIsOpen = () => userIsOpen.set(!$userIsOpen)
  // <Main> in App.svelte closes user dropdown on:click

  const signOut = () => {
    disconnectUser()
    user.set(null)
  }
</script>

<button 
  class='user-button' 
  on:click|stopPropagation={toggleUserIsOpen} >
  <div class='user'>
    <div class='user-icon'>
      <h2>{firstInitial()}</h2>
    </div>
    <div class='user-info'>
      <h4 class='user-name'>{$user.first_name} {$user.last_name}</h4>
      <!-- <h3 class='user-name'>{$user.full_name}</h3> -->
      <h6 class='user-email'>{$user.email}</h6>
    </div>
  </div>
  <div class='expand-icon'>
    {#if $userIsOpen}
      <i class="material-icons">expand_less</i>
    {:else}
      <i class="material-icons">expand_more</i>
    {/if}
  </div>
</button>

{#if $userIsOpen}
  <div class='menu'>
    <a 
      class='menu-button' 
      href='https://www.patreon.com/user/creators' 
      on:click|stopPropagation
    target="_blank" rel="noopener noreferrer">
      <h4>View Profile</h4>
    </a>
    <button 
      class='menu-button sign-out' 
        on:click|stopPropagation={signOut}>
      <h4>Sign Out</h4>
    </button>
  </div>
{/if}

<style>
  button, a {
    box-sizing: border-box;
    background-color: var(--transparent-white);
    border-radius: 0;
    border: none;
    border-bottom: 1px solid var(--medium-grey);
  }

  button:hover, a:hover {
    background-color: var(--white);
  }

  a {
    text-decoration: none;
    display: flex;  
    justify-content: center;
    align-items: center;
  }
   

  h2 {
    margin: 0;
    color: var(--medium-grey)
  }

  h4 {
    color: var(--medium-grey);
  }

  h6 {
    color: var(--black);
  }

  .user-button {
		cursor: pointer;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    height: 100%;
    padding: 10px;
  }

  .user {
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
  }

  .user-icon {
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 40px;
    height: 40px;
    border-radius: 20px;
    background-color: var(--light-grey);
    margin-right: 10px;
    border: 1px solid var(--medium-grey);
  }

  .user-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
  }

  .expand-icon {
    position: relative;
    height: 28px;
    width: 28px;
  }

  .material-icons {
    position: absolute;
    font-size: 28px;
    color: var(--medium-grey);
    left: 0px;
  }

  .menu {
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    position: absolute;
    top: 61px;
    width: 100%;
    border-bottom: 1px solid var(--medium-grey);
  }

  .menu-button {
    width: 100%;
    height: 32px;
    background-color: var(--transparent-white);
    color: var(--medium-grey);
    border: none;
  }

  .sign-out:hover * {
    color: red;
  }
</style>