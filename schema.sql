CREATE DATABASE backs_and_tests;

\c backs_and_tests;


CREATE TABLE backs(
id serial primary key,
name varchar(25),
height smallint,
weight smallint
);

CREATE TABLE tests(
id serial primary key,
forty_dash real,
bench_press smallint,
vertical_jump smallint,
broad_jump smallint,
grade smallint,
back_id serial,
FOREIGN KEY (back_id) REFERENCES backs(id)
);





-- drafting team - team name, rushing rank, backs drafted   
-- back - attributes: individual,height, weight



-- 40 yard dash
-- Bench Press
-- Vertical Jump
-- Broad Jump
-- 3 Cone Drill
-- Shuttle Run

