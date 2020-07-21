import { writable } from 'svelte/store'
import { tweened } from 'svelte/motion'
import { cubicOut } from 'svelte/easing'

export let playerIsOpen = writable(false)
export let modalIsOpen = writable(false)
export let user = writable(null)
export let loading = writable(true)
export let userIsOpen = writable(false)
export let appWidth = writable(0)
export let mobileLayout = writable(false)
export let padding =  tweened(100, { easing: cubicOut, duration: 400 })
export let redirectUri = writable(null)
export let logoHover = writable(false)
