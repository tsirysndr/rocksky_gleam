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
