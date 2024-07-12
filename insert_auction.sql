CREATE OR REPLACE PROCEDURE insert_auction(acct_id IN VARCHAR2, Bidder IN VARCHAR2,b_time IN TIMESTAMP, b_price IN NUMBER, result OUT NUMBER)
AS 
top_number NUMBER := 0;
starts TIMESTAMP;
ends TIMESTAMP;
counts number;
BEGIN
  SELECT bid_start, bid_end INTO starts, ends FROM auctions WHERE auction_id = acct_id;
  
  IF b_time >= starts AND b_time < ends THEN
    SELECT CASE WHEN MAX(bid_no) IS NULL THEN 0 ELSE MAX(bid_no) END INTO top_number FROM bid_log WHERE auction_id = acct_id;
    top_number := top_number + 1;
    INSERT INTO bid_log VALUES(acct_id, top_number, Bidder, b_time, b_price);
    UPDATE auctions SET current_Bid = b_price WHERE auction_id = acct_id;

 
    select count(*) into counts from bids b where auction_id = acct_id AND bidder = Bidder;
if counts = 0 then INSERT INTO bids values(Bidder, acct_id);
end if;
    
    result := 1; -- Assigning the result to the OUT parameter
  ELSE
    result := 0; -- Assigning the result to the OUT parameter
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    result := -1; -- Assigning the result to the OUT parameter
END;
/
