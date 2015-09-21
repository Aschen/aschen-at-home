class Document < ActiveRecord::Base
  belongs_to :folder

  validates :name, presence: true, length: { in: 3..50 }
  validates :file_file_name, presence: true

  before_destroy :delete_file

  has_attached_file :file,
                    url: '/system/:class/:id/:basename.:extension',
                    path: ':rails_root/public/system/:class/:id/:basename.:extension'
  do_not_validate_attachment_file_type :file

  private

  def delete_file
    File.delete(file.path) if File.exist?(file.path)
  end
end
