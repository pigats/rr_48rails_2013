# n libri per classe
books = []
a = School.find(...)

School.all.each { |s| books = []; s.courses.each { |c| c.school_classes.each { |sc| sc.adoptions.each { |ad| books.push ad.book_id }}}}

books.uniq!.count

# Spesa libri nuovi per classe
School.all.each { |s| s.courses.each { |c| c.school_classes.each { |sc| total = sc.adoptions.inject(0) { |sum, ad| sum += ad.owned? 0 : ad.book.price}; puts s.short_url + " " + c.short_url + " " + sc.name + " " + total.to_s + "€"}}}

# Risparmio libri nuovi per classe
School.all.each { |s| 
  s.courses.each { |c| 
    c.school_classes.each { |sc| 
      save = sc.adoptions.inject(0) { |sum, ad| 
        p = Announcement.find_by_book_id(ad.book.id, :order => 'price ASC'); 
        if (p.nil? or p.price > ad.book.price) then p = 0
        else p = ad.book.price - p.price end
        sum += ad.owned ? 0 : p 
      } 
      puts s.short_url + " " + c.short_url + " " + sc.name + " " + save.to_s + "€"
    }
  }
}


# n libri con almeno un annuncio
Book.all.inject(0) { |sum, b| sum += Announcement.find_by_book_id(b.id).nil? ? 0 : 1 }
# n libri che hanno avuto almeno un annuncio
Book.all.inject(0) { |sum, b| sum += Announcement.find_by_sql(['SELECT id FROM announcements WHERE book_id = ?', b.id]).empty? ? 0 : 1 }

# n libri che hanno avuto almeno un annuncio per scuola
School.all.each { |s| s.courses.each { |c| c.school_classes.each { |sc| n_books = 0; n_books_with_announcements = 0; sc.adoptions.each { |ad| 
  n_books += 1;
  n_books_with_announcements += Announcement.find_by_sql(['SELECT id FROM announcements WHERE book_id = ?', ad.book_id]).empty? ? 0 : 1
}
puts s.short_url + " " + c.short_url + " " + sc.name + " libri: " + n_books.to_s + " - con annunci: " + n_books_with_announcements.to_s + " - copertura MercatinoLibri: " + (100 * n_books_with_announcements / n_books).to_s + "%" }}}




School.all.each { |s| books = []; s.courses.each { |c| c.school_classes.each { |sc| sc.adoptions.each { |ad| books.push ad.book_id }}}; total = books.uniq!.inject(0) { |sum, b_id| sum += Announcement.find_by_sql(['SELECT id FROM announcements WHERE book_id = ?', b_id]).empty? ? 0 : 1 }; puts s.short_url + " - n libri: " + books.length + " - n libri con annunci: " + total + " - copertura: " + (100 * total / books.length) + "%"}


School.all.each { |s| books = []; s.courses.each { |c| c.school_classes.each { |sc| sc.adoptions.each { |ad| books.push ad.book_id }}}; total = books.uniq!.inject(0) { |sum, b_id| announcements = Announcement.find_by_sql(['SELECT id FROM announcements WHERE book_id = ?', b_id]); sum += announcements.empty? ? 0 : announcements.length }; puts s.short_url + " - n annunci: " + total.to_s }


# libri condivisi dalle scuole
adoptions = Hash.new(0)
Book.all.each do |b|
  key = [];
  Adoption.find_all_by_book_id(b.id).each do |a|
    school = a.school_class.course.school.short_url
    key.push school unless key.include?(school)
  end
  adoptions[key.sort] += 1
end
puts adoptions


adoptions = Hash.new([])
Book.all.uniq.each do |b|
  key = []
  Adoption.find_all_by_book_id(b.id).each do |a|
    school = a.school_class.course.school.short_url
    key.push school unless key.include?(school)
  end
  adoptions[key.sort].push b.id
end
puts adoptions



#n annunci divisi per intersezione fra scuole

adoptions = Hash.new(0)
Book.all.uniq.each do |b|
  key = [];
  Adoption.find_all_by_book_id(b.id).each do |a|
    school = a.school_class.course.school.short_url
    key.push school unless key.include?(school)
  end
  if (key == []) then puts 'attenzioneeee ' + b.isbn + " " + b.id.to_s end
  a = Announcement.find_by_sql(['SELECT id FROM announcements WHERE book_id = ? AND (deleted_at IS NULL OR deleted_at > ?)', b.id, Date.new(2013,06,01)])
  adoptions[key.sort] += a.empty? ? 0 : a.length
end
puts adoptions



