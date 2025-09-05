DELETE FROM ivruser.fraud_db_allHostname
WHERE hostname = 'test-host.example.com';


INSERT INTO ivruser.fraud_db_allHostname (hostname)
VALUES ('test-host.example.com');
