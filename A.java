DELETE FROM ivruser.fraud_db_allHostname
WHERE hostname = 'test-host.example.com';


INSERT INTO ivruser.fraud_db_allHostname (hostname)
VALUES ('test-host.example.com');


Got it 👍
Based on your table **`ivruser.fraud_db_report_status`** (columns: `REPORT_DATE DATE, FILENAME VARCHAR2(100), FILEWRITE_STATUS CHAR(1), REPORT_CREATED_DATE DATE`), here are examples for **INSERT, UPDATE, and DELETE** queries:

---

### 🔹 **INSERT**

```sql
INSERT INTO ivruser.fraud_db_report_status
    (report_date, filename, filewrite_status, report_created_date)
VALUES
    (TO_DATE('09/04/2025','MM/DD/YYYY'),
     'fraud_report_sep04.csv',
     'Y',
     SYSDATE);
```

* `TO_DATE` used for explicit date insertion.
* `'Y'` is just an example status (since `CHAR(1)` usually stores flags like Y/N).
* `SYSDATE` inserts the current system date/time.

---

### 🔹 **UPDATE**

```sql
UPDATE ivruser.fraud_db_report_status
SET filewrite_status = 'N',
    report_created_date = SYSDATE
WHERE filename = 'fraud_report_sep04.csv';
```

* Updates one row by matching `filename`.
* You can also filter using `report_date` or any unique condition.

---

### 🔹 **DELETE**

```sql
DELETE FROM ivruser.fraud_db_report_status
WHERE filename = 'fraud_report_sep04.csv';
```

* Removes the row based on `filename`.
* If multiple rows exist with the same `filename`, they will all be deleted.

---

⚠️ If you want to **delete only one row even if duplicates exist**, you can do:

```sql
DELETE FROM ivruser.fraud_db_report_status
WHERE filename = 'fraud_report_sep04.csv'
  AND ROWNUM = 1;
```

---

Do you want me to also create a **MERGE (upsert) query** so you can insert if not exists, or update if exists?
