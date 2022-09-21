SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS ci_file;
DROP TABLE IF EXISTS ci_mcomment;
DROP TABLE IF EXISTS ci_reserv;
DROP TABLE IF EXISTS ci_movies;
DROP TABLE IF EXISTS ci_scomment;
DROP TABLE IF EXISTS ci_servlist;
DROP TABLE IF EXISTS ci_user;




/* Create Tables */

CREATE TABLE ci_file
(
	id int NOT NULL AUTO_INCREMENT,
	movie_id int NOT NULL,
	file varchar(100) NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE ci_mcomment
(
	id int NOT NULL AUTO_INCREMENT,
	user_id int NOT NULL,
	movie_id int NOT NULL,
	content text NOT NULL,
	star int NOT NULL,
	regdate datetime DEFAULT now(),
	PRIMARY KEY (id)
);


CREATE TABLE ci_movies
(
	id int NOT NULL AUTO_INCREMENT,
	title varchar(100) NOT NULL,
	genre varchar(100) NOT NULL,
	runtime int NOT NULL,
	director varchar(50) NOT NULL,
	actor varchar(100) NOT NULL,
	synopsis text NOT NULL,
	regdate datetime DEFAULT now(),
	PRIMARY KEY (id)
);


CREATE TABLE ci_reserv
(
	id int NOT NULL AUTO_INCREMENT,
	user_id int NOT NULL,
	movie_id int NOT NULL,
	seat varchar(50) NOT NULL,
	regdate datetime DEFAULT now(),
	PRIMARY KEY (id)
);


CREATE TABLE ci_scomment
(
	id int NOT NULL AUTO_INCREMENT,
	user_id int NOT NULL,
	serv_id int NOT NULL,
	content text NOT NULL,
	regdate datetime DEFAULT now(),
	PRIMARY KEY (id)
);


CREATE TABLE ci_servlist
(
	id int NOT NULL AUTO_INCREMENT,
	user_id int NOT NULL,
	title varchar(50) NOT NULL,
	content text NOT NULL,
	viewcnt int DEFAULT 0 CHECK(viewcnt >= 0),
	regdate datetime DEFAULT now(),
	PRIMARY KEY (id)
);


CREATE TABLE ci_user
(
	id int NOT NULL AUTO_INCREMENT,
	username varchar(80) NOT NULL,
	password varchar(100) NOT NULL,
	name varchar(80) NOT NULL,
	authorities varchar(200) DEFAULT 'ROLE_MEMBER',
	regdate datetime DEFAULT now(),
	PRIMARY KEY (id),
	UNIQUE (username)
);



/* Create Foreign Keys */

ALTER TABLE ci_file
	ADD FOREIGN KEY (movie_id)
	REFERENCES ci_movies (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_mcomment
	ADD FOREIGN KEY (movie_id)
	REFERENCES ci_movies (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_reserv
	ADD FOREIGN KEY (movie_id)
	REFERENCES ci_movies (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_scomment
	ADD FOREIGN KEY (serv_id)
	REFERENCES ci_servlist (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_mcomment
	ADD FOREIGN KEY (user_id)
	REFERENCES ci_user (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_reserv
	ADD FOREIGN KEY (user_id)
	REFERENCES ci_user (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_scomment
	ADD FOREIGN KEY (user_id)
	REFERENCES ci_user (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE ci_servlist
	ADD FOREIGN KEY (user_id)
	REFERENCES ci_user (id)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;



