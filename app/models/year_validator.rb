class YearValidator < ActiveModel::Validator

  def validate(record)
    begin
      if record.year > Date.today.year
        record.errors[:year] << ": must be  <=#{Date.today.year}"
      elsif record.year <1040
         record.errors[:year] << ": must be >=1040"
      end
    rescue
      record.errors[:year] << ": Wrong value"
    end
  end
end
