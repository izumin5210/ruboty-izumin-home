module Ruboty
  module TrelloReporter
    module Actions
      class Base
        attr_reader :message

        NAMESPACE_PREFIX = "trelloreporter".freeze
        NAMESPACE_DELIMITER = "::".freeze
        NAMESPACES = {
          board_ids:  (NAMESPACE_PREFIX + NAMESPACE_DELIMITER + "board_ids").freeze,
          list_ids:   (NAMESPACE_PREFIX + NAMESPACE_DELIMITER + "list_ids").freeze
        }

        def initialize(message)
          @message = message
        end

        private

        def board_ids
          message.robot.brain.data[NAMESPACES[:board_ids]] ||= {}
        end

        def list_ids
          message.robot.brain.data[NAMESPACES[:list_ids]] ||= {}
        end

        def cards
          list.cards
        end

        def list
          client.find(:list, list_id)
        end

        def list_id
          list_ids[list_key] ||
            client.find(:board, board_id)
              .lists
              .find { |b| b.name == message[:list] }
              .tap { |b| list_ids[list_key] = b.id }
              .id
        end

        def list_key
          "#{message[:board]}::#{message[:list]}"
        end

        def board_id
          board_ids[message[:board]]
        end

        def client
          Trello::Client.new(
            consumer_key:     consumer_key,
            consumer_secret:  consumer_secret,
            oauth_token:      oauth_token,
            oauth_secret:     oauth_secret
          )
        end

        def consumer_key
          ENV["TRELLO_CONSUMER_KEY"]
        end

        def consumer_secret
          ENV["TRELLO_CONSUMER_SECRET"]
        end

        def oauth_token
          ENV["TRELLO_OAUTH_TOKEN"]
        end

        def oauth_secret
          ENV["TRELLO_OAUTH_SECRET"]
        end
      end
    end
  end
end
