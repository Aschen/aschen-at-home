FactoryGirl.define do
  factory :id_card, class: Document  do
    name 'Carte d\'identité'
    folder_id Folder.first.id
    file_file_name 'carte_identite.jpg'
    file_content_type 'image/jpeg'
    file_file_size 424242
    file_updated_at Date.today
  end

  factory :document, class: Document  do
    name 'Doc'
    folder_id Folder.first.id
    file_file_name 'document.pdf'
    file_content_type 'application/pdf'
    file_file_size 424242
    file_updated_at Date.today
  end
end
