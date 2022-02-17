CREATE OR REPLACE TRIGGER CLEAN_PUBLISHER_CONTACT_NUMBER_FOR_PUBLISHERS
AFTER DELETE
ON PUBLISHERS
FOR EACH ROW
	DECLARE
	BEGIN
		DELETE FROM PUBLISHER_CONTACT_NUMBER WHERE PUBLISHER_ID = :OLD.PUBLISHER_ID;
	END;
/
