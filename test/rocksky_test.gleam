import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleeunit
import gleeunit/should
import rocksky/client/base
import rocksky/resources/albums
import rocksky/resources/artists
import rocksky/resources/base as resource
import rocksky/resources/scrobbles
import rocksky/resources/tracks
import rocksky/resources/users
import rocksky/types/pagination
import rocksky/types/user.{User}

pub const base_url = "http://localhost:6677"

pub fn main() {
  gleeunit.main()
}

pub fn get_user_test() {
  let client = base.from_url(base_url)

  users.new(client)
  |> users.get_user("tsiry-sandratraina.comm")
  |> should.be_error

  let profile =
    users.new(client)
    |> users.get_user("tsiry-sandratraina.com")
    |> result.unwrap(User(
      avatar: "",
      did: "",
      display_name: None,
      handle: "",
      xata_createdat: "",
      xata_id: "",
      xata_updatedat: "",
      xata_version: 0,
    ))

  profile.did |> should.equal("did:plc:7vdlgi2bflelz7mmuxoqjfcr")
  profile.handle |> should.equal("tsiry-sandratraina.com")
  profile.display_name |> should.be_some
}

pub fn get_albums_test() {
  let client = base.from_url(base_url)

  albums.new(client)
  |> albums.get_albums(Some("tsiry-sandratraina.com"), pagination.Default)
  |> should.be_ok()

  albums.new(client)
  |> albums.get_albums(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Default,
  )
  |> should.be_ok()

  albums.new(client)
  |> albums.get_albums(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr_"),
    pagination.Default,
  )
  |> should.equal(Ok([]))

  albums.new(client)
  |> albums.get_albums(None, pagination.Default)
  |> should.be_ok
}

pub fn get_albums_pagination_test() {
  let client = base.from_url(base_url)

  albums.new(client)
  |> albums.get_albums(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Pagination(0, 2),
  )
  |> result.map(fn(x) { list.length(x) |> should.equal(2) })
}

pub fn get_artists_test() {
  let client = base.from_url(base_url)

  artists.new(client)
  |> artists.get_artists(Some("tsiry-sandratraina.com"), pagination.Default)
  |> should.be_ok

  artists.new(client)
  |> artists.get_artists(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Default,
  )
  |> should.be_ok

  artists.new(client)
  |> artists.get_artists(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr_"),
    pagination.Default,
  )
  |> should.equal(Ok([]))

  artists.new(client)
  |> artists.get_artists(None, pagination.Default)
  |> should.be_ok
}

pub fn get_artists_pagination_test() {
  let client = base.from_url(base_url)

  artists.new(client)
  |> artists.get_artists(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Pagination(0, 2),
  )
  |> result.map(fn(x) { list.length(x) |> should.equal(2) })
}

pub fn get_tracks_test() {
  let client = base.from_url(base_url)

  tracks.new(client)
  |> tracks.get_tracks(Some("tsiry-sandratraina.com"), pagination.Default)
  |> should.be_ok

  tracks.new(client)
  |> tracks.get_tracks(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Default,
  )
  |> should.be_ok

  tracks.new(client)
  |> tracks.get_tracks(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr_"),
    pagination.Default,
  )
  |> should.equal(Ok([]))

  tracks.new(client)
  |> tracks.get_tracks(None, pagination.Default)
  |> should.be_ok
}

pub fn get_tracks_pagination_test() {
  let client = base.from_url(base_url)

  tracks.new(client)
  |> tracks.get_tracks(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Pagination(0, 2),
  )
  |> result.map(fn(x) { list.length(x) |> should.equal(2) })
}

pub fn get_scrobbles_test() {
  let client = base.from_url(base_url)

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(Some("tsiry-sandratraina.com"), pagination.Default)
  |> should.be_ok

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Default,
  )
  |> should.be_ok

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr_"),
    pagination.Default,
  )
  |> should.equal(Ok([]))

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(None, pagination.Default)
  |> should.be_ok
}

pub fn get_scrobbles_pagination_test() {
  let client = base.from_url(base_url)

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(
    Some("did:plc:7vdlgi2bflelz7mmuxoqjfcr"),
    pagination.Pagination(0, 2),
  )
  |> result.map(fn(x) { list.length(x) |> should.equal(2) })
}

pub fn search_test() {
  let client = base.from_url(base_url)

  resource.new(client, "/search")
  |> resource.search("daft punk")
  |> should.be_ok
}

pub fn get_album_test() {
  let client = base.from_url(base_url)

  albums.new(client)
  |> albums.get_album(
    "did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.album/3lhtdpslp4c2e",
  )
  |> should.be_ok

  albums.new(client)
  |> albums.get_album(
    "at://did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.album/3lhtdpslp4c2e",
  )
  |> should.be_ok
}

pub fn get_artist_test() {
  let client = base.from_url(base_url)

  artists.new(client)
  |> artists.get_artist(
    "did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.artist/3liorhapngk23",
  )
  |> should.be_ok

  artists.new(client)
  |> artists.get_artist(
    "at://did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.artist/3liorhapngk23",
  )
  |> should.be_ok
}

pub fn get_track_test() {
  let client = base.from_url(base_url)

  tracks.new(client)
  |> tracks.get_track(
    "did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.song/3lhtyr34rnk2h",
  )
  |> should.be_ok

  tracks.new(client)
  |> tracks.get_track(
    "at://did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.song/3lhtyr34rnk2h",
  )
  |> should.be_ok
}
