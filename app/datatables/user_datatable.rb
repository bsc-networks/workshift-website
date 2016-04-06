class UserDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(User.first_name User.last_name User.email)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(User.first_name User.last_name User.email)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.first_name,
        record.last_name,
        record.email
      ]
    end
  end

  def get_raw_records
    # insert query here
    User.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
