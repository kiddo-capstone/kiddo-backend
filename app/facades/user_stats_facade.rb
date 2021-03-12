class UserStatsFacade
  def self.get_user_stats(id)
    stats = User.find_by(id: id).user_stats
    new_stats = stats.map do |stat|
      UserStat.new(stat)
    end
  end

end