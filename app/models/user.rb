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

  def self.to_csv
    attributes = %w{id name age}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end
end
