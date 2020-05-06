export const init = () => {
  let flashTimeout
  const flash = document.getElementsByClassName('admin-dashboard__flash')[0]

  if (flash) {
    flashTimeout = setTimeout(() => {
      flash.classList.add('hidden')
    }, 3000);
  }
}
