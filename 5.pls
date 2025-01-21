-- Procedure to delete a book and its copies from within both tables "book_copies" and "books"
CREATE OR REPLACE PROCEDURE deleteBookAndCopies (p_isbn VARCHAR2) AS
BEGIN
   DELETE FROM book_copies WHERE isbn = p_isbn;
   DELETE FROM books WHERE isbn = p_isbn;
END;
/

-- Call the procedure and delete a book and its copies
BEGIN
   DECLARE
      v_isbn_to_delete VARCHAR2(13) := '1-56592-335-9'; -- CHANGE ISBN BASED ON WHAT YOU WANT DELTED
   BEGIN
      deleteBookAndCopies(v_isbn_to_delete);
-- Output to us the following fixed and variable data
      DBMS_OUTPUT.PUT_LINE('Book with ISBN ' || v_isbn_to_delete || ' and its copies deleted.');
   EXCEPTION
      WHEN OTHERS THEN
-- Output some validation data if things go wrong.
         DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
   END;
END;
/


-- TESTING
-- select * from books;
-- select * from book_copies;
