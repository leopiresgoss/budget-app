class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  def validate_authors_ids(record)
    raise Exception, 'Different authors' if record.author_id != author_id
  end
end
