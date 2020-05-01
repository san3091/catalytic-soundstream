import { writable } from 'svelte/store'

export let playerOpen = writable(false)
export let modalOpen = writable(true)
export let user = writable(null)
export let loading = writable(true)