SET SERVEROUTPUT ON;

DECLARE
    -- 1. RECORD: Holds data for one single expense
    TYPE expense_rec IS RECORD (
        item_name VARCHAR2(50),
        cost      NUMBER
    );

    -- 2. COLLECTION (Nested Table): A list to hold multiple expenses
    TYPE expense_list_type IS TABLE OF expense_rec;

    -- Variables
    v_my_expenses   expense_list_type;
    v_total_spent   NUMBER := 0;
    v_budget_limit  CONSTANT NUMBER := 100; -- We cannot spend more than this

BEGIN
    -- Initialize the list
    v_my_expenses := expense_list_type();
    v_my_expenses.EXTEND(3); -- Make space for 3 items

    -- Add items to our list
    v_my_expenses(1).item_name := 'Lunch';
    v_my_expenses(1).cost      := 20;

    v_my_expenses(2).item_name := 'Taxi Ride';
    v_my_expenses(2).cost      := 30;

    v_my_expenses(3).item_name := 'Fancy Dinner'; 
    v_my_expenses(3).cost      := 80; -- This will push us over the $100 limit!

    DBMS_OUTPUT.PUT_LINE('--- Processing Expenses ---');

    -- Loop through the collection
    FOR i IN 1 .. v_my_expenses.COUNT LOOP
        -- Add cost to total
        v_total_spent := v_total_spent + v_my_expenses(i).cost;
        
        DBMS_OUTPUT.PUT_LINE('Added: ' || v_my_expenses(i).item_name || ' ($' || v_my_expenses(i).cost || ')');

        -- 3. GOTO Logic: Check if we broke the budget
        IF v_total_spent > v_budget_limit THEN
            GOTO budget_overflow; -- Jump immediately to the error section
        END IF;
    END LOOP;

    -- This section only runs if we stayed within budget
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    DBMS_OUTPUT.PUT_LINE('Success! Total spent: $' || v_total_spent);
    
    RETURN; -- Stop here! Don't run the error code below.

    -- The Label for GOTO
    <<budget_overflow>>
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    DBMS_OUTPUT.PUT_LINE('ERROR: Budget Exceeded!');
    DBMS_OUTPUT.PUT_LINE('You tried to spend $' || v_total_spent || ' but limit is $' || v_budget_limit);

END;
/