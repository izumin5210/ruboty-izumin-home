module Ruboty
  module TrelloReporter
    module Actions
      class GetCards < Base
        def call
          grouped_cards = cards.inject(Hash.new { |h, k| h[k] = [] }) do |grouped, card|
                card.labels.each do |label|
                  if card.due.nil?
                    grouped[label.name] << card.name
                  else
                    grouped[label.name] << "#{card.name} (~ #{card.due.strftime("%-m/%-d %H:%M")})"
                  end
                end
                grouped
              end
          message.reply(grouped_cards.map { |l, cs| "#{l}\n#{cs.map { |c| "* #{c}" }.join("\n")}" }.join("\n\n"))
        rescue Trello::Error => e
          message.reply(e.message)
        end
      end
    end
  end
end
