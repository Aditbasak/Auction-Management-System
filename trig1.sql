-- Trigger to update shipment table after payment insertion
CREATE OR REPLACE TRIGGER mytrig1
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    DECLARE
        v_shipment_id VARCHAR2(5);
	prod varchar(5);
    BEGIN
        -- Generate a random shipment ID
        v_shipment_id := GenerateRandomShipmentId;
        select product into prod from auctions where auction_id = :NEW.auction_id;
        -- Insert into the shipment table
        INSERT INTO shipment (shipment_id, shipdate, deliverydate, product)
        VALUES (v_shipment_id, SYSDATE, SYSDATE + 4, prod);
    END;
END;
/
