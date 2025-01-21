-- Procedure that will count from the "books_copies" table depending on value
CREATE OR REPLACE TRIGGER report_book_copies
AFTER INSERT OR UPDATE OR DELETE ON book_copies
DECLARE
   v_count NUMBER;
BEGIN
   -- Get the count of book copies
   SELECT COUNT(*) INTO v_count FROM book_copies;

   -- Print the count
   DBMS_OUTPUT.PUT_LINE('Number of book copies: ' || v_count);
END;
/

-- Comment / Uncomment based on which action you want to perform - INSERT/UPDATE/DELETE
-- A shortcut that you can use is [CTRL + /] after highlighting the 2 code lines :)

-- Insert a new record into the "book_copies" table
INSERT INTO book_copies (barcode_id, isbn) VALUES ('100000090', '1-56592-457-6');   -- CHANGE DATA IF YOU WANT

-- Update a record in the "book_copies" table
UPDATE book_copies SET isbn = '1-56592-457-6' WHERE barcode_id = '100000001'; -- CHANGE DATA IF YOU WANT

-- Delete a record from the "book_copies" table
DELETE FROM book_copies WHERE barcode_id = '100000020';  -- CHANGE DATA IF YOU WANT



-- TESTING
-- select * from books;
-- select * from book_copies;
