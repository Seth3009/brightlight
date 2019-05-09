json.book_title do
  json.id               @book_title.id
  json.title            @book_title.title
  json.authors          @book_title.authors
  json.publisher        @book_title.publisher
  json.image_url        @book_title.image_url
  json.subject_name     @book_title.subject.try(:name)
  json.subject_code     @book_title.subject.try(:code)
  json.created_at       @book_title.created_at
  json.updated_at       @book_title.updated_at

  if params[:include] == 'editions'
    json.book_editions @book_title.book_editions do |book_edition|
      json.id               book_edition.id
      json.title            book_edition.title
      json.isbn10           book_edition.isbn10
      json.isbn13           book_edition.isbn13
      json.authors          book_edition.authors
      json.publisher        book_edition.publisher
      json.price            book_edition.price
      json.currency         book_edition.currency
      json.small_thumbnail  book_edition.small_thumbnail
    end
  end
end