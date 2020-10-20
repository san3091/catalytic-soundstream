<script>
  import { playerIsOpen, mobileLayout, padding } from '../../stores.js'
</script>

<footer 
  class:mobile-player-open={$playerIsOpen && $mobileLayout}
  style='--padding:{$padding}px'>
  <h3>Having trouble?</h3> 
  <div class='footer-links'>
    <a 
      href='https://docs.google.com/forms/d/e/1FAIpQLSdFpoKjd4hQgGMQ-xA13Ypezwz4siMNyRssfCOipbd-I8HLPg/viewform?usp=sf_link' 
      rel="noopener noreferrer"
      target="_blank">
      report a bug
    </a>
    <span> or </span>
    <a 
      href='https://docs.google.com/forms/d/e/1FAIpQLSdQSN8t-s1TDGsuvR_p00kAYHX8Gw_Civy_kYrXKaXnXUEThA/viewform?usp=sf_link'   
      rel="noopener noreferrer"
      target="_blank">
      give feedback
    </a>
  </div>
</footer>   

<style>
  footer {
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    min-height: 150px;
    padding: var(--padding);
  }

  .mobile-player-open {
    min-height: 700px;
  }

  h3 {
    margin-bottom: 10px;
  }

  a {
    color: var(--red-orange);
    text-decoration: none;
  }

  </style>