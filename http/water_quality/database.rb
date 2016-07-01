require 'pg'

class Database

  def initialize(logger)
    @db = PG.connect(dbname: 'waterquality')
    @logger = logger
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def all_entries
    sql = "SELECT * FROM entries;"
    result = query(sql)
    result.map do |tuple|
      { "id" => tuple['id'],
        "date" => tuple['date_entered'],
        "pH" => tuple['ph'],
        "temp" => tuple['temp'],
        "ammonia" => tuple['ammonia'],
        "nitrites" => tuple['nitrites'],
        "nitrates" => tuple['nitrates'],
        "notes" => tuple['notes']
      }
    end
  end

  def get_entry(id)
    sql = "SELECT * FROM entries WHERE id = $1"
    result = query(sql, id)
    result = result.first
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