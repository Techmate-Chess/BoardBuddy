-- Active: 1725672008042@@c8851bb05e16@5432@boardbuddy@public
-- CREATE DATABASE boardbuddy;

CREATE TABLE game(
    game_id SERIAL PRIMARY KEY,
    game_white_alias_id SERIAL NOT NULL,
    game_white_rating INT NOT NULL,
    game_black_alias_id SERIAL NOT NULL,
    game_black_rating INT NOT NULL,
    result_id INT,
    metadata_id SERIAL UNIQUE,
    eco_id VARCHAR(4) NOT NULL,
    pgn_id SERIAL NOT NULL
);
CREATE TABLE metadata(
    metadata_id SERIAL PRIMARY KEY,
    metadata_type_id INT,
    metadata_value VARCHAR NOT NULL,
    CONSTRAINT fk_metadata_id 
        FOREIGN KEY(metadata_id) 
        REFERENCES game(metadata_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
CREATE TABLE metadata_type(
    metadata_type_id INT PRIMARY KEY,
    metadata_type_name VARCHAR(255) NOT NULL,
    CONSTRAINT fk_metadata_type_id 
        FOREIGN KEY(metadata_type_id) 
        REFERENCES metadata(metadata_type_id)
        ON DELETE
);
CREATE TABLE result(
    result_id INT NOT NULL PRIMARY KEY,
    result_type_id INT NOT NULL,
    result_value VARCHAR(255) NOT NULL,
    CONSTRAINT fk_metadata_type_id 
        FOREIGN KEY(metadata_type_id) 
        REFERENCES metadata(metadata_type_id)     
);
CREATE TABLE result_type(
    result_type_id INT NOT NULL PRIMARY KEY,
    result_type_name VARCHAR(255) NOT NULL
);
CREATE TABLE pgns(  
    pgn_id SERIAL PRIMARY KEY,
    pgn_path VARCHAR(255) NOT NULL
);
CREATE TABLE versions(  
    pgn_id SERIAL,
    version_id SERIAL,
    version_create_datetime TIMESTAMP NOT NULL,
    version_delt_path VARCHAR(255) NOT NULL,
    PRIMARY KEY(pgn_id, version_id)
);
CREATE TABLE pgn_resources (
    pgn_resource_id INT PRIMARY KEY,
    pgn_resource_name VARCHAR(255) NOT NULL,
    pgn_resource_path VARCHAR(255) NOT NULL
);
CREATE TABLE half_move(
    game_id SERIAL,
    move_id SERIAL,
    move_number INT NOT NULL,
    move_value VARCHAR(10) NOT NULL,
    fen_id SERIAL NOT NULL,
    PRIMARY KEY(game_id, move_id)
);
CREATE TABLE fen(
    fen_id SERIAL PRIMARY KEY,
    fen_string VARCHAR(92) NOT NULL,
    fen_sha512 VARCHAR(128) NOT NULL,
    fen_metadata_id SERIAL NOT NULL,
    material_data_id SERIAL NOT NULL
);
CREATE TABLE fen_metadata(
    fen_metadata_id SERIAL,
    fen_id SERIAL,
    fen_metadata_active_player CHAR NOT NULL,
    fen_metadata_castle_rights VARCHAR(4) NOT NULL,
    fen_en_passant_targets VARCHAR(20) NOT NULL,
    fen_halfmove_clock INT NOT NULL,
    PRIMARY KEY (fen_metadata_id, fen_id)
);
CREATE TABLE material(
    material_data_id SERIAL,
    fen_id SERIAL,
    material_value INT NOT NULL,
    material_on_board VARCHAR(20) NOT NULL,
    PRIMARY KEY(material_data_id, fen_id)
);

CREATE TABLE alias (
    alias_id SERIAL PRIMARY KEY,
    player_id SERIAL NOT NULL,
    alias_type_id INT NOT NULL,
    alias_img_path VARCHAR(255)
);

CREATE TABLE alias_type(
    alias_id SERIAL PRIMARY KEY,
    alias_type_name VARCHAR(50)
);

CREATE TABLE proper_name(
    proper_name_id SERIAL,
    alias_id SERIAL,
    proper_first_name VARCHAR(255),
    proper_last_name VARCHAR(255),
    PRIMARY KEY(proper_name_id, alias_id)
);

CREATE TABLE handle_name(
    handle_id SERIAL,
    alias_id SERIAL,
    handle_name VARCHAR(255),
    handle_source_id INT,
    PRIMARY KEY(handle_id, alias_id)
);

CREATE TABLE handle_souce(
    handle_source_id INT PRIMARY KEY,
    handle_source_name VARCHAR(20)
);

CREATE TABLE current_rating(
    current_rating_id SERIAL,
    alias_id SERIAL,
    current_rating_type_id INT,
    current_rating_value INT,
    current_rating_update_type_id INT,
    current_rating_update_datetime TIMESTAMP,
    PRIMARY KEY(current_rating_id, alias_id)
);

CREATE TABLE current_rating_update_type(
    rating_update_type_id INT PRIMARY KEY,
    rating_update_type_name VARCHAR(20)
);

CREATE TABLE rating_type(
    rating_type_id INT PRIMARY KEY,
    rating_type_name VARCHAR(20)
);

CREATE TABLE player(
    player_id SERIAL PRIMARY KEY,
    player_display_name VARCHAR(255),
    player_preferences_path VARCHAR(255),
    player_cache_path VARCHAR(255)
);

CREATE TABLE player_session (
    player_id SERIAL,
    session_id SERIAL,
    sessions_backup_path VARCHAR(255),
    PRIMARY KEY (player_id, session_id)
);