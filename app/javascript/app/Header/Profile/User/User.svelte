<script>
export let user

const initials = () => {
  // todo: consume full_name once merged with santi's work
  return user.first_name.charAt(0) + user.last_name.charAt(0)
}
</script>


<button class='user-button'>
  <div class='user'>
    <div class='user-icon'>
      <h2>{initials()}</h2>
    </div>
    <div class='user-info'>
      <h4 class='user-name'>{user.first_name} {user.last_name}</h4>
      <!-- <h3 class='user-name'>{user.full_name}</h3> -->
      <h6 class='user-email'>{user.email}</h6>
    </div>
  </div>
  <i class="material-icons">expand_more</i>
</button>

<style>
  h2 {
    margin: 0;
    color: var(--medium-grey)
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

  h4 {
    color: var(--medium-grey);
  }

  h6 {
    color: var(--black);
  }

  .material-icons {
    font-size: 28px;
    color: var(--medium-grey);
    height: 28px;
  }

  button {
    background-color: transparent;
    border: none;
  }
</style>