-- Use the database
USE passwords;

--CRUD Operations...

--CREATE a new entry (a new acc for myself on Git)
INSERT INTO account_credentials (username, password, email_address, user_id, site_id, comment) VALUES ('M2RHRV', AES_ENCRYPT('SuperSecurePass2025', @key_str, @init_vector), 'mimir03@gmail.com', 1, 2, 'Second GitHub account for my projects');

--READ the password for a given URL
SELECT a.username,
       AES_DECRYPT(a.password, @key_str, @init_vector) AS decrypted_password
FROM account_credentials a
JOIN websites w ON a.site_id = w.site_id
WHERE w.url = 'https://www.netflix.com/browse';

--READ all password-related data for HTTPS URLs
SELECT u.first_name, u.last_name,
       w.site_name, w.url,
       a.username, a.email_address,
       AES_DECRYPT(a.password, @key_str, @init_vector) AS decrypted_password,
       a.comment, a.time_stamp
FROM account_credentials a
JOIN users u ON a.user_id = u.user_id
JOIN websites w ON a.site_id = w.site_id
WHERE w.url LIKE 'https%';


--UPDATE a password (change my Nintendo password)
UPDATE account_credentials
SET password = AES_ENCRYPT('ILoveNintendoSwitch2', @key_str, @init_vector)
WHERE username = 'Harvmeister';

--DELETE an entry by its URL
DELETE a
FROM account_credentials a
JOIN websites w ON a.site_id = w.site_id
WHERE w.url = 'https://www.isc2.org/';

--DELETE an entry by the password 
DELETE FROM account_credentials
WHERE password = AES_ENCRYPT('NarainIsTheBest', @key_str, @init_vector);
