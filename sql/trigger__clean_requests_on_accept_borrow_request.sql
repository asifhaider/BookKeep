CREATE OR REPLACE TRIGGER CLEAN_REQUESTS_ON_ACCEPT_BORROW_REQUEST
AFTER INSERT
ON BORROWS
FOR EACH ROW
	DECLARE
		V_ISBN VARCHAR2(16);
	BEGIN
		SELECT ISBN INTO V_ISBN FROM BORROWABLE_ITEMS WHERE BORROWABLE_ITEM_ID = :NEW.BORROWABLE_ITEM_ID;
		DELETE FROM REQUESTS WHERE CUSTOMER_ID = :NEW.CUSTOMER_ID AND ISBN = V_ISBN;
	END;
/
