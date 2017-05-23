module ApplicationHelper

  def happiness
    count = 0
    self.characters.each {|char| (char.dislike && !char.deceased || !char.dislike && char.deceased) ? count -= 0.5 : count += 0.5}
    ((count.to_f / self.characters.size * 100) + 50).round(1)
  end

  def sort_by_name_length
    self.sort_by { |item| item.name.length }
  end

end
