In **Oracle SQL Developer**, there’s no direct `DROP TABLE IF EXISTS` like in MySQL.
Instead, you need to check if the table exists, and drop it safely.

Here’s a rollback-friendly way:

```sql
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employee_liquibase_for_prod_testing CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- ORA-00942: table or view does not exist
         RAISE;
      END IF;
END;
/
```

### Explanation:

* `CASCADE CONSTRAINTS` ensures dependent constraints (like foreign keys) are also dropped.
* `SQLCODE = -942` is the Oracle error when a table doesn’t exist → we ignore that.
* This way, the script won’t fail if the table is already gone.

👉 Do you want me to also show you how this would look inside a **Liquibase rollback block** (XML/YAML/SQL format), so you can plug it in directly?
