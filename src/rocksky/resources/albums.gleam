import gleam/dynamic/decode
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/string
import rocksky/client/base as base_client
import rocksky/errors
import rocksky/resources/base.{type Resource}
import rocksky/types/album.{type Album}
import rocksky/types/track

pub type AlbumResource =
  Resource

pub fn new(client: base_client.Client) -> AlbumResource {
  base.new(client, "/users/{did}/albums")
}

pub fn get_albums(
  resource: AlbumResource,
  did: Option(String),
) -> Result(List(Album), errors.ApiError) {
  let path = case did {
    Some(did) -> {
      resource.base_path
      |> string.replace("{did}", did)
    }
    _ -> {
      "/albums"
    }
  }

  let client = resource.client

  case base_client.get(client, path, None) {
    Ok(res) -> {
      let album_decoder = {
        use id <- decode.field("id", decode.string)
        use title <- decode.field("title", decode.string)
        use artist <- decode.field("artist", decode.string)
        use release_date <- decode.optional_field(
          "release_date",
          None,
          decode.optional(decode.string),
        )
        use album_art <- decode.optional_field(
          "album_art",
          None,
          decode.optional(decode.string),
        )
        use year <- decode.optional_field(
          "year",
          None,
          decode.optional(decode.int),
        )
        use sha256 <- decode.field("sha256", decode.string)
        use uri <- decode.field("uri", decode.string)
        use play_count <- decode.field("play_count", decode.int)
        use unique_listeners <- decode.field("unique_listeners", decode.int)
        use tags <- decode.optional_field(
          "tags",
          None,
          decode.optional(decode.list(decode.string)),
        )
        decode.success(album.Album(
          id:,
          title:,
          artist:,
          album_art:,
          release_date:,
          year:,
          sha256:,
          uri:,
          play_count:,
          unique_listeners:,
          tags:,
        ))
      }
      case json.parse(from: res.body, using: decode.list(album_decoder)) {
        Ok(albums) -> {
          Ok(albums)
        }
        Error(err) -> {
          echo err
          Error(errors.JsonParseError("Failed to decode album"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}

pub fn get_album(
  resource: AlbumResource,
  uri: String,
) -> Result(Album, errors.ApiError) {
  let path =
    resource.base_path |> string.replace("{did}/albums", "")
    <> string.replace(uri, "at://", "")
  let client = resource.client

  case base_client.get(client, path, None) {
    Ok(res) -> {
      let track_decoder = {
        use album <- decode.field("album", decode.string)
        use album_art <- decode.field(
          "album_art",
          decode.optional(decode.string),
        )
        use album_artist <- decode.field("album_artist", decode.string)
        use artist <- decode.field("artist", decode.string)
        use composer <- decode.optional_field(
          "composer",
          None,
          decode.optional(decode.string),
        )
        use copyright_message <- decode.optional_field(
          "copyright_message",
          None,
          decode.optional(decode.string),
        )
        use disc_number <- decode.field("disc_number", decode.int)
        use duration <- decode.field("duration", decode.int)
        use sha256 <- decode.field("sha256", decode.string)
        use title <- decode.field("title", decode.string)
        use track_number <- decode.field("track_number", decode.int)
        use xata_createdat <- decode.field("xata_createdat", decode.string)
        use xata_id <- decode.field("xata_id", decode.string)
        use xata_updatedat <- decode.field("xata_updatedat", decode.string)
        use xata_version <- decode.field("xata_version", decode.int)
        use album_uri <- decode.optional_field(
          "album_uri",
          None,
          decode.optional(decode.string),
        )
        use apple_music_link <- decode.optional_field(
          "apple_music_link",
          None,
          decode.optional(decode.string),
        )
        use artist_uri <- decode.optional_field(
          "artist_uri",
          None,
          decode.optional(decode.string),
        )
        use genre <- decode.optional_field(
          "genre",
          None,
          decode.optional(decode.string),
        )
        use label <- decode.optional_field(
          "label",
          None,
          decode.optional(decode.string),
        )
        use lyrics <- decode.optional_field(
          "lyrics",
          None,
          decode.optional(decode.string),
        )
        use mb_id <- decode.optional_field(
          "mb_id",
          None,
          decode.optional(decode.string),
        )
        use spotify_link <- decode.optional_field(
          "spotify_link",
          None,
          decode.optional(decode.string),
        )
        use tidal_link <- decode.optional_field(
          "tidal_link",
          None,
          decode.optional(decode.string),
        )
        use uri <- decode.optional_field(
          "uri",
          None,
          decode.optional(decode.string),
        )
        use youtube_link <- decode.optional_field(
          "youtube_link",
          None,
          decode.optional(decode.string),
        )
        decode.success(track.AlbumTrack(
          album:,
          album_art:,
          album_artist:,
          artist:,
          composer:,
          copyright_message:,
          disc_number:,
          duration:,
          sha256:,
          title:,
          track_number:,
          xata_createdat:,
          xata_id:,
          xata_updatedat:,
          xata_version:,
          album_uri:,
          apple_music_link:,
          artist_uri:,
          genre:,
          label:,
          lyrics:,
          mb_id:,
          spotify_link:,
          tidal_link:,
          uri:,
          youtube_link:,
        ))
      }
      let album_decoder = {
        use album_art <- decode.optional_field(
          "album_art",
          None,
          decode.optional(decode.string),
        )
        use artist <- decode.field("artist", decode.string)
        use artist_uri <- decode.optional_field(
          "artist_uri",
          None,
          decode.optional(decode.string),
        )
        use release_date <- decode.optional_field(
          "release_date",
          None,
          decode.optional(decode.string),
        )
        use sha256 <- decode.field("sha256", decode.string)
        use title <- decode.field("title", decode.string)
        use uri <- decode.field("uri", decode.string)
        use xata_createdat <- decode.field("xata_createdat", decode.string)
        use xata_updatedat <- decode.field("xata_updatedat", decode.string)
        use xata_version <- decode.field("xata_version", decode.int)
        use year <- decode.optional_field(
          "year",
          None,
          decode.optional(decode.int),
        )
        use apple_music_link <- decode.optional_field(
          "apple_music_link",
          None,
          decode.optional(decode.string),
        )
        use spotify_link <- decode.optional_field(
          "spotify_link",
          None,
          decode.optional(decode.string),
        )
        use tidal_link <- decode.optional_field(
          "tidal_link",
          None,
          decode.optional(decode.string),
        )
        use youtube_link <- decode.optional_field(
          "youtube_link",
          None,
          decode.optional(decode.string),
        )
        use id <- decode.field("id", decode.string)
        use listeners <- decode.field("listeners", decode.int)
        use scrobbles <- decode.field("scrobbles", decode.int)
        use tracks <- decode.optional_field(
          "tracks",
          None,
          decode.optional(decode.list(track_decoder)),
        )
        use tags <- decode.optional_field(
          "tags",
          None,
          decode.optional(decode.list(decode.string)),
        )
        decode.success(album.AlbumDetails(
          album_art:,
          artist:,
          artist_uri:,
          release_date:,
          sha256:,
          title:,
          uri:,
          xata_createdat:,
          xata_updatedat:,
          xata_version:,
          year:,
          apple_music_link:,
          spotify_link:,
          tidal_link:,
          youtube_link:,
          id:,
          listeners:,
          scrobbles:,
          tracks:,
          tags:,
        ))
      }
      case json.parse(from: res.body, using: album_decoder) {
        Ok(album) -> {
          Ok(album)
        }
        Error(err) -> {
          echo err
          Error(errors.JsonParseError("Failed to decode album"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}
