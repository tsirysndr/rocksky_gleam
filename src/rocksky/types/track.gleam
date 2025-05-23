import gleam/option.{type Option}

pub type Track {
  Track(
    id: String,
    title: String,
    artist: String,
    album_artist: String,
    album_art: Option(String),
    album: String,
    track_number: Int,
    duration: Int,
    sha256: String,
    disc_number: Int,
    uri: String,
    artist_uri: Option(String),
    album_uri: Option(String),
    created_at: String,
    play_count: Int,
    unique_listeners: Int,
    tags: Option(List(String)),
  )
  AlbumTrack(
    album: String,
    album_art: Option(String),
    album_artist: String,
    artist: String,
    composer: Option(String),
    copyright_message: Option(String),
    disc_number: Int,
    duration: Int,
    sha256: String,
    title: String,
    track_number: Int,
    xata_createdat: String,
    xata_id: String,
    xata_updatedat: String,
    xata_version: Int,
    album_uri: Option(String),
    apple_music_link: Option(String),
    artist_uri: Option(String),
    genre: Option(String),
    label: Option(String),
    lyrics: Option(String),
    mb_id: Option(String),
    spotify_link: Option(String),
    tidal_link: Option(String),
    uri: Option(String),
    youtube_link: Option(String),
  )
  TrackDetails(
    album: String,
    album_art: Option(String),
    album_artist: String,
    artist: String,
    composer: Option(String),
    copyright_message: Option(String),
    disc_number: Int,
    duration: Int,
    sha256: String,
    title: String,
    track_number: Int,
    xata_createdat: String,
    id: String,
    xata_updatedat: String,
    xata_version: Int,
    album_uri: Option(String),
    apple_music_link: Option(String),
    artist_uri: Option(String),
    genre: Option(String),
    label: Option(String),
    lyrics: Option(String),
    mb_id: Option(String),
    spotify_link: Option(String),
    tidal_link: Option(String),
    uri: Option(String),
    youtube_link: Option(String),
    listeners: Int,
    scrobbles: Int,
  )
}
