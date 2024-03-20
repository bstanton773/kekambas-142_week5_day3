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







