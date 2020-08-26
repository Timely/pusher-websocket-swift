import Foundation

/// Used for logging events for informational purposes
internal class PusherLogger {

    // MARK: - Enum definitions

    internal enum LoggingEvent: String {

        // Channels

        case presenceChannelSubscriptionAttemptWithoutChannelData = "Attempting to subscribe to presence channel but no channelData value provided"
        case subscriptionSucceededNoDataInPayload = "Subscription succeeded event received without data key in payload"

        // Events

        case clientEventSent = "sendClientEvent"
        case eventSent = "sendEvent"
        case skippedEventAfterDecryptionFailure = "Skipping event that failed to decrypt on channel"

        // Network

        case networkReachable = "Network reachable"
        case networkUnreachable = "Network unreachable"

        // Websockets

        case attemptReconnectionAfterReachabilityChange = "Connection state is 'connected' but received network reachability change so going to call attemptReconnect"
        case connectionEstablished = "Socket established with socket ID:"
        case disconnectionWithError = "Websocket is disconnected. Error"
        case disconnectionWithoutError = "Websocket is disconnected but no error received"
        case intentionalDisconnection = "Deliberate disconnection - skipping reconnect attempts"
        case maxReconnectAttemptsLimitReached = "Max reconnect attempts reached"
        case reconnectionFailureLikely = "Network unreachable so reconnect likely to fail"
        case pingSent = "Ping sent"
        case pongReceived = "Websocket received pong"
        case receivedMessage = "websocketDidReceiveMessage"
        case unableToHandleIncomingError = "Unable to handle incoming error"
        case unableToHandleIncomingMessage = "Unable to handle incoming Websocket message"
    }

    internal enum LoggingLevel: String {
        case debug      = "[PUSHER DEBUG]"
        case info       = "[PUSHER INFO]"
        case warning    = "[PUSHER WARNING]"
        case error      = "[PUSHER ERROR]"
    }

    // MARK: - Event logging

    internal static func debug(for event: LoggingEvent, context: Any? = nil) -> String {
        return message(for: event, level: .debug)
    }

    internal static func info(for event: LoggingEvent, context: Any? = nil) -> String {
        return message(for: event, level: .info)
    }

    internal static func warning(for event: LoggingEvent, context: Any? = nil) -> String {
        return message(for: event, level: .warning)
    }

    internal static func error(for event: LoggingEvent, context: Any? = nil) -> String {
        return message(for: event, level: .error)
    }

    // MARK: - Private methods

    /// An informational message relating to a particular event of interest.
    /// - Parameter event: A particular `LoggingEvent` of interest.
    /// - Parameter level: The `LoggingLevel` to set for the message.
    /// - Parameter context: Additonal context for the message.
    /// - Returns: A `String` with information to log concerning the event.
    private static func message(for event: LoggingEvent,
                                level: LoggingLevel,
                                context: CustomStringConvertible? = nil) -> String {
        var message = "\(level.rawValue) \(event.rawValue)"
        if let context = context {
            message += " \(context)"
        }

        return message
    }
}
