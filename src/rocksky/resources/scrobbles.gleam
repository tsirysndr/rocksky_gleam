import gleam/dynamic/decode
import gleam/int
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/string
import rocksky/client/base as base_client
import rocksky/errors
import rocksky/resources/base
import rocksky/types/pagination.{type Pagination}
import rocksky/types/scrobble.{type Scrobble}

pub type ScrobbleResource =
  base.Resource

pub fn new(client: base_client.Client) -> ScrobbleResource {
  base.new(client, "/users/{did}/scrobbles")
}

pub fn get_scrobbles(
  resource: ScrobbleResource,
  did: Option(String),
  pagination: Pagination,
) -> Result(List(Scrobble), errors.ApiError) {
  let path = case did {
    Some(did) -> {
      resource.base_path |> string.replace("{did}", did)
    }
    None -> {
      "/public/scrobbles"
    }
  }

  let path = case pagination {
    pagination.Pagination(offset, size) -> {
      path
      <> "?size="
      <> int.to_string(size)
      <> "&offset="
      <> int.to_string(offset)
    }
    _ -> {
      path
    }
  }

  let client = resource.client

  case base_client.get(client, path, None) {
    Ok(res) -> {
      case did {
        Some(_) -> {
          let scrobble_decoder = {
            use id <- decode.field("id", decode.string)
            use track_id <- decode.field("track_id", decode.string)
            use title <- decode.field("title", decode.string)
            use artist <- decode.field("artist", decode.string)
            use album_artist <- decode.field("album_artist", decode.string)
            use album_art <- decode.field(
              "album_art",
              decode.optional(decode.string),
            )
            use album <- decode.field("album", decode.string)
            use handle <- decode.field("handle", decode.string)
            use uri <- decode.field("uri", decode.string)
            use track_uri <- decode.field(
              "track_uri",
              decode.optional(decode.string),
            )
            use artist_uri <- decode.field(
              "artist_uri",
              decode.optional(decode.string),
            )
            use album_uri <- decode.field(
              "album_uri",
              decode.optional(decode.string),
            )
            use created_at <- decode.field("created_at", decode.string)
            decode.success(scrobble.UserScrobble(
              id:,
              track_id:,
              title:,
              artist:,
              album_artist:,
              album_art:,
              album:,
              handle:,
              uri:,
              track_uri:,
              artist_uri:,
              album_uri:,
              created_at:,
            ))
          }
          case
            json.parse(from: res.body, using: decode.list(scrobble_decoder))
          {
            Ok(scrobbles) -> {
              Ok(scrobbles)
            }
            Error(err) -> {
              echo err
              Error(errors.JsonParseError("Failed to decode scrobbles"))
            }
          }
        }
        None -> {
          let scrobble_decoder = {
            use id <- decode.field("id", decode.string)
            use artist <- decode.field("artist", decode.string)
            use cover <- decode.field("cover", decode.optional(decode.string))
            use date <- decode.field("date", decode.string)
            use listeners <- decode.field("listeners", decode.int)
            use sha256 <- decode.field("sha256", decode.string)
            use tags <- decode.field("tags", decode.list(decode.string))
            use title <- decode.field("title", decode.string)
            use uri <- decode.field("uri", decode.string)
            use user <- decode.field("user", decode.string)
            decode.success(scrobble.Scrobble(
              id:,
              artist:,
              cover:,
              date:,
              listeners:,
              sha256:,
              tags:,
              title:,
              uri:,
              user:,
            ))
          }
          case
            json.parse(from: res.body, using: decode.list(scrobble_decoder))
          {
            Ok(scrobbles) -> {
              Ok(scrobbles)
            }
            Error(err) -> {
              echo err
              Error(errors.JsonParseError("Failed to decode scrobbles"))
            }
          }
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}
