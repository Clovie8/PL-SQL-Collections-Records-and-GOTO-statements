# PL/SQL Collections, Records and GOTO statements
PL/SQL Expense Tracker

This PL/SQL script simulates a Budget Enforcement System. It processes a list of personal expenses sequentially. As soon as the cumulative total exceeds a predefined limit ($100), the system triggers an emergency exit using a GOTO statement, simulating a "circuit breaker" logic that prevents further processing.

Architecture & Concepts
<pre>
A. PL/SQL Records (TYPE ... IS RECORD)
  
A Record is a composite data type. It allows you to group different pieces of information (fields) into a single logical unit.
   •	Analogy: A "Row" in a database table or a "Struct" in C/C++.
   •	In this script: expense_rec groups the item_name (Text) and cost (Number).
   •	TYPE expense_rec IS RECORD (
   •	    item_name VARCHAR2(50),
   •	    cost      NUMBER
   •	);

  
B. PL/SQL Collections (TYPE ... IS TABLE)
  
A Collection is an ordered group of elements, all of the same type.
   •	Analogy: An Array or a List in Java/Python.
   •	In this script: We use a Nested Table (expense_list_type). It holds a list of our expense_rec records.
   •	Key Operations:
           o	v_my_expenses.EXTEND(3): Nested tables are initially empty. We must explicitly allocate memory for rows.
           o	v_my_expenses(i): We access elements using a numeric index (1-based).

  
C. The GOTO Statement
  
The GOTO statement performs an unconditional branch to a labeled line of code.
   •	Syntax: GOTO label_name; jumps to <<label_name>>.
   •	Use Case: While often avoided in modern programming, GOTO is valid in PL/SQL for specific scenarios:
           o	Exiting deeply nested loops.
           o	Jumping to a specific error handling block that is not a standard SQL Exception.
</pre>
