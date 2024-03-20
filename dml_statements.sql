SELECT *
FROM blog_user;

-- Data Manipulation Language (DML)


-- Adding rows to a table
-- Syntax: INSERT INTO table_name(col_name1, col_name2, etc) VALUES (val_1, val_2, etc)

INSERT INTO blog_user(
	username,
	pw_hash,
	first_name,
	last_name,
	email_address,
	middle_name
) VALUES (
	'brians',
	'dsjgjkdsfhjdskfhjdsklfhdasfh',
	'Brian',
	'Stanton',
	'brians@ct.com',
	'Danger'
);

SELECT *
FROM blog_user;

-- Insert another user
-- Order of the columns matter - values need to match that same order!
INSERT INTO blog_user(
	first_name,
	middle_name,
	last_name,
	email_address,
	username,
	pw_hash
) VALUES (
	'Travis',
	'Redflag',
	'Peck',
	'travisp@ct.com',
	'travisp',
	'dkjvhxzcjksdfshfkljiadsfidskjfk'
);

SELECT *
FROM blog_user;


INSERT INTO blog_user(
	username,
	pw_hash,
	first_name,
	last_name,
	email_address
) VALUES (
    'kevinb',
	'dskfdsfadhdsfdasfdsfdsfh',
	'Kevin',
	'Beier',
	'kevinb@ct.com'
);

SELECT *
FROM blog_user;



-- Insert Values Only
-- Syntax: INSERT INTO table_name VALUES (val_1, val_2, etc.)
-- Values follow the original order that the columns were added
SELECT *
FROM category;

INSERT INTO category VALUES (
	1,
	'Programming',
	'Making cool programs with cool languages'
);

SELECT *
FROM category;

-- Becasue we added the first category with the manual entry of category_id = 1, the serial
-- default did not call nextval on the sequence. so, when we try to create a new category
-- using the default, it will *initially* throw an error

INSERT INTO category (
	category_name,
	description 
) VALUES (
	'Health & Fitness',
	'Get that body moving!'
);

SELECT *
FROM category;


-- Insert Multiple Rows at a time
-- Syntax:
-- INSERT INTO table_name (col_1, col_2, etc.) VALUES (val_a_1, val_a_2, etc.), (val_b_1, val_b_2, etc.);

SELECT *
FROM post;

INSERT INTO post (
	title,
	body,
	user_id
) VALUES (
	'Hello World',
	'This is the first post that we are making today!',
	1
), (
	'March Madness',
	'Who do you have winning the National Championship this year?',
	2
), (
	'Spring',
	'Spring has sprung. Yesterday was the vernal equinox',
	4
);

SELECT *
FROM post;

-- Try to add a post with a user that does not exist, will throw an error

--INSERT INTO post (title, body, user_id)
--VALUES ('Hi', 'Will this work?', 123);
-- Blog user 123 Does NOT exist! Error Thrown



-- To Update existing data in a table
-- Syntax: UPDATE table_name SET col_1 = val_1, col_2 = val_2 WHERE condition

-- User with the ID of 1 wants to change the username to 'bstanton'
UPDATE blog_user
SET username = 'bstanton'
WHERE user_id = 1;

SELECT *
FROM blog_user
ORDER BY user_id;


SELECT *
FROM blog_user 
WHERE username LIKE '%i%';

UPDATE blog_user
SET middle_name = 'ABC'
WHERE username LIKE '%i%';

SELECT *
FROM blog_user;


-- Set multiple columns in one command
SELECT *
FROM post;

UPDATE post
SET title = 'Goodbye World', body = 'The title makes this kind of depressing'
WHERE post_id = 1;

-- Alter the category table and add a color column
ALTER TABLE category
ADD COLUMN color VARCHAR(7);

SELECT *
FROM category;

-- An UPDATE/SET without a WHERE will update ALL ROWS
UPDATE category 
SET color = '#2121b0';


SELECT *
FROM category;


-- Delete data from a table
-- Syntax: DELETE FROM table_name WHERE condition
-- WHERE is not required but HIGHLY RECOMMENDED * without WHERE, every row will be deleted

SELECT *
FROM post;

DELETE FROM post 
WHERE post_id = 1;

SELECT *
FROM post;

-- A Delete From without a Where will delete all rows

SELECT *
FROM category;

DELETE FROM category;

SELECT title, first_name, last_name, p.user_id
FROM blog_user b
JOIN post p
ON b.user_id = p.user_id;


-- Delete a user that has a post
DELETE FROM blog_user
WHERE user_id = 4;

-- To make it so that when we delete a row, it will delete any rows in related tables
-- that reference that row, we will add ON DELETE CASCADE to foreign key constraint;

-- Drop the foreign key constraint on post
ALTER TABLE post
DROP CONSTRAINT post_user_id_fkey;

-- Add the foreign key back, but with the ON DELETE CASCADE clause
ALTER TABLE post
ADD FOREIGN KEY(user_id) REFERENCES blog_user(user_id) ON DELETE CASCADE;


SELECT *
FROM blog_user;

SELECT *
FROM post;


DELETE FROM blog_user
WHERE user_id = 4;

SELECT *
FROM blog_user;


SELECT *
FROM post;
