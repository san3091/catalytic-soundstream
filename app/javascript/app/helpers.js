export const playable = (album, user) => {
  return album.free || (user && user.is_member)
}