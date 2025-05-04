import gleam/dynamic/decode
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/string
import rocksky/client/base as base_client
import rocksky/errors
import rocksky/resources/base.{type Resource}
import rocksky/types/artist.{type Artist}

pub type ArtistResource =
  Resource

pub fn new(client: base_client.Client) -> ArtistResource {
  base.new(client, "/users/{did}/artists")
}

pub fn get_artists(
  resource: ArtistResource,
  did: Option(String),
) -> Result(List(Artist), errors.ApiError) {
  let path = case did {
    Some(did) -> {
      resource.base_path |> string.replace("{did}", did)
    }
    None -> {
      "/artists"
    }
  }

  let client = resource.client

  case base_client.get(client, path, None) {
    Ok(res) -> {
      let artist_decoder = {
        use id <- decode.field("id", decode.string)
        use name <- decode.field("name", decode.string)
        use picture <- decode.optional_field(
          "picture",
          None,
          decode.optional(decode.string),
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
        decode.success(artist.Artist(
          id:,
          name:,
          uri:,
          picture:,
          sha256:,
          play_count:,
          unique_listeners:,
          tags:,
        ))
      }
      case json.parse(from: res.body, using: decode.list(artist_decoder)) {
        Ok(artist) -> {
          Ok(artist)
        }
        Error(err) -> {
          echo err
          Error(errors.JsonParseError("Failed to decode artist"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}

pub fn get_artist(
  resource: ArtistResource,
  uri: String,
) -> Result(Artist, errors.ApiError) {
  let path =
    resource.base_path |> string.replace("{did}/artists", "")
    <> string.replace(uri, "at://", "")
  let client = resource.client

  case base_client.get(client, path, None) {
    Ok(res) -> {
      let artist_decoder = {
        use name <- decode.field("name", decode.string)
        use picture <- decode.optional_field(
          "picture",
          None,
          decode.optional(decode.string),
        )
        use sha256 <- decode.field("sha256", decode.string)
        use uri <- decode.field("uri", decode.string)
        use xata_createdat <- decode.field("xata_createdat", decode.string)
        use id <- decode.field("id", decode.string)
        use xata_updatedat <- decode.field("xata_updatedat", decode.string)
        use xata_version <- decode.field("xata_version", decode.int)
        use apple_music_link <- decode.optional_field(
          "apple_music_link",
          None,
          decode.optional(decode.string),
        )
        use biography <- decode.optional_field(
          "biography",
          None,
          decode.optional(decode.string),
        )
        use born <- decode.optional_field(
          "born",
          None,
          decode.optional(decode.string),
        )
        use born_in <- decode.optional_field(
          "born_in",
          None,
          decode.optional(decode.string),
        )
        use died <- decode.optional_field(
          "died",
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
        use listeners <- decode.field("listeners", decode.int)
        use scrobbles <- decode.field("scrobbles", decode.int)
        use tags <- decode.optional_field(
          "tags",
          None,
          decode.optional(decode.list(decode.string)),
        )
        decode.success(artist.ArtistDetails(
          name:,
          picture:,
          sha256:,
          uri:,
          xata_createdat:,
          id:,
          xata_updatedat:,
          xata_version:,
          apple_music_link:,
          biography:,
          born:,
          born_in:,
          died:,
          spotify_link:,
          tidal_link:,
          youtube_link:,
          listeners:,
          scrobbles:,
          tags:,
        ))
      }
      case json.parse(from: res.body, using: artist_decoder) {
        Ok(artist) -> {
          Ok(artist)
        }
        Error(err) -> {
          echo err
          Error(errors.JsonParseError("Failed to decode artist"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}
