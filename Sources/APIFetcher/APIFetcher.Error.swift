extension APIFetcher {

    public enum Error: Swift.Error {

        /// This error is thrown when the server returned a response
        /// that is not compatible with the HTTP protocol.
        case responseIsNotHTTPResponse

        /// This error is thrown when the server returned an error.
        /// The first parameter is the HTTP status code.
        /// If the `genericErrorType` was specified in the configuration
        /// and the server response can be converted into this object,
        /// the second parameter will be the server response.
        case serverError(Int, Any?)

    }

}
