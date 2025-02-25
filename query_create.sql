CREATE TYPE GENDER AS ENUM('m', 'f');

CREATE TABLE sound(
    id SERIAL PRIMARY KEY,
    name TEXT DEFAULT 'какой-то звук',
    volume SMALLINT NOT NULL CONSTRAINT zero_to_hundred CHECK (volume >= 0 AND volume <= 100)
);

CREATE TABLE diet(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE swarm(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE action(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE biom(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);



CREATE TABLE dino_type(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    habitat_biom_id INTEGER REFERENCES biom(id) ON DELETE SET NULL
);

CREATE TABLE location(
    id SERIAL PRIMARY KEY,
    name TEXT DEFAULT 'какая-то локация',
    biom_id INTEGER NOT NULL REFERENCES biom(id) ON DELETE CASCADE,
    parent_location_id INTEGER REFERENCES location(id) ON DELETE CASCADE
);

CREATE TABLE dinosaur(
    id SERIAL PRIMARY KEY,
    name TEXT DEFAULT 'безымянный динозавр',
    gender GENDER NOT NULL,
    age integer DEFAULT 0 CONSTRAINT positive CHECK (age >= 0),
    dino_type_id INTEGER REFERENCES dino_type(id) ON DELETE CASCADE,
    current_swarm_id INTEGER REFERENCES swarm(id) ON DELETE SET NULL,
    parent_dino_id INTEGER REFERENCES dinosaur(id) ON DELETE SET NULL,
    current_location_id INTEGER REFERENCES location(id) ON DELETE SET NULL
);



CREATE TABLE dino_to_action(
    id SERIAL PRIMARY KEY,
    dino_id INTEGER REFERENCES dinosaur(id) ON DELETE CASCADE,
    action_id INTEGER REFERENCES action(id)
);

CREATE TABLE dinotype_to_sound(
    id SERIAL PRIMARY KEY,
    dinotype_id INTEGER REFERENCES dino_type(id) ON DELETE CASCADE,
    sound_id INTEGER REFERENCES sound(id)
);

CREATE TABLE dinotype_to_diet(
    id SERIAL PRIMARY KEY,
    dinotype_id INTEGER REFERENCES dino_type(id),
    diet_id INTEGER REFERENCES diet(id)
);