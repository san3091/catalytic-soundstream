<script>
  import { tweened } from 'svelte/motion'
  import { cubicOut } from 'svelte/easing'
  import { playerIsOpen } from '../../stores.js'
</script>

<div class='search'>
  <i class='material-icons'>search</i>
  <input type='text' placeholder='search' />
</div>

<style>
  .search {
    position: absolute;
    top: 0;
    right: 0;
    margin: 50px 100px 0 0;
    display: flex;
    align-items: center;
    min-height: 40px;
    width: 250px;
    /* background-color: var(--light-grey); */
    background-color: var(--medium-grey);
  }

  i {
    position: absolute;
    margin: 10px;
    z-index: 1;
    align-self: flex-start;
    /* color: var(--medium-grey); */
    color: var(--light-grey);
  }

  input {
    position: absolute;
    margin: 0;
    padding-left: 40px;
    width: 100%;
    background-color: transparent;
    /* color: var(--medium-grey); */
    color:var(--light-grey);
    border: none;
  }
</style>