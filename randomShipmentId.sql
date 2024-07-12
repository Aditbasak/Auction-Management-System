-- Function to generate a random shipment ID
CREATE OR REPLACE FUNCTION GenerateRandomShipmentId RETURN VARCHAR2
IS
    v_chars VARCHAR2(36) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    v_shipment_id VARCHAR2(5);
    shipment_count number;
BEGIN
    LOOP
        v_shipment_id := 'SH';
        FOR i IN 1..3 LOOP
            v_shipment_id := v_shipment_id || SUBSTR(v_chars, TRUNC(DBMS_RANDOM.VALUE(1, LENGTH(v_chars) + 1)), 1);
        END LOOP;

        -- Check if the generated shipment ID already exists
        SELECT COUNT(*)
        INTO   shipment_count
        FROM   shipment
        WHERE  shipment_id = v_shipment_id;

        EXIT WHEN shipment_count = 0;
    END LOOP;

    RETURN v_shipment_id;
END;
/

