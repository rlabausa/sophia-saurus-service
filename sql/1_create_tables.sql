USE devnmwvrl01;
GO


CREATE TABLE [sophiasaurus].[SOPHIASAURUS_USERS]
(
	usr_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	firstname VARCHAR(255) NOT NULL,
	lastname VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE
);
GO


CREATE TABLE [dbo].[US_STATES_TERRITORIES]
(
	state_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	state_abbreviation VARCHAR(3) UNIQUE,
	state_name VARCHAR(50) UNIQUE
);


CREATE TABLE [sophiasaurus].[AUTHORS]
(
	author_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	author_name VARCHAR(255),
	birthdate DATE
);
GO


CREATE TABLE [sophiasaurus].[PUBLISHERS]
(
	publisher_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	publisher_name VARCHAR(255) NOT NULL,
	publisher_location BIGINT NOT NULL,
	CONSTRAINT fk_publishers_publisher_location FOREIGN KEY (publisher_location) REFERENCES [dbo].[US_STATES_TERRITORIES](state_id)
);


CREATE TABLE [sophiasaurus].[GENRES]
(
	genre_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	genre_name VARCHAR(50) NOT NULL
);
GO


CREATE TABLE [sophiasaurus].[TAGS]
(
	tag_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	tag_name VARCHAR(100) NOT NULL
);
GO


CREATE TABLE [sophiasaurus].[BOOKS]
(
	book_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	book_title VARCHAR(255) NOT NULL,
	author_id BIGINT NOT NULL,
	publisher_id BIGINT NOT NULL,
	summary VARCHAR(MAX) NOT NULL,
	CONSTRAINT fk_books_author_id FOREIGN KEY (author_id) REFERENCES [sophiasaurus].[AUTHORS] (author_id)
);
GO


CREATE TABLE [sophiasaurus].[USERS_BOOKS]
(
	usr_id BIGINT,
	book_id BIGINT,
	owned BIT NOT NULL DEFAULT 0,
	favorited BIT NOT NULL DEFAULT 0,
	completed BIT NOT NULL DEFAULT 0,
	in_progress BIT NOT NULL DEFAULT 0,
	wishlist BIT NOT NULL DEFAULT 0,
	notes VARCHAR(MAX),
	PRIMARY KEY(usr_id, book_id),
	CONSTRAINT fk_usersbooks_usr_id FOREIGN KEY (usr_id) REFERENCES [sophiasaurus].[SOPHIASAURUS_USERS] (usr_id),
	CONSTRAINT fk_usersbooks_book_id FOREIGN KEY (book_id) REFERENCES [sophiasaurus].[BOOKS] (book_id)
);
GO


CREATE TABLE [sophiasaurus].[AUTHORS_BOOKS]
(
	author_id BIGINT,
	book_id BIGINT,
	PRIMARY KEY(author_id, book_id),
	CONSTRAINT fk_authorsbooks_author_id FOREIGN KEY (author_id) REFERENCES [sophiasaurus].[AUTHORS] (author_id),
	CONSTRAINT fk_authorsbooks_book_id FOREIGN KEY (book_id) REFERENCES [sophiasaurus].[BOOKS] (book_id)
);
GO


CREATE TABLE [sophiasaurus].[BOOKS_GENRES]
(
	book_id BIGINT,
	genre_id BIGINT,
	PRIMARY KEY(book_id, genre_id),
	CONSTRAINT fk_booksgenres_book_id FOREIGN KEY (book_id)  REFERENCES [sophiasaurus].[BOOKS] (book_id),
	CONSTRAINT fk_booksgenres_genre_id FOREIGN KEY (genre_id) REFERENCES [sophiasaurus].[GENRES] (genre_id)
);
GO


CREATE TABLE [sophiasaurus].[USERS_BOOKS_TAGS]
(
	usr_id BIGINT,
	book_id BIGINT,
	tag_id BIGINT,
	PRIMARY KEY(usr_id, book_id, tag_id),
	CONSTRAINT fk_usersbookstags_usr_id FOREIGN KEY (usr_id) REFERENCES [sophiasaurus].[SOPHIASAURUS_USERS] (usr_id),
	CONSTRAINT fk_usersbookstags_book_id FOREIGN KEY (book_id) REFERENCES [sophiasaurus].[BOOKS] (book_id),
	CONSTRAINT fk_usersbookstags_tag_id FOREIGN KEY (tag_id) REFERENCES [sophiasaurus].[TAGS] (tag_id)
);
GO
