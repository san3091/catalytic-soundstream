  json.id category.id
  json.name category.name
  json.albums category.albums.where(current: true) do |album|
  json.partial! "albums/album", album: album
  end