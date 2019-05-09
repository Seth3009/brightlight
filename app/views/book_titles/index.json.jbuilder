# This is formatted so it will work with jQuery autocomplete
json.array!(@book_titles) do |book_title|
  json.id        book_title.id
  json.label     book_title.title
  json.title     book_title.title
  json.authors   book_title.authors
  json.publisher book_title.publisher
  json.value     book_title.id
  json.image_url book_title.image_url
  json.url book_title_url(book_title, format: :json)
  
  if params[:include] == 'editions'
    json.book_editions book_title.book_editions do |book_edition|
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
