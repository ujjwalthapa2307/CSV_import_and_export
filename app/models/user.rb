class User < ApplicationRecord
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row["id"]) || new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
    end
  end

  def self.updatable_attributes
    ["id", "name", "age"]
  end
end
