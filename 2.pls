-- Procedure that will count from the "books" table depending on value
CREATE OR REPLACE PROCEDURE get_book_count (p_count OUT NUMBER) AS
BEGIN
   SELECT COUNT(*) INTO p_count FROM books;
END;
/

-- Calling the procedure for the book counting to be displayed
DECLARE
   v_book_count NUMBER;
BEGIN
   get_book_count(p_count => v_book_count);
-- Output to us the following fixed and variable data
   DBMS_OUTPUT.PUT_LINE('Total Number of Books: ' || v_book_count);
END;
/


-- TESTING
-- select * from books;
-- select * from book_copies;
