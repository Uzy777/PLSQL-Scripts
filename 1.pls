-- Trigger that checks the data within the "books" table to ensure it is accurate, must to be greater than current date
CREATE OR REPLACE TRIGGER check_date_published
BEFORE INSERT OR UPDATE ON books
FOR EACH ROW
BEGIN
   IF :NEW.date_published > SYSDATE THEN
      RAISE_APPLICATION_ERROR(-20001, 'Date published cannot be in the future.');
   END IF;
END;
/

-- Store data within a new table "insert_book" this will be used for inserting the records later
CREATE OR REPLACE PROCEDURE insert_book (
   p_isbn VARCHAR2, -- p used as a parameter normal convention within PLSQL
   p_title VARCHAR2,
   p_summary VARCHAR2,
   p_author VARCHAR2,
   p_date_published DATE,
   p_page_count NUMBER
) AS
BEGIN
   IF LENGTH(p_isbn) <> 13 THEN
      RAISE_APPLICATION_ERROR(-20002, 'ISBN must be 13 characters long.'); -- Default length of ISBN
   END IF;


-- Insert the new values within the "books" table
   INSERT INTO books (isbn, title, summary, author, date_published, page_count)
   VALUES (p_isbn, p_title, p_summary, p_author, p_date_published, p_page_count);
END;
/

-- Insert records into the "books" table
BEGIN
   insert_book(
      p_isbn          => '1-56592-335-9',
      p_title         => 'Oracle PL/SQL Programming',
      p_summary       => 'Reference for PL/SQL developers, including examples and best practice recommendations',
      p_author        => 'Feuerstein, Steven with Bill Pribyl',
      p_date_published=> TO_DATE('01-SEP-1997', 'DD-MON-YYYY'),
      p_page_count    => 987
   );

   insert_book(
      p_isbn          => '0-14071-483-9',
      p_title         => 'The tragedy of King Richard the Third',
      p_summary       => 'Modern publication of popular Shakespeare historical play in which a treacherous royal attempts to steal the crown but dies horseless in battle.',
      p_author        => 'William Shakespeare',
      p_date_published=> TO_DATE('01-AUG-2000', 'DD-MON-YYYY'),
      p_page_count    => 158
   );

   insert_book(
      p_isbn          => '1-56592-457-6',
      p_title         => 'Oracle PL/SQL Language Pocket Reference',
      p_summary       => 'Quick-reference on Oracles PL/SQL language.',
      p_author        => 'Feuerstein, Steven with Bill Pribyl and Chip Dawes',
      p_date_published=> TO_DATE('01-APR-1999', 'DD-MON-YYYY'),
      p_page_count    => 94
   );
END;
/

-- Insert records into the "book_copies" table
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000001', '1-56592-335-9');
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000002', '1-56592-335-9');
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000015', '0-14071-483-9');
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000016', '0-14071-483-9');
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000030', '1-56592-457-6');
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000022', '1-56592-457-6');
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000020', '1-56592-457-6');



-- TESTING
-- select * from books;
-- select * from book_copies;
