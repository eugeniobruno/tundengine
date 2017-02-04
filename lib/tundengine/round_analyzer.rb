module Tundengine
  class RoundAnalyzer < SimpleDelegator

    def result
      if last_declaration.has_tute_effect?(tute_value)
        losers_in_round_by_tute = players - last_winner_player
        losers_by_tute = in_match(losers_in_round_by_tute)
        losers_by_tute.each_with_object({}) do |k, h|
          h[k] = tute_value.points_for_loser(k, max_match_points)
        end
      else
        points_for_losers = 1
        losers = in_match(losers_in_round)
        losers.each_with_object({}) do |k, h|
          h[k] = points_for_losers
        end
      end
    end

    protected

    def in_match(players_in_round)
      players_in_round.map(&:in_match)
    end

    def losers_in_round
      capote_result = all_tricks_winner.map do |p|
        p.made_declarations? ? [p] : players - [p]
      end

      capote_result.empty? ? losers_in_round_by_points : capote_result.first
    end

    def all_tricks_winner
      players.select { |pl| (players - [pl]).all?(&:has_empty_baza?) }
    end

    def losers_in_round_by_points
      scores = players.each_with_object(Hash.new(:empty_baza)) do |p, h|
        h[p] = p.total_round_points unless p.has_empty_baza?
      end

      highest_score = scores.values.sort.last

      first_place, not_first_place = scores
        .partition { |_, s| s == highest_score }
        .map       { |pairs| Hash[pairs] }

      scores_without_highest = not_first_place.values.sort

      case losing_position
      when :second
        second_highest_score = scores_without_highest.last
        in_loser_place = scores.select { |_, s| s == second_highest_score }
      when :not_first_or_last
        lowest_score = scores_without_highest.first
        in_loser_place = scores.reject { |_, s| [highest_score, lowest_score].include? s }
      else
        raise "invalid match option: losing_position '#{losing_position}' (:second, :not_first_or_last)"
      end
      ret = [in_loser_place, first_place].map(&:keys).find { |ps| not ps.empty? }
      ret = [] if ret.length == players.length
      ret
    end

  end
end