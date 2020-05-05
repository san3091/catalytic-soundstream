import { writable } from 'svelte/store'

export let playerIsOpen = writable(false)
export let modalIsOpen = writable(true)
export let user = writable(null)
export let loading = writable(true)
export let userIsOpen = writable(false)