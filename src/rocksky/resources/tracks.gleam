import gleam/dynamic/decode
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/string
import rocksky/client/base as base_client
import rocksky/errors
import rocksky/resources/base.{type Resource}
import rocksky/types/track.{type Track}

pub type TrackResource =
  Resource

pub fn new(client: base_client.Client) -> TrackResource {
  base.new(client, "/users/{did}/tracks")
}

pub fn get_tracks(
  resource: TrackResource,
  did: Option(String),
) -> Result(List(Track), errors.ApiError) {
  let path = case did {
    Some(did) -> {
      resource.base_path |> string.replace("{did}", did)
    }
    None -> {
      "/tracks"
    }
  }

  let client = resource.client

  case base_client.get(client, path, None) {
    Ok(res) -> {
      let track_decoder = {
        use id <- decode.field("id", decode.string)
        use title <- decode.field("title", decode.string)
        use artist <- decode.field("artist", decode.string)
        use album_artist <- decode.field("album_artist", decode.string)
        use album <- decode.field("album", decode.string)
        use album_art <- decode.field(
          "album_art",
          decode.optional(decode.string),
        )
        use track_number <- decode.field("track_number", decode.int)
        use disc_number <- decode.field("disc_number", decode.int)
        use duration <- decode.field("duration", decode.int)
        use uri <- decode.field("uri", decode.string)
        use artist_uri <- decode.optional_field(
          "artist_uri",
          None,
          decode.optional(decode.string),
        )
        use album_uri <- decode.optional_field(
          "album_uri",
          None,
          decode.optional(decode.string),
        )
        use created_at <- decode.field("created_at", decode.string)
        use sha256 <- decode.field("sha256", decode.string)
        use play_count <- decode.field("play_count", decode.int)
        use unique_listeners <- decode.field("unique_listeners", decode.int)
        use tags <- decode.optional_field(
          "tags",
          None,
          decode.optional(decode.list(decode.string)),
        )
        decode.success(track.Track(
          id:,
          title:,
          artist:,
          album_artist:,
          album_art:,
          album:,
          track_number:,
          duration:,
          sha256:,
          disc_number:,
          uri:,
          artist_uri:,
          album_uri:,
          created_at:,
          play_count:,
          unique_listeners:,
          tags:,
        ))
      }
      case json.parse(from: res.body, using: decode.list(track_decoder)) {
        Ok(track) -> {
          Ok(track)
        }
        Error(err) -> {
          echo err
          Error(errors.JsonParseError("Failed to decode track"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}

pub fn get_track(
  resource: TrackResource,
  uri: String,
) -> Result(Track, errors.ApiError) {
  let path =
    resource.base_path |> string.replace("{did}/tracks", "")
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
        use id <- decode.field("id", decode.string)
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
        use listeners <- decode.field("listeners", decode.int)
        use scrobbles <- decode.field("scrobbles", decode.int)
        decode.success(track.TrackDetails(
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
          id:,
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
          listeners:,
          scrobbles:,
        ))
      }
      case json.parse(from: res.body, using: track_decoder) {
        Ok(track) -> {
          Ok(track)
        }
        Error(err) -> {
          echo err
          Error(errors.JsonParseError("Failed to decode track"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}
