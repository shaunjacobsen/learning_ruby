require 'sequel'

DB = Sequel.connect("postgres://localhost/waterquality")

class Database

  def initialize(logger)
    DB.logger = logger
  end

  def all_entries
    DB[:entries].select_all
  end

  def get_entry(id)
    DB[:entries].where(id: id)
  end

  def compare_figures(current_id, previous_id, figure)
    set = DB[:entries].select(figure).where(id: [current_id, previous_id]).order(:id)
    comparison = set.last[:ph].to_f - set.first[:ph].to_f
    comparison
  end

  def new_entry(ph, temp, ammonia, nitrites, nitrates, notes)
    sql = "INSERT INTO entries (ph, temp, ammonia, nitrites, nitrates, notes)
          VALUES ($1, $2, $3, $4, $5, $6);"
    query(sql, ph, temp, ammonia, nitrites, nitrates, notes)
  end

  def update_entry(id, ph, temp, ammonia, nitrites, nitrates, notes)
    sql = "UPDATE entries SET ph = $1, temp = $2, ammonia = $3, nitrites = $4, nitrates = $5, notes = $6, date_updated = NOW() WHERE id = $7"
    query(sql, ph, temp, ammonia, nitrites, nitrates, notes, id)
  end

end