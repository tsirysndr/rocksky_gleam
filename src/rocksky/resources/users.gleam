import gleam/dynamic/decode
import gleam/json
import gleam/option
import rocksky/client/base as base_client
import rocksky/errors
import rocksky/resources/base.{type Resource}
import rocksky/types/user.{type User}

pub type UserResource =
  Resource

pub fn new(client: base_client.Client) -> UserResource {
  base.new(client, "/users")
}

pub fn get_user(
  resource: UserResource,
  did: String,
) -> Result(User, errors.ApiError) {
  let path = resource.base_path <> "/" <> did
  let client = resource.client

  case base_client.get(client, path, option.None) {
    Ok(res) -> {
      let user_decoder = {
        use avatar <- decode.field("avatar", decode.string)
        use did <- decode.field("did", decode.string)
        use display_name <- decode.field(
          "display_name",
          decode.optional(decode.string),
        )
        use handle <- decode.field("handle", decode.string)
        use xata_createdat <- decode.field("xata_createdat", decode.string)
        use xata_id <- decode.field("xata_id", decode.string)
        use xata_updatedat <- decode.field("xata_updatedat", decode.string)
        use xata_version <- decode.field("xata_version", decode.int)
        decode.success(user.User(
          avatar:,
          did:,
          display_name:,
          handle:,
          xata_createdat:,
          xata_id:,
          xata_updatedat:,
          xata_version:,
        ))
      }
      case json.parse(from: res.body, using: user_decoder) {
        Ok(user) -> {
          Ok(user)
        }
        Error(_) -> {
          Error(errors.JsonParseError("Failed to decode user"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}
