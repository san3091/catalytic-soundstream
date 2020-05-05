import { writable } from 'svelte/store'

export let playerIsOpen = writable(false)
export let modalIsOpen = writable(false)
export let user = writable(null)
export let loading = writable(true)
export let userIsOpen = writable(false)
export let appWidth = writable(0)