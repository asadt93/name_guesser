class Archive < ApplicationRecord
  default_scope do 
    from_date = (Time.current - 1.month).to_date
    to_date = Time.current.to_date
    where('to_timestamp(CAST("timestamp" as bigint))::date between ? and ?', from_date, to_date)
  end

  before_save do
    self.timestamp = Time.current.to_i unless self['timestamp'].present?
  end
end