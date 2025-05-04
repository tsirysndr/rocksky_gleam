import gleam/option.{type Option}

pub type ApiError {
  ApiError(status_code: Int, message: String, data: Option(String))
  NetworkError(message: String)
  JsonParseError(message: String)
}
