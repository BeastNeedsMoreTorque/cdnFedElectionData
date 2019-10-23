
-- Create the DB tables to hold the raw data.


CREATE SCHEMA IF NOT EXISTS raw_data;

DROP TABLE IF EXISTS raw_data.recent;
CREATE TABLE raw_data.recent (
	election INT NOT NULL,
	ed_id	INT NOT NULL,
	ed_name TEXT NOT NULL,
	ed_name_fr TEXT NOT NULL,
	poll_id TEXT NOT NULL,
	poll_name TEXT NOT NULL,
	poll_void BOOLEAN NOT NULL,
	poll_not_held BOOLEAN NOT NULL,
	merge_with TEXT,
	ballots_rejected INT NOT NULL,
	num_electors INT NOT NULL,
	cand_last TEXT NOT NULL,
	cand_middle TEXT NOT NULL,
	cand_first TEXT NOT NULL,
	cand_party_name TEXT NOT NULL,
	cand_party_fr TEXT NOT NULL,
	cand_incumbent BOOLEAN NOT NULL,
	cand_elected BOOLEAN NOT NULL,
	cand_votes INT NOT NULL
);


DROP TABLE IF EXISTS raw_data.history;
CREATE TABLE raw_data.history (
	election_date TEXT NOT NULL,
	election_type TEXT NOT NULL,
	election INT NOT NULL,
	province TEXT NOT NULL,
	ed_name TEXT NOT NULL,
	cand_last TEXT NOT NULL,
	cand_first TEXT,
	cand_gender TEXT,
	cand_occupation TEXT,
	cand_party_name TEXT NOT NULL,
	cand_votes_raw TEXT,
	cand_votes_pct REAL,
	cand_elected BOOLEAN NOT NULL
);



DROP TABLE raw_data.party_names;
CREATE TABLE raw_data.party_names (
    raw_name   TEXT NOT NULL,
    party_name TEXT NOT NULL,
    PRIMARY KEY (raw_name)
);

COMMENT ON TABLE raw_data.party_names IS 'Normalize names to just one common name across all elections.';
-- This list was created by extracting all the party names from elections 1 through 42 and then
-- and then reviewing it by hand.  The obvious differences were collapsed into one name (eg "N.D.P."
-- and "NDP-New Democratic Party").  Minimal research was done.

INSERT INTO raw_data.party_names (raw_name, party_name)
VALUES ('Abolitionist Party of Canada', 'Abolitionist Party of Canada'),

       ('Animal Alliance Environment Voters Party of Canada', 'Animal Alliance Environment Voters Party of Canada'),
       ('Animal Alliance/Environment Voters', 'Animal Alliance Environment Voters Party of Canada'),

       ('Anti-Confederate', 'Anti-Confederate'),
       ('Bloc Québécois', 'Bloc Québécois'),
       ('Bloc populaire canadien', 'Bloc populaire canadien'),
       ('Canada Party', 'Canada Party'),

       ('Canadian Action', 'Canadian Action Party'),
       ('Canadian Action Party', 'Canadian Action Party'),
       ('CAP', 'Canadian Action Party'),

       ('Canadian Alliance', 'Canadian Alliance'),

       ('Christian Heritage Party', 'Christian Heritage Party'),
       ('Christian Heritage Party of Canada', 'Christian Heritage Party'),
       ('CHP Canada', 'Christian Heritage Party'),

       ('Co-operative Commonwealth Federation', 'Co-operative Commonwealth Federation'),

       ('Communist', 'Communist Party of Canada'),
       ('Communist Party of Canada', 'Communist Party of Canada'),

       ('Confederation of Regions Western Party', 'Confederation of Regions Western Party'),

       ('Conservative', 'Conservative Party of Canada'),
       ('Conservative Party of Canada', 'Conservative Party of Canada'),

       ('First Peoples National Party of Canada', 'First Peoples National Party of Canada'),
       ('Forces et Démocratie - Allier les forces de nos régions',
        'Forces et Démocratie - Allier les forces de nos régions'),
       ('Government', 'Government'),

       ('Green Party', 'Green Party of Canada'),
       ('Green Party of Canada', 'Green Party of Canada'),

       ('Independent', 'Independent'),
       ('Independent Co-operative Commonwealth Federation', 'Independent'),
       ('Independent Conservative', 'Independent'),
       ('Independent Labor', 'Independent'),
       ('Independent Liberal', 'Independent'),
       ('Independent Liberal Progressive', 'Independent'),
       ('Independent Nationalist', 'Independent'),
       ('Independent Progressive', 'Independent'),
       ('Independent Progressive Conservative', 'Independent'),
       ('Independent Reconstruction Party', 'Independent'),
       ('Independent Social Credit', 'Independent'),

       ('No Affiliation', 'Independent'),
       ('No affiliation to a recognised party', 'Independent'),
       ('Locataire (candidat)', 'Independent'),

       -- The following "parties" have all run fewer than 10 candidates, ever.
       -- They're really just independents.
       ('AACEV Party of Canada', 'Independent'),
       ('ATN', 'Independent'),
       ('All Canadian Party', 'Independent'),
       ('Anti-Communist', 'Independent'),
       ('Anti-Conscriptionist', 'Independent'),
       ('Autonomist', 'Independent'),
       ('Canadian Democrat', 'Independent'),
       ('Canadian Labour', 'Independent'),
       ('Canadian Party', 'Independent'),
       ('Candidat libéral des électeurs', 'Independent'),
       ('Candidats des électeurs', 'Independent'),

       ('Capital  familial', 'Independent'),
       ('Christian Liberal', 'Independent'),
       ('Conservative-Labour', 'Independent'),
       ('Cooperative Builders of Canada', 'Independent'),
       ('Democrat', 'Independent'),
       ('Democratic Advancement', 'Independent'),
       ('Droit vital personnel', 'Independent'),
       ('Equal Rights', 'Independent'),
       ('Esprit social', 'Independent'),
       ('FPNP', 'Independent'),
       ('Farmer', 'Independent'),
       ('Farmer Labour', 'Independent'),
       ('Farmer-United Labour', 'Independent'),
       ('Franc Lib', 'Independent'),
       ('Labour Farmer', 'Independent'),
       ('Liberal Conservative Coalition', 'Independent'),
       ('Liberal Labour Progressive', 'Independent'),
       ('Liberal Protectionist', 'Independent'),
       ('National Credit Control', 'Independent'),
       ('National Labour', 'Independent'),
       ('National Liberal Progressive', 'Independent'),
       ('National Liberal and Conservative Party', 'Independent'),
       ('National Socialist', 'Independent'),
       ('National Unity', 'Independent'),
       ('Nationalist Conservative', 'Independent'),
       ('Nationalist Liberal', 'Independent'),
       ('New Canada Party', 'Independent'),
       ('New Party', 'Independent'),
       ('Newfoundland and Labrador First Party', 'Independent'),
       ('Non-Partisan League', 'Independent'),
       ('Opposition-Labour', 'Independent'),
       ('Ouvrier indépendent', 'Independent'),
       ('PACT', 'Independent'),
       ('Parti de la Démocratisation Économique', 'Independent'),
       ('Parti humain familial', 'Independent'),
       ('Parti ouvrier canadien', 'Independent'),
       ($$People's Political Power Party of Canada$$, 'Independent'),
       ('Progressive Workers Movement', 'Independent'),
       ('Prohibition', 'Independent'),
       ('Protectionist', 'Independent'),
       ('Protestant Protective Association', 'Independent'),
       ('Radical chrétien', 'Independent'),
       ('Republican', 'Independent'),
       ('Republican Party', 'Independent'),
       ('Seniors Party', 'Independent'),
       ('Social Credit-National Unity', 'Independent'),
       ('Socialist Labour', 'Independent'),
       ('Technocrat', 'Independent'),
       ('The Bridge', 'Independent'),
       ('Trades Union', 'Independent'),
       ('United Party', 'Independent'),
       ('United Party of Canada', 'Independent'),
       ('United Progressive', 'Independent'),
       ('United Reform', 'Independent'),
       ('United Reform Movement', 'Independent'),
       ('Unity', 'Independent'),
       ('Unité nationale', 'Independent'),
       ('Verdun', 'Independent'),
       ('Veterans Party', 'Independent'),
       ('Work Less Party', 'Independent'),


       ('Labour', 'Labour'),
       ('Labour Progressive Party', 'Labour Progressive Party'),
       ('Liberal', 'Liberal'),

       ('Liberal Labour', 'Liberal Labour Party'),
       ('Liberal Labour Party', 'Liberal Labour Party'),

       ('Liberal Progressive', 'Liberal Progressive'),
       ('Liberal-Conservative', 'Liberal-Conservative'),

       ('Libertarian', 'Libertarian Party of Canada'),
       ('Libertarian Party of Canada', 'Libertarian Party of Canada'),


       ('Marijuana Party', 'Marijuana Party'),
       ('Radical Marijuana', 'Marijuana Party'),

       ('Marxist-Leninist', 'Marxist-Leninist Party'),
       ('Marxist-Leninist Party', 'Marxist-Leninist Party'),

       ('McCarthyite', 'McCarthyite'),

       ('N.D.P.', 'New Democratic Party'),
       ('NDP-New Democratic Party', 'New Democratic Party'),
       ('New Democratic Party', 'New Democratic Party'),

       ('National Government', 'National Government'),
       ('National Party of Canada', 'National Party of Canada'),
       ('Nationalist', 'Nationalist'),
       ('Natural Law Party of Canada', 'Natural Law Party of Canada'),
       ('New Democracy', 'New Democracy'),
       ('Opposition', 'Opposition'),
       ('Parti Nationaliste du Québec', 'Parti Nationaliste du Québec'),
       ('Party for the Commonwealth of Canada', 'Party for the Commonwealth of Canada'),
       ('Patrons of Industry', 'Patrons of Industry'),


       ('Pirate', 'Pirate Party of Canada'),
       ('Pirate Party', 'Pirate Party of Canada'),
       ('Pirate Party of Canada', 'Pirate Party of Canada'),

       ('Progressive', 'Progressive'),
       ('Progressive Canadian Party', 'Progressive Canadian Party'),

       ('Progressive Conservative', 'Progressive Conservative Party'),
       ('PC Party', 'Progressive Conservative Party'),

       ('Ralliement Créditiste', 'Ralliement Créditiste'),
       ('Reconstruction Party', 'Reconstruction Party'),

       ('Reform', 'Reform Party of Canada'),
       ('Reform Party of Canada', 'Reform Party of Canada'),

       ('Rhinoceros', 'Rhinoceros'),
       ('neorhino.ca', 'Rhinoceros'),
       ('Parti Rhinocéros', 'Rhinoceros'),

       ('Social Credit Party of Canada', 'Social Credit Party of Canada'),
       ('Socialist', 'Socialist'),
       ('Union Populaire', 'Union Populaire'),
       ('Union of Electors', 'Union of Electors'),

       ('United Farmers', 'United Farmers'),
       ('United Farmers of Alberta', 'United Farmers'),
       ('United Farmers of Ontario', 'United Farmers'),
       ('United Farmers of Ontario-Labour', 'United Farmers'),
       ('United Farmers-Labour', 'United Farmers'),

       ('Unknown', 'Unknown'),

       ('WBP', 'Western Block Party'),
       ('Western Block Party', 'Western Block Party')
       ;

DROP TABLE IF EXISTS raw_data.provinces;
CREATE TABLE raw_data.provinces (
    raw_code  TEXT NOT NULL,
    prov_code TEXT NOT NULL,

    PRIMARY KEY (raw_code)
);

COMMENT ON TABLE raw_data.provinces IS 'A look-up table to normalize province codes.';

-- For recent data, the province info is embedded in the first two digits electoral district id.
-- For historical data, it's spelled out.
INSERT INTO raw_data.provinces (raw_code, prov_code)
VALUES ('48', 'AB'),
       ('59', 'BC'),
       ('46', 'MB'),
       ('13', 'NB'),
       ('10', 'NL'),
       ('12', 'NS'),
       ('61', 'NT'),
       ('62', 'NU'),
       ('35', 'ON'),
       ('11', 'PE'),
       ('24', 'QC'),
       ('47', 'SK'),
       ('60', 'YK'),
       ('Saskatchewan', 'SK'),
       ('New Brunswick', 'NB'),
       ('Quebec', 'QC'),
       ('Newfoundland and Labrador', 'NL'),
       ('Manitoba', 'MB'),
       ('Nunavut', 'NU'),
       ('Alberta', 'AB'),
       ('British Columbia', 'BC'),
       ('Yukon', 'YK'),
       ('Northwest Territories', 'NT'),
       ('Prince Edward Island', 'PE'),
       ('Ontario', 'ON'),
       ('Nova Scotia', 'NS')
       ;

