class Daddy < ApplicationRecord

  def self.import_daddies(file)
    daddies = []
    CSV.foreach(file, headers: true) do |row|
      daddies << self.new(name: row[0], email: row[1]) if is_member(row[8])
    end

    self.import!(daddies)
  end

  private

  def self.is_member(tier)
    tier && tier == 'Member'
  end

end
