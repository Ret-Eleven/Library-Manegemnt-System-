-- Auto-generated import script for "Art Garfunkel Library 2.csv"
-- Source rows parsed: 1321; unique authors: 966

BEGIN;

-- 1. Ensure the 'Uncategorized' category exists
INSERT INTO category (category_name)
SELECT 'Uncategorized'
WHERE NOT EXISTS (SELECT 1 FROM category WHERE category_name = 'Uncategorized');

-- 2. Insert any missing authors (deduplicated by first_name + last_name)
INSERT INTO author (first_name, last_name)
SELECT v.first_name, v.last_name FROM (VALUES
  ('Jean-Jacques', 'Rousseau'),
  ('Erich', 'Fromm'),
  ('Mark', 'Twain'),
  ('James', 'Thurber'),
  ('William', 'Shakespeare'),
  ('John', 'Barth'),
  ('Aldous', 'Huxley'),
  ('Fritz', 'Peters'),
  ('P.D.', 'Ouspensky'),
  ('Russell', 'H. Miles'),
  ('Hunter', 'Davies'),
  ('René', 'Daumal'),
  ('Bernard', 'Malamud'),
  ('C.G.', 'Jung'),
  ('Philip', 'Roth'),
  ('Malcolm', 'X and Alex Haley'),
  ('Jule', 'Eisenbud, M.D.'),
  ('Penelope', 'Gilliatt'),
  ('Oscar', 'Wilde'),
  ('Joseph', 'Heller'),
  ('Voltaire', ''),
  ('F.', 'Scott Fitzgerald'),
  ('L.N.', 'Tolstoy'),
  ('George', 'Orwell'),
  ('Fyodor', 'Dostoyevsky'),
  ('Norman', 'Podhoretz'),
  ('Rodney', 'Collin'),
  ('Norman', 'Mailer'),
  ('G.I.', 'Gurdjieff'),
  ('James', 'Simon Kunen'),
  ('Emily', 'Brontë'),
  ('Herman', 'Melville'),
  ('Johann', 'Wolgang Goethe'),
  ('Jean-Paul', 'Sartre'),
  ('Garrett', 'Mattingly'),
  ('Honoré', 'de Balzac'),
  ('Bertrand', 'Russell'),
  ('Margaret', 'Mead'),
  ('Jane', 'Austen'),
  ('Norman', 'Zierold'),
  ('Joan', 'Didion'),
  ('Anais', 'Nin'),
  ('André', 'Gide'),
  ('Gustave', 'Flaubert'),
  ('Joseph', 'Conrad'),
  ('Thomas', 'Mann'),
  ('Bill', 'Moyers'),
  ('Alvin', 'Toffer'),
  ('Jerzy', 'Kosinski'),
  ('Charlotte', 'Brontë'),
  ('Johann', 'Wolfgang Goethe'),
  ('William', 'J. Mitchell'),
  ('Edmund', 'S. Morgan'),
  ('Kenneth', 'A. Lockridge'),
  ('Mary', 'Renault'),
  ('Milovan', 'Djilas'),
  ('Albert', 'Schweitzer'),
  ('Alan', 'Watts'),
  ('Larry', 'McMurtry'),
  ('Richard', 'Bach'),
  ('Thomas', 'Wolfe'),
  ('Alan', 'Moorehead'),
  ('Charles', 'Dickens'),
  ('W.J.', 'Cash'),
  ('William', 'Faulkner'),
  ('Thomas', 'Hardy'),
  ('Irving', 'Bieber'),
  ('Dee', 'Brown'),
  ('Gabriel', 'Garcia Marques'),
  ('Sarah', 'N. Randolph'),
  ('Daniel', 'Boorstin'),
  ('Peter', 'McCabe and Robert D. Schonfeld'),
  ('E.N.', 'da C. Andrade'),
  ('John', 'Kenneth Galbraith'),
  ('Anne', 'F. Scott'),
  ('Georges', 'Lefebvre'),
  ('Konrad', 'Lorenz'),
  ('Bette', 'Davis'),
  ('Merle', 'Miller'),
  ('Vladimir', 'Nabokov'),
  ('Jim', 'Bouton'),
  ('Bruce', 'Catton'),
  ('Jan', 'Morris'),
  ('Constantine', 'Fitzgibbon'),
  ('Chogyam', 'Thungpa'),
  ('Peter', 'Benchley'),
  ('Carlos', 'Castaneda'),
  ('Chaim', 'Potok'),
  ('Sir', 'Arthur Conan Doyle'),
  ('Richard', 'Hofstadter'),
  ('Graham', 'Greene'),
  ('Clive', 'Davis'),
  ('Robert', 'A. Caro'),
  ('Henry', 'James'),
  ('Nicholas', 'Meyer'),
  ('William', 'M. Thackeray'),
  ('Kurt', 'Vonnegut, Jr.'),
  ('Rollo', 'May'),
  ('Aaron', 'Copland'),
  ('Harold', 'Mattingly'),
  ('Curtis', 'Cate'),
  ('John', 'S. Shelton'),
  ('Saul', 'Bellow'),
  ('Robert', 'Wm. Fogel and Stanley L. Engerman'),
  ('Colin', 'McEvedy'),
  ('R.D.', 'Laing'),
  ('Charles', 'Chaplin'),
  ('Margaret', 'Drabble'),
  ('Arthur', 'C. Clarke'),
  ('Stephen', 'King'),
  ('Bulfinch', ''),
  ('Gail', 'Sheehy'),
  ('J.', 'Hector St. John de Crevecoeur'),
  ('Charles', 'Darwin'),
  ('Robert', 'M. Pirsig'),
  ('Erik', 'Erikson'),
  ('Marcel', 'Proust'),
  ('Columbia', 'College'),
  ('Plato', ''),
  ('Chie', 'Nakane'),
  ('Homer', ''),
  ('Fyodor', 'Dostoevsky'),
  ('Lytton', 'Strachey'),
  ('Robertson', 'Davies'),
  ('A.J.P.', 'Taylor'),
  ('John', 'McPhee'),
  ('William', 'Manchester'),
  ('Paul', 'Bowles'),
  ('Yukio', 'Mishima'),
  ('James', 'Joll'),
  ('Jean', 'Rhys'),
  ('John', 'Irving'),
  ('Richard', 'Price'),
  ('James', 'M. Cain'),
  ('Adam', 'Smith'),
  ('John', 'C. Brandt and Stephen P. Maran'),
  ('Friedrich', 'Nietzsche'),
  ('A.', 'Alvarez'),
  ('George', 'Santayana'),
  ('Jonathan', 'Swift'),
  ('W.B.', 'Yeats'),
  ('John', 'Reed'),
  ('Isaac', 'Bashevis Singer'),
  ('John', 'Dewey'),
  ('Studs', 'Turkel'),
  ('Len', 'Jenkin'),
  ('Jean', 'Dorst'),
  ('Lester', 'C. Thurow'),
  ('John', 'Huston'),
  ('Mordecai', 'Richler'),
  ('W.X.C.', 'Guthrie'),
  ('Jonathan', 'Miller'),
  ('Edward', 'Gibbon'),
  ('J.P.', 'Donleavy'),
  ('James', 'Joyce'),
  ('John', 'Steinbeck'),
  ('J.D.', 'Salinger'),
  ('Gary', 'Zukav'),
  ('David', 'Halberstam'),
  ('Laurie', 'Lee'),
  ('Benvenuto', 'Cellini'),
  ('Jack', 'London'),
  ('Aristotle', ''),
  ('Saint', 'Augustine'),
  ('Joan', 'Edelman Spero'),
  ('Francois', 'Rabelais'),
  ('Immanuel', 'Kant'),
  ('Einhard', ''),
  ('David', 'Hume'),
  ('Miguel', 'de Cervantes Saavedra'),
  ('Virginia', 'Woolf'),
  ('Baldesar', 'Castiglione'),
  ('Charles', 'Major'),
  ('Giovanni', 'Pico della Mirandola'),
  ('David', 'C. Gompert, Michael Mandelbaum, Richard L. Garwin, John H. Barton'),
  ('D.M.', 'Thomas'),
  ('Willard', 'Gaylin, Ira Glasser, Steven Marcus, David Rochman'),
  ('John', 'Calvin'),
  ('Leon', 'Edel'),
  ('Milan', 'Kundera'),
  ('Albert', 'Einstein'),
  ('Ivan', 'Turgenev'),
  ('Vincent', 'Wright'),
  ('Lionel', 'Trilling'),
  ('Christopher', 'Isherwood'),
  ('Johan', 'Huizinga'),
  ('Martin', 'Buber'),
  ('David', 'Sylvester'),
  ('Robert', 'S. Lopez'),
  ('Marie', 'Sandoz'),
  ('David', 'McClintick'),
  ('Robert', 'Graves'),
  ('Robert', 'G. Weisbord'),
  ('Marc', 'Bloch'),
  ('John', 'Updike'),
  ('Bible', ''),
  ('Robin', 'Lane Fox'),
  ('Lawrence', 'Durrell'),
  ('William', 'James'),
  ('André', 'Breton'),
  ('Stephen', 'Jay Gould'),
  ('Mikhail', 'Bulgakov'),
  ('John', 'Le Carré'),
  ('Thornton', 'Wilder'),
  ('Various', ''),
  ('Tom', 'Wolfe'),
  ('Patrick', 'Humphries'),
  ('Emil', 'Ludwig'),
  ('Arnt', 'Eliassen and Kaare Pedersen'),
  ('Henry', 'David Thoreau'),
  ('Peter', 'Gay'),
  ('Plutarch', ''),
  ('Basho', ''),
  ('W.', 'Somerset Maugham'),
  ('Moliere', ''),
  ('Dylan', 'Thomas'),
  ('Isaac', 'Asimov'),
  ('Aeschylus', ''),
  ('Sophocles', ''),
  ('Cicero', ''),
  ('Elie', 'Wiesel'),
  ('Tom', 'Stoppard'),
  ('Sappho,', 'Pindar, Solon, and 23 others'),
  ('Basile', 'Kerblay'),
  ('Jim', 'Harrison'),
  ('Michel', 'de Montaigne'),
  ('William', 'Maxwell'),
  ('W.', 'Edward Mann and Edward Hoffman'),
  ('Hallie', 'Burnett'),
  ('William', 'Strunk, Jr. and E.B. White'),
  ('Guy', 'de Maupassant'),
  ('Anton', 'Chekhov'),
  ('Olivia', 'Coolidge'),
  ('Anthony', 'Burgess'),
  ('George', 'Bernard Shaw'),
  ('John', 'Dover Wilson'),
  ('Henrik', 'Ibsen'),
  ('Bob', 'Woodward'),
  ('Robert', 'H. March'),
  ('Gore', 'Vidal'),
  ('Italo', 'Calvino'),
  ('Alexander', 'L. George'),
  ('J.W.', 'Goethe'),
  ('Frederick', 'Exley'),
  ('Edmund', 'Wilson'),
  ('C.S.', 'Forster'),
  ('Alexander', 'Pushkin'),
  ('Mikhail', 'Lermontov'),
  ('Gustav', 'Flaubert'),
  ('Iris', 'Murdoch'),
  ('Jean', 'de La Fontaine'),
  ('Réné', 'Descartes'),
  ('Alan', 'Sillitoe'),
  ('W.E.B.', 'Dubois'),
  ('James', 'Salter'),
  ('E.M.W.', 'Tillyard'),
  ('Bruno', 'Bettelheim'),
  ('Knut', 'Hamsun'),
  ('Susan', 'Cheever'),
  ('Arkady', 'N. Shevchenko'),
  ('Constantin', 'Stanislavski'),
  ('Michael', 'White'),
  ('Robert', 'Stone'),
  ('David', 'Shapiro'),
  ('Richard', 'S. Dunn'),
  ('Harriet', 'Beecher Stowe'),
  ('Victor', 'Hugo'),
  ('Lucretius', ''),
  ('Leonardo', 'Da Vinci'),
  ('Howard', 'Greenfeld'),
  ('Frances', 'Fitzgerald'),
  ('Nora', 'Ephron'),
  ('Fritjof', 'Capra'),
  ('Lao', 'Tsu'),
  ('Judith', 'Martin'),
  ('Alice', 'Walker'),
  ('Richard', 'Ellmann'),
  ('E.F.', 'Benson'),
  ('Henry', 'Chadwick'),
  ('Herodotus', ''),
  ('Edith', 'Wharton'),
  ('J.K.', 'Galbraith'),
  ('Arthur', 'Schopenhauer'),
  ('Luigi', 'Barzini'),
  ('Carl', 'Sagan'),
  ('Eugen', 'Herrigel'),
  ('Julius', 'Caesar'),
  ('Richard', 'Hudson'),
  ('Virgil', ''),
  ('Gene', 'A. Brucker'),
  ('Edward', 'I. Koch'),
  ('Giorgio', 'Vasari'),
  ('Julian', 'Jaynes'),
  ('G.', 'William Domhoff'),
  ('Martin', 'Heidegger'),
  ('Alan', 'S. Parkes'),
  ('Edmund', 'Gosse'),
  ('John', 'Gardner'),
  ('Dante', 'Alighieri'),
  ('E.M.', 'Forster'),
  ('Gaston', 'Bachelard'),
  ('William', 'Kennedy'),
  ('Moss', 'Hart'),
  ('Ralph', 'Waldo Emerson'),
  ('Harold', 'C. Schonberg'),
  ('David', 'A. Stockman'),
  ('Stanislaus', 'Joyce'),
  ('Thomas', 'Hobbes'),
  ('Rainer', 'Maria Rilke'),
  ('Douglass', 'H. Morse'),
  ('Mark', 'Twain and Charles Dudley Warner'),
  ('Arthur', 'Power'),
  ('Jacques', 'Barzun'),
  ('V.S.', 'Naipaul'),
  ('Carrie', 'Fisher'),
  ('Michel', 'Montaigne'),
  ('Sigmund', 'Freud'),
  ('V.I.', 'Lenin'),
  ('A.J.', 'Liebling'),
  ('Peter', 'Fornatale & Joshua E. Mills'),
  ('Martin', 'Amis'),
  ('Barry', 'Lopez'),
  ('Doris', 'Lessing'),
  ('James', 'Branch Cabell'),
  ('Heinrich', 'Heine'),
  ('Max', 'I. Dimont'),
  ('Jorge', 'Luis Borges'),
  ('Marco', 'Polo'),
  ('John', 'A. Wilson'),
  ('Denis', 'Diderot'),
  ('Rudyard', 'Kipling'),
  ('Peter', 'Ladefoged'),
  ('Friedrich', 'Nietzche'),
  ('C.P.', 'Snow'),
  ('Zbigniew', 'Brzezinski'),
  ('Celia', 'McEvedy'),
  ('Robert', 'Roberts'),
  ('Colette', ''),
  ('André', 'Malraux'),
  ('Jean', 'Racine'),
  ('Roger', 'Fisher, William Ury'),
  ('Ernst', 'Cassirer'),
  ('Mikhail', 'Gorbachev'),
  ('Adin', 'Steinsaltz'),
  ('Beowulf', 'Poet'),
  ('P.G.', 'Wodehouse'),
  ('Gene', 'Lees'),
  ('Gretel', 'Ehrlich'),
  ('Henry', 'Fielding'),
  ('George', 'Holmes'),
  ('David', 'J. Garrow'),
  ('George', 'Eliot'),
  ('John', 'Dos Passos'),
  ('Anonymous', ''),
  ('Michael', 'J. Malbin, ed.'),
  ('Donald', 'T. Regan'),
  ('Benjamin', 'Franklin'),
  ('Elia', 'Kazan'),
  ('Francis', 'Parkman'),
  ('Confucius', ''),
  ('Yasunari', 'Kawabata'),
  ('collected', ''),
  ('Seneca', ''),
  ('Anthony', 'Trollope'),
  ('Ovid', ''),
  ('Christopher', 'Clapham'),
  ('Richard', 'Russo'),
  ('P.P.', 'Xahane'),
  ('Charles', 'Baudelaire'),
  ('Willa', 'Cather'),
  ('Nadine', 'Gordimer'),
  ('Jean', 'Corst'),
  ('John', 'Stoye'),
  ('E.L.', 'Doctorow'),
  ('Howard', 'Hibbard'),
  ('Yasuji', 'Kirimura'),
  ('Scott', 'Buchanan'),
  ('Gabriel', 'Garcia Marquez'),
  ('Brenda', 'Maddox'),
  ('John', 'Milton'),
  ('Sanche', 'de Gramont'),
  ('Stephen', 'W. Hawking'),
  ('Wallace', 'Stevens'),
  ('edited', 'by W.H. Auden'),
  ('Quentin', 'Crisp'),
  ('Michael', 'Harrington'),
  ('Art', 'Garfunkel'),
  ('Umberto', 'Eco'),
  ('Theodore', 'Dreiser'),
  ('Santoru', 'Izumi'),
  ('Robert', 'Louis Stevenson'),
  ('James', 'D. Watson'),
  ('Noam', 'Chomsky, Edward S. Herman'),
  ('Joseph', 'Campbell (with Bill Moyers)'),
  ('Henry', 'Miller'),
  ('J.P.', 'Kenyon'),
  ('Michel', 'Foucault'),
  ('Ian', 'Frazier'),
  ('Anne', 'Rice'),
  ('Charles', 'R. Morris'),
  ('Jerrold', 'Seigel'),
  ('Paul', 'Magriel, John T. Spike'),
  ('Sylvia', 'Plath'),
  ('George', 'F. Will'),
  ('Edith', 'Hamilton'),
  ('Ernest', 'Hemingway'),
  ('J.F.', 'Stone'),
  ('Daniel', 'Bates, Amal Rassam'),
  ('Aristophanes', ''),
  ('Tacitus', ''),
  ('Fredric', 'Dannen'),
  ('The', 'Koran'),
  ('Roderic', 'Gorney'),
  ('William', 'Thackeray'),
  ('Rachel', 'Carlson'),
  ('Charles', 'Grodin'),
  ('Will', 'and Ariel Durant'),
  ('Thomas', 'L. Friedman'),
  ('Daphne', 'du Maurier'),
  ('Daisaku', 'Ikeda'),
  ('Marcus', 'Aurelius'),
  ('Thomas', 'Szasz'),
  ('Arthur', 'Koestler'),
  ('Herbert', 'Marcuse'),
  ('edited', 'by F. Stephen Larrabee'),
  ('Oscar', 'Hijuelos'),
  ('William', 'Pfaff'),
  ('Madame', 'de Lafayette'),
  ('Paul', 'Fussell'),
  ('William', 'Styron'),
  ('A.R.', 'Myers'),
  ('Paul', 'Hohenberg, Lynn Hollen Lees'),
  ('Joseph', 'Morella, Patricia Barey'),
  ('Sun', 'Tzu'),
  ('Aleksandr', 'Solzhenitsyn'),
  ('H.G.', 'Wells'),
  ('Baroness', 'Orczy'),
  ('H.L.', 'Mencken'),
  ('William', 'Julius Wilson'),
  ('Swami', 'Prabhavananda'),
  ('Edgar', 'Allan Poe'),
  ('Andreas', 'Capellanus'),
  ('Nathaniel', 'Hawthorne'),
  ('Edmund', 'Burke'),
  ('Nikolai', 'Gogol'),
  ('Donald', 'L. Barlett, James B. Steele'),
  ('Patrick', 'J. Geary'),
  ('Richard', 'Selzer'),
  ('Ben', 'H. Bagdikian'),
  ('Cyril', 'Aldred'),
  ('Ben', 'Weider, David Hapgood'),
  ('Livy', ''),
  ('Oliver', 'Sacks'),
  ('Dorothy', 'Parker'),
  ('Alec', 'Wilder'),
  ('Lawrence', 'Shainberg'),
  ('Lord', 'Chesterfield'),
  ('Camille', 'Paglia'),
  ('Harry', 'Crews'),
  ('Hermann', 'Hesse'),
  ('Jean', 'Piaget'),
  ('David', 'King Dunaway'),
  ('Evelyn', 'Waugh'),
  ('Unknown', ''),
  ('Jess', 'Stein'),
  ('Bruce', 'Chatwin'),
  ('K.J.', 'Dover'),
  ('David', 'Thomson'),
  ('Allan', 'Gurganus'),
  ('Stanley', 'Coren'),
  ('Leo', 'Tolstoy'),
  ('Cristina', 'Garcia'),
  ('Mark', 'Green'),
  ('Thomas', 'Kessner'),
  ('Don', 'DeLillo'),
  ('John', 'Stuart Mill'),
  ('Rudyand', 'Kipling'),
  ('Alan', 'Lightman'),
  ('Jules', 'Michelet'),
  ('V.S.', 'Pritchett'),
  ('Peter', 'B. High'),
  ('Susan', 'Sontag'),
  ('Françoise', 'Sagan'),
  ('Sherwood', 'Anderson'),
  ('Flannery', 'O''Connor'),
  ('Donald', 'Matthew'),
  ('Jane', 'Smiley'),
  ('Patrick', 'Moore'),
  ('Henry', 'Adams'),
  ('Emile', 'Zola'),
  ('Laurence', 'Sterne'),
  ('Franz', 'Kafka'),
  ('Thomas', 'DeQuincy'),
  ('Natalie', 'Goldberg'),
  ('Daniel', 'Defoe'),
  ('Dorothy', 'Whitelock'),
  ('David', 'Rabe'),
  ('Henry', 'Kissinger'),
  ('Ernest', 'Becker'),
  ('Sinclair', 'Lewis'),
  ('John', 'King Fairbank'),
  ('Toni', 'Morrison'),
  ('Arnold', 'Toynbee & Daisaku Ikeda'),
  ('Sherwin', 'B. Nuland'),
  ('H.B.', 'Acton'),
  ('Gustav', 'Janouch'),
  ('Samuel', 'Butler'),
  ('Meriwether', 'Lewis and William Clark'),
  ('Peter', 'Kwong'),
  ('Selma', 'H. Fraiberg'),
  ('Sol', 'M. Linowitz'),
  ('Stendhal', ''),
  ('J.H.', 'Plumb'),
  ('Carson', 'McCullers'),
  ('Joyce', 'Carol Oates'),
  ('editor,', 'Eric L. McKitrick'),
  ('Don,', 'Jeanne Elium'),
  ('Patrick', 'O''Brian'),
  ('Russell', 'Banks'),
  ('Vyasa', ''),
  ('Thomas', 'More'),
  ('Alice', 'Miller'),
  ('Daniel', 'Goleman'),
  ('Benedict', 'de Spinoza'),
  ('Betty', 'Radice'),
  ('Alexander', 'Hamilton and James Madison'),
  ('Nathan', 'Glazer and Daniel P. Moynihan'),
  ('Louise', 'Ames'),
  ('Abul', 'A''La Mawdudi'),
  ('Stephen', 'Crane'),
  ('James', 'Boswell'),
  ('Robert', 'D. Kaplan'),
  ('anonymous', ''),
  ('Russell', 'Baker'),
  ('Robin,', 'Liza, Linda, Tiffany'),
  ('Stephen', 'Birmingham'),
  ('Peter', 'I. Pressman and Yahsar Hirshaut'),
  ('Blaise', 'Pascal'),
  ('Deepak', 'Chopra'),
  ('Maxim', 'Gorky'),
  ('Paul', 'Theroux'),
  ('René', 'Descartes'),
  ('Deborah', 'Tannen'),
  ('Pliny', 'the Elder'),
  ('James', 'Clavell'),
  ('Xenophon', ''),
  ('Michael', 'Herr'),
  ('David', 'Baldacci'),
  ('Simone', 'DeBeauvoir'),
  ('Henry', 'Fielding, Daniel Defoe'),
  ('Mary', 'Karr'),
  ('Robin', 'Dunbar'),
  ('G.K.', 'Chesterton'),
  ('Bryce', 'Lyon'),
  ('Antoine', 'de Saint Exupery'),
  ('Charles', 'and Mary Lamb'),
  ('Sir', 'Thomas Malory'),
  ('Alcoholics', 'Anonymous'),
  ('Jules', 'Verne'),
  ('Daniel', 'Johan Goldhagen'),
  ('Aristotle,', 'Horace'),
  ('Keith', 'B. Richburg'),
  ('Lincoln', 'Steffens'),
  ('Choderlos', 'DeLaclos'),
  ('Jonathan', 'Harr'),
  ('Harper', 'Lee'),
  ('David', 'Denby'),
  ('Garrison', 'Keillor'),
  ('Barry', 'Miles'),
  ('Horace', ''),
  ('E.', 'Annie Proulx'),
  ('Allan', 'Bloom'),
  ('Niccolò', 'Machiavelli'),
  ('Alexis', 'De Tocqueville'),
  ('Frank', 'McCourt'),
  ('Susanna', 'Moore'),
  ('Robert', 'Hughes'),
  ('Patrick', 'Suskind'),
  ('Victoria', 'Kingston'),
  ('John', 'Locke'),
  ('Jeffrey', 'Archer'),
  ('S.T.', 'Bindoff'),
  ('John', 'O''Hara'),
  ('Ralph', 'Ellison'),
  ('A.S.', 'Byatt'),
  ('Giovanni', 'Boccaccio'),
  ('Edward', 'W. Said'),
  ('Peter', 'and Linda Murray'),
  ('Emmanuel', 'Le Roy Ladurie'),
  ('Richard', 'Causton'),
  ('Mitch', 'Albom'),
  ('D.H.', 'Lawrence'),
  ('Alessandro', 'Baricco'),
  ('Morris', 'Goldstein'),
  ('Jimmy', 'Webb'),
  ('Bill', 'Gates'),
  ('Arthur', 'Golden'),
  ('Frank', 'R. Wilson'),
  ('Daniel', 'DeFoe'),
  ('Robert', 'Wright'),
  ('John', 'Hersey'),
  ('Jacob', 'A. Riis'),
  ('Colin', 'Bateman'),
  ('Fernand', 'Braudel'),
  ('Jason', 'Goodwin'),
  ('Marilyn', 'Vos Savant'),
  ('Fred', 'Goodman'),
  ('Dan', 'Kindlon, Michael Thompson'),
  ('Dava', 'Sobol'),
  ('Søren', 'Kierkegaard'),
  ('Bernie', 'Brillstein'),
  ('Richard', 'Dawkins'),
  ('Alfred', 'Lansing'),
  ('Euripides', ''),
  ('George', 'Stephanopoulos'),
  ('John', 'Rechy'),
  ('Zora', 'Neale Hurston'),
  ('Jhumpa', 'Lahiri'),
  ('Michael', 'Lewis'),
  ('Alexander', 'Dumas'),
  ('Samuel', 'Eliot Morison'),
  ('George', 'Kubler'),
  ('Jakob', 'Walter'),
  ('Sir', 'Harold Nicolson'),
  ('William', 'Hazlitt'),
  ('Ida', 'M. Tarbell'),
  ('Adolph', 'Hitler'),
  ('Honore', 'de Balzac'),
  ('Dorothy', 'L. Sayers'),
  ('Christine', 'Hobson'),
  ('Horatio', 'Alger, Jr.'),
  ('Tom', 'King'),
  ('Lord', 'Byron'),
  ('Walter', 'Bagehot'),
  ('Dan', 'O''Brien'),
  ('Michael', 'E. Porter, Hirotaka Takeuchi, Mariko Sakakibara'),
  ('Sarah', 'Faunce'),
  ('Peter', 'Paret'),
  ('P.', 'G. Wodehouse'),
  ('Benjamin', 'R. Barber'),
  ('J.K.', 'Rowling'),
  ('Stephen', 'Hawking'),
  ('Artie', 'Shaw'),
  ('Paramahansa', 'Yogananda'),
  ('Bernard', 'Lewis'),
  ('Elizabeth', 'Gaskell'),
  ('Upton', 'Sinclair'),
  ('Eugene', 'F. Rice, Jr.'),
  ('Margaret', 'A. Salinger'),
  ('C.S.', 'Forester'),
  ('W.H.', 'Lewis'),
  ('Noam', 'Chomsky'),
  ('Henry', 'George'),
  ('David', 'Krieger, Daisaku Ikeda'),
  ('Malcolm', 'Lowry'),
  ('Viktor', 'E. Frankl'),
  ('Harold', 'Nicolson'),
  ('Lucien', 'Febvr, Henri-Jean Martin'),
  ('Arthure', 'Levitt'),
  ('Charles', 'Bukowski'),
  ('Jose', 'Saramago'),
  ('Susan', 'Mollin Okin'),
  ('DBC', 'Pierre'),
  ('John', 'Lowden'),
  ('Natalie', 'Angier'),
  ('Gregory', 'Bishop of Tours'),
  ('Paul', 'Berman'),
  ('Mary', 'McCarthy'),
  ('James', 'Lord'),
  ('Karen', 'Armstrong'),
  ('Daisaku', 'Ikeda, Majid Tehranian'),
  ('Graham', 'Greenauthor'),
  ('Horace', 'Mann'),
  ('Claude', 'Mettra'),
  ('J.', 'M. Coetzee'),
  ('Dan', 'Brown'),
  ('Tacey', 'Chevalier'),
  ('Harold', 'Bloom'),
  ('Walter', 'Pater'),
  ('William', 'Pollack'),
  ('Aesop', ''),
  ('Juvenal', ''),
  ('Groucho', 'Marx'),
  ('John', 'Kennedy Toole'),
  ('Molly', 'Hughes'),
  ('Nick', 'Hornby'),
  ('John', 'Bunyan'),
  ('Walt', 'Whitman'),
  ('Paulo', 'Coelho'),
  ('John', 'Boswell'),
  ('Lawrence', 'Potter'),
  ('Bob', 'Dylan'),
  ('Richard', 'L. Bushman'),
  ('Arnold', 'Toynbee'),
  ('Bill', 'McKibben'),
  ('Craig', 'Unger'),
  ('Tim', 'LaHaye, Jerry B. Jenkins'),
  ('Laurens', 'Van der Post'),
  ('Marilynne', 'Robinson'),
  ('Thomas', 'Carlyle'),
  ('Dalton', 'Trumbo'),
  ('Claude-Anne', 'Lopez'),
  ('Maureen', 'Dowd'),
  ('J.R.', 'Hale'),
  ('Robert', 'F. Kennedy, Jr.'),
  ('Jane', 'Leavy'),
  ('David', 'McCullough'),
  ('Frank', 'Norris'),
  ('Ann', 'Rinaldi'),
  ('Tim', 'De Lisle'),
  ('Laurence', 'Bergreen'),
  ('Steve', 'Martin'),
  ('Kenneth', 'Henshall'),
  ('Edmund', 'Morris'),
  ('Sonny', 'Barger'),
  ('Nathanael', 'West'),
  ('Ford', 'Maddox Ford'),
  ('Mary', 'Wollstonecraft'),
  ('Doris', 'Kearns Goodwin'),
  ('Tony', 'Judt'),
  ('Geoff', 'Emerick'),
  ('Wallace', 'Stegner'),
  ('David', 'Dalton'),
  ('Carlo', 'Collodi'),
  ('D.', 'H. Lawrence'),
  ('Henri', 'Pirenne'),
  ('A.', 'H. Maslow'),
  ('Hermann', 'Hesee'),
  ('David', 'S. Brown'),
  ('Robert', 'Penn Warren'),
  ('Michel', 'DeMontaigne'),
  ('Danny', 'Danzinger & John Gillingham'),
  ('Jared', 'Diamond'),
  ('Fareed', 'Zakaria'),
  ('Quintus', 'Curtius Rufus'),
  ('Oliver', 'Wendell Holmes'),
  ('Jonathan', 'Franzen'),
  ('George', 'W.S. Trow'),
  ('Heinrich', 'Fichtenau'),
  ('Jill', 'Hamilton'),
  ('Sir', 'Thomas More'),
  ('Isaiah', 'Berlin'),
  ('Cecily', 'von Ziegesar'),
  ('Ian', 'McEwan'),
  ('Jonathan', 'Lethem'),
  ('José', 'Saramago'),
  ('Brigitte', 'L. Nacos'),
  ('Samuel', 'Beckett'),
  ('Leonardo', 'da Vinci'),
  ('Donald', 'Capps'),
  ('Reinhold', 'Niebuhr'),
  ('John', 'J. Jackson, Jr.'),
  ('Octavio', 'Paz'),
  ('Linda', 'Lawrence Hunt'),
  ('Kenneth', 'Seeskin'),
  ('Booth', 'Tarkington'),
  ('Jane', 'Jacobs'),
  ('Al', 'Gore'),
  ('Raymond', 'Carver'),
  ('Nassim', 'Nicholas Taleb'),
  ('Peter', 'Forbath'),
  ('Francis', 'Bacon'),
  ('Rose', 'Tremain'),
  ('Lord', 'Macaulay'),
  ('Marguerite', 'Duras'),
  ('Olivier', 'Blanc'),
  ('John', 'Perkins'),
  ('Rory', 'Stewart'),
  ('John', 'Lewis Gaddis'),
  ('Muriel', 'Spark'),
  ('Vali', 'Nasr'),
  ('John', 'Lukacs'),
  ('William', 'Boyd'),
  ('Dennis', 'McDouglas'),
  ('Simon', 'Winchester'),
  ('Henry', 'Roth'),
  ('Junot', 'Diaz'),
  ('Andrew', 'J. Bacevich'),
  ('Ken', 'Kesey'),
  ('Paul', 'Tillich'),
  ('Edmund', 'White'),
  ('Elizabeth', 'Bowen'),
  ('Henri', 'Troyat'),
  ('Jimmy', 'Carter'),
  ('Tom', 'Shachtman'),
  ('George', 'Berkeley'),
  ('Mikhail', 'Sholokhov'),
  ('Jonathan', 'Weiner'),
  ('Lao', 'Tzu'),
  ('Ray', 'Kurzweil'),
  ('Khaled', 'Hosseini'),
  ('Amos', 'Oz'),
  ('Zadie', 'Smith'),
  ('Edna', 'O''Brien'),
  ('Samuel', 'Richardson'),
  ('John', 'Cleland'),
  ('Giambattista', 'Vico'),
  ('Jacob', 'Burckhardt'),
  ('Ivan', 'Goncharov'),
  ('Adam', 'Phillips'),
  ('D.A.F.', 'Marquis deSade'),
  ('Raymond', 'Postgate'),
  ('Oliver', 'Goldsmith'),
  ('Paul', 'Ryscavage'),
  ('Akira', 'Iriye'),
  ('Andrew', 'Ross Sorkin'),
  ('Dashielle', 'Hammett'),
  ('Christopher', 'Caldwell'),
  ('Polybius', ''),
  ('Michael', 'Howard'),
  ('John', 'Heileman, Mark Halperin'),
  ('W.Somerset', 'Maughan'),
  ('Jules', 'Feiffer'),
  ('Richard', 'Wright'),
  ('James', 'Moore'),
  ('Gregory', 'David Roberts'),
  ('David', 'A. Andelman'),
  ('Stieg', 'Larsson'),
  ('Billy', 'Collins'),
  ('Charlotte', 'Joko Beck'),
  ('Wilkie', 'Collins'),
  ('Kathryn', 'Stockett'),
  ('Ron', 'Chernow'),
  ('Doug', 'Glanville'),
  ('Norman', 'Doidge, M.D.'),
  ('Louis', 'D. Brandeis'),
  ('Ravi', 'Ravindra'),
  ('Agatha', 'Christie'),
  ('Martin', 'Cruz Smith'),
  ('James', 'Miller'),
  ('Luigi', 'Pirandello'),
  ('Roderick', 'Frazier Nash'),
  ('John', 'Muir'),
  ('Brian', 'Thomas Swimme & Mary Evelyn Tucker'),
  ('Robert', 'Mighall'),
  ('David', 'Edwards'),
  ('Victor', 'Bockris'),
  ('Michael', 'Soussan'),
  ('Sara', 'Maitland'),
  ('Hugh', 'Trevor-Roper'),
  ('Yann', 'Martel'),
  ('Don', 'Piper with Cecil Murphy'),
  ('Sandro', 'Veronesi'),
  ('Noel', 'Coward'),
  ('David', 'Browne'),
  ('Niobe', 'Way'),
  ('Vladmir', 'Nabokov'),
  ('Erik', 'Larson'),
  ('Sanford', 'D. Greenberg'),
  ('Albert', 'Goldman, Lawrence Schiller'),
  ('Muriel', 'Barbery'),
  ('Scotty', 'Bowers'),
  ('Laura', 'Hillenbrand'),
  ('Julie', 'Otsuka'),
  ('Timothy', 'L. Hoffmann'),
  ('E.L.', 'James'),
  ('Benjamin', 'Grahanm, Jason Zweig'),
  ('Julie', 'Rugg, Linda Murphy'),
  ('Johann', 'Wolfgang von Goethe'),
  ('Roger', 'Collins'),
  ('Malcolm', 'Gladwell'),
  ('Lee', 'Hausner'),
  ('William', 'Carlos Williams'),
  ('Michael', 'Shaara'),
  ('Elisabeth', 'Tova Bailey'),
  ('Mario', 'Puzo'),
  ('Nancy', 'Mitford'),
  ('David', 'Barash'),
  ('Robert', 'K Massie'),
  ('Mason', 'Currey'),
  ('Phillippe', 'Burrin'),
  ('Bruno', 'Schulz'),
  ('Donald', 'Shepherd'),
  ('Barbara', 'W. Tuchman'),
  ('Witold', 'Gombrowicz'),
  ('Charles', 'C. Mann'),
  ('Philip', 'K. Dick'),
  ('Marianne', 'Williamson'),
  ('Margaret', 'Macmillan'),
  ('Victoria', 'Wilson'),
  ('Julie', 'Orringer'),
  ('Ernst', 'Fischer, Carol Lipson'),
  ('Alice', 'Munro'),
  ('Louisa', 'May Alcott'),
  ('J.L.', 'Carr'),
  ('James', 'Fenimore Cooper'),
  ('Anjelica', 'Huston'),
  ('Phil', 'Klayn'),
  ('Karl', 'Ove Knausgaard'),
  ('Patrick', 'Leigh Fermor'),
  ('Randall', 'Jarrell'),
  ('Howard', 'Felperin'),
  ('Thomas', 'Beer'),
  ('Judith', 'Viorst'),
  ('Ron', 'Chernov'),
  ('Jeff', 'Fromm'),
  ('James', 'Gavin'),
  ('Steve', 'Silberman'),
  ('Buzz', 'Bissinger'),
  ('Kostya', 'Kennedy'),
  ('Morris', 'Dickstein'),
  ('Stepen', 'Greenblatt'),
  ('Bill', 'Read'),
  ('R.D.', 'Blackmore'),
  ('Madeline', 'Levine'),
  ('Hilton', 'Als'),
  ('Barbara', 'Tuchman'),
  ('Robert', 'Gottlieb'),
  ('Rabbi', 'Shalom Arush'),
  ('Paula', 'Hawkins'),
  ('Charles', 'Nordhoff, James Norman Hall'),
  ('John', 'Sutherland'),
  ('Frances', 'Kroll Ring'),
  ('James', 'Baldwin'),
  ('Timothy', 'Snyder'),
  ('Donald', 'Trump'),
  ('Joseph', 'J. Ellis'),
  ('John', 'Julius Norwich'),
  ('Lisa', 'Hilton'),
  ('Erich', 'Maria Remarque'),
  ('Al', 'Franken'),
  ('Elena', 'Ferrante'),
  ('Elizabeth', 'Strout'),
  ('Domenico', 'Starnone'),
  ('Michael', 'Wolff'),
  ('Craig', 'Pittman'),
  ('Madeleine', 'Albright'),
  ('Adele', 'Faber & Elaine Mazlish'),
  ('Julian', 'Barnes'),
  ('Robert', 'Hilburn'),
  ('J.', 'Edgar Hoover'),
  ('Peter', 'Catapano'),
  ('Ruth', 'Bader Ginsburg'),
  ('Ayn', 'Rand'),
  ('Robert', 'Parker'),
  ('Anthony', 'Doerr'),
  ('Alan', 'Jacobs'),
  ('Cormac', 'McCarthy'),
  ('Bill', 'O''Reilly'),
  ('Stephen', 'Kinzer'),
  ('Eric', 'Kandel'),
  ('Bill', 'Bryson'),
  ('Naomi', 'Klein'),
  ('Paul', 'Collins'),
  ('Cliff', 'Sims'),
  ('Jim', 'Mattis, Bing West'),
  ('Margaret', 'Attwood'),
  ('Gelett', 'Burgess'),
  ('David', 'Talbot'),
  ('Mary', 'L. Trump'),
  ('David', 'Mikie'),
  ('Julie', 'Satow'),
  ('Ash', 'Carter and Sam Kashner'),
  ('Ruth', 'Ben-Ghiat'),
  ('Mark', 'Harris'),
  ('P.G.Wodehouse', ''),
  ('Margaret', 'MacMillan'),
  ('Charles', 'Terry'),
  ('Bernard', 'Shaw'),
  ('Jo', 'Giese'),
  ('Bob', 'Woodward, Robert Costa'),
  ('Amor', 'Towles'),
  ('Mel', 'Brooks'),
  ('James', 'Michener'),
  ('Abraham', 'Lincoln'),
  ('Joe', 'Scarborough')
) AS v(first_name, last_name)
WHERE NOT EXISTS (
  SELECT 1 FROM author a WHERE a.first_name = v.first_name AND a.last_name = v.last_name
);

-- 3. Insert each book and link it to its author
WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Confessions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1781, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Art of Loving', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erich' AND last_name = 'Fromm'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Adventures of Huckleberry Finn', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1884, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Life and Hard Times', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1933, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Thurber'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Romeo and Juliet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1596, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The End of the Road', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Barth'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Brave New World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1932, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aldous' AND last_name = 'Huxley'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Boyhood with Gurdjieff', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fritz' AND last_name = 'Peters'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('In Search of the Miraculous', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1949, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.D.' AND last_name = 'Ouspensky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Johann Sebastian Bach, an Introduction to his Life and Works', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Russell' AND last_name = 'H. Miles'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Beatles', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hunter' AND last_name = 'Davies'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Strange Life of Ivan Osokin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.D.' AND last_name = 'Ouspensky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mount Analogue', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'René' AND last_name = 'Daumal'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Assistant', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bernard' AND last_name = 'Malamud'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Memories, Dreams, Reflections', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'C.G.' AND last_name = 'Jung'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Goodbye, Columbus', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Philip' AND last_name = 'Roth'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Autobiography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Malcolm' AND last_name = 'X and Alex Haley'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The World of Ted Serios', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jule' AND last_name = 'Eisenbud, M.D.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A State of Change', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Penelope' AND last_name = 'Gilliatt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Picture of Dorian Gray', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1891, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Oscar' AND last_name = 'Wilde'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Catch 22', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joseph' AND last_name = 'Heller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Candide', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1758, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Voltaire' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Great Gatsby', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1925, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'F.' AND last_name = 'Scott Fitzgerald'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('War and Peace', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1869, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Portnoy''s Complaint', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Philip' AND last_name = 'Roth'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Down and Out in Paris and London', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1933, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Orwell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Brothers Karamazov', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1881, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoyevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Making It', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Norman' AND last_name = 'Podhoretz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Theory of Eternal Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1948, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rodney' AND last_name = 'Collin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Miami and the Siege of Chicago', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Norman' AND last_name = 'Mailer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Meetings with Remarkable Men', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'G.I.' AND last_name = 'Gurdjieff'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hamlet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1602, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Strawberry Statement', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Simon Kunen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Wuthering Heights', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1847, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emily' AND last_name = 'Brontë'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Moby Dick', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1851, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Herman' AND last_name = 'Melville'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sorrows of Young Werther', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1774, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Johann' AND last_name = 'Wolgang Goethe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nausea', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1938, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Paul' AND last_name = 'Sartre'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Armada', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Garrett' AND last_name = 'Mattingly'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Eugénie Grandet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1833, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Conquest of Happiness', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1930, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bertrand' AND last_name = 'Russell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Culture and Commitment', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'Mead'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sense and Sensibility', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1811, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Austen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Childhood, Boyhood, Youth', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1857, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Garbo', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Norman' AND last_name = 'Zierold'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Play It as It Lays', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joan' AND last_name = 'Didion'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Diary', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anais' AND last_name = 'Nin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Counterfeiters', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'André' AND last_name = 'Gide'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sentimental Education', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1869, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustave' AND last_name = 'Flaubert'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lord Jim', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1900, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joseph' AND last_name = 'Conrad'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Othello', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1602, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Buddenbrooks', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1901, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Mann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Listening to America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'Moyers'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Future Shock', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alvin' AND last_name = 'Toffer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Being There', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jerzy' AND last_name = 'Kosinski'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jane Eyre', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1847, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charlotte' AND last_name = 'Brontë'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('King Lear', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1605, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Elective Affinities', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1809, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Johann' AND last_name = 'Wolfgang Goethe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Elementary Harmony', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'J. Mitchell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Birth of the Republic', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'S. Morgan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A New England Town, the First One Hundred Years', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Kenneth' AND last_name = 'A. Lockridge'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Charioteer', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'Renault'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Anna Karenina', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1873, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The New Class', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Milovan' AND last_name = 'Djilas'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('J.S. Bach, Vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1911, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Albert' AND last_name = 'Schweitzer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Wisdom of Insecurity', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1951, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alan' AND last_name = 'Watts'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All My Friends are Going to Be Strangers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Larry' AND last_name = 'McMurtry'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jonathan Livingston Seagull', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Bach'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Look Homeward Angel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1929, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Wolfe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Darwin and the Beagle', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alan' AND last_name = 'Moorehead'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('David Copperfield', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1850, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('American Notes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1842, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mind of the South', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1941, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.J.' AND last_name = 'Cash'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Wild Palms', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Faulkner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tess of the D''Urbervilles', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1902, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hardy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Homosexuality, a Psychoanalytic Survey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Irving' AND last_name = 'Bieber'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Immoralist', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'André' AND last_name = 'Gide'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bury My Heart at Wounded Knee', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dee' AND last_name = 'Brown'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('One Hundred Years of Solitude', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gabriel' AND last_name = 'Garcia Marques'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pride and Prejudice', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1797, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Austen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Domestic Life of Thomas Jefferson', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sarah' AND last_name = 'N. Randolph'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Lost World of Thomas Jefferson', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1948, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Boorstin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Apple to the Core', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'McCabe and Robert D. Schonfeld'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sir Isaac Newton, His Life and Work', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.N.' AND last_name = 'da C. Andrade'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Economics and the Public Purpose', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Kenneth Galbraith'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Southern Lady', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anne' AND last_name = 'F. Scott'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Coming of the French Revolution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1947, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Georges' AND last_name = 'Lefebvre'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Aggression', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Konrad' AND last_name = 'Lorenz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Lonely Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bette' AND last_name = 'Davis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Plain Speaking, an Oral Biography of Harry S. Truman', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Merle' AND last_name = 'Miller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Transparent Things', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladimir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Persuasion', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1818, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Austen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ball Four', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jim' AND last_name = 'Bouton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('This Hallowed Ground', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bruce' AND last_name = 'Catton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Conundrum', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jan' AND last_name = 'Morris'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Life of Dylan Thomas', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Constantine' AND last_name = 'Fitzgibbon'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cutting Through Spiritual Materialism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Chogyam' AND last_name = 'Thungpa'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jaws', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Benchley'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Journey to Ixtlan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carlos' AND last_name = 'Castaneda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Chosen', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Chaim' AND last_name = 'Potok'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Adventures of Sherlock Holmes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1892, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sir' AND last_name = 'Arthur Conan Doyle'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('America at 1750', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Hofstadter'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The End of the Affair', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1951, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Graham' AND last_name = 'Greene'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Clive, Inside the Record Business', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Clive' AND last_name = 'Davis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Power Broker', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'A. Caro'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Portrait of a Lady', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1881, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Seven Per-Cent Solution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nicholas' AND last_name = 'Meyer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Memoirs of Barry Lyndon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1854, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'M. Thackeray'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Breakfast of Champions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Kurt' AND last_name = 'Vonnegut, Jr.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last Tycoon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1941, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'F.' AND last_name = 'Scott Fitzgerald'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Courage to Create', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rollo' AND last_name = 'May'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Copland on Music', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1960, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aaron' AND last_name = 'Copland'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Man in the Roman Street', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harold' AND last_name = 'Mattingly'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('George Sand', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Curtis' AND last_name = 'Cate'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Geology Illustrated', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'S. Shelton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('To Jerusalem and Back', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Saul' AND last_name = 'Bellow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Humboldt''s Gift', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Saul' AND last_name = 'Bellow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Time On the Cross, the Economics of American Negro Slavery', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Wm. Fogel and Stanley L. Engerman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Penguin Atlas of Medieval History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Colin' AND last_name = 'McEvedy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Do You Love Me?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'R.D.' AND last_name = 'Laing'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Undiscovered Self', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'C.G.' AND last_name = 'Jung'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Modern Man in Search of a Soul', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1933, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'C.G.' AND last_name = 'Jung'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Autobiography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Chaplin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Summer Bird-Cage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'Drabble'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Childhood''s End', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1953, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'C. Clarke'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Europeans', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1878, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Shining', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'King'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Ambassadors', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mythology', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1855, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bulfinch' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Passages', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gail' AND last_name = 'Sheehy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Richard III', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1595, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Letters from an American Farmer', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1782, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.' AND last_name = 'Hector St. John de Crevecoeur'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Genius and Lust, a Journey through the Major Writings of Henry Miller', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Norman' AND last_name = 'Mailer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Origin of Species', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1859, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Darwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Zen and the Art of Motorcycle Maintenance', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'M. Pirsig'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Childhood and Society', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1950, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erik' AND last_name = 'Erikson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Swann''s Way', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Chapters in Western Civilization, Vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Columbia' AND last_name = 'College'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last Days of Socrates, Euthyphro, The Apology, Crito, Phaedo', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -390, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plato' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Japanese Society', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Chie' AND last_name = 'Nakane'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Iliad', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -730, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Homer' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Symposium', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -385, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plato' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Idiot', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1869, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Eminent Victorians', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1918, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lytton' AND last_name = 'Strachey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fifth Business', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robertson' AND last_name = 'Davies'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Second World War', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.J.P.' AND last_name = 'Taylor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Coming Into the Country', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'McPhee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Glory and the Dream', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Manchester'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ressurrection', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1899, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sheltering Sky', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1949, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Bowles'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Heart of Darkness', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1902, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joseph' AND last_name = 'Conrad'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Spring Snow', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Yukio' AND last_name = 'Mishima'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('European History since 1870', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Joll'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Marilyn', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Norman' AND last_name = 'Mailer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Good Morning, Midnight', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The World According to Garp', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Irving'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Protagoras, The Meno', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -430, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plato' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ladies'' Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Price'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Postman Always Rings Twice', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'M. Cain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Voyage in the Dark', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Wealth of Nations', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1776, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Adam' AND last_name = 'Smith'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('New Horizons in Astronomy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'C. Brandt and Stephen P. Maran'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Male and Female', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1949, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'Mead'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ecco Homo', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1888, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Friedrich' AND last_name = 'Nietzsche'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Savage God', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.' AND last_name = 'Alvarez'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jude the Obscure', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1896, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hardy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sense of Beauty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1896, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Santayana'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Gulliver''s Travels', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1726, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Swift'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Autobiography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1922, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.B.' AND last_name = 'Yeats'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ten Days that Shook the World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1926, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Reed'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Slave', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Isaac' AND last_name = 'Bashevis Singer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Liberalism and Social Action', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1935, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Dewey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Working', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Studs' AND last_name = 'Turkel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Great Expectations', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1861, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Botany, a study of pure curiosity', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1781, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The American', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1875, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('New Jerusalem', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Len' AND last_name = 'Jenkin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Life of Birds, vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Dorst'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Within a Budding Grove', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1920, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Zero-Sum Society', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lester' AND last_name = 'C. Thurow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Open Book', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Huston'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Joshua, Then and Now', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mordecai' AND last_name = 'Richler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Socrates', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.X.C.' AND last_name = 'Guthrie'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Body in Question', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Miller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Decline and Fall of the Roman Empire (Abridged)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1787, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edward' AND last_name = 'Gibbon'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Destinies of Darcy Dancer, Gentleman', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.P.' AND last_name = 'Donleavy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Portrait of the Artist as a Young Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1916, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Joyce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Acts of King Arthur and His Noble Knights', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Steinbeck'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('uncollected short stories, vol. 2 (containing "The Inverted Forest")', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1947, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.D.' AND last_name = 'Salinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Dancing Wu Li Masters', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gary' AND last_name = 'Zukav'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Faust (part one)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1805, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Johann' AND last_name = 'Wolfgang Goethe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Powers That Be', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Halberstam'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('As I Walked Out One Midsummer Morning', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Laurie' AND last_name = 'Lee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Autobiography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1562, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Benvenuto' AND last_name = 'Cellini'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lost in America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Isaac' AND last_name = 'Bashevis Singer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nicholas Nickleby', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1839, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Martin Eden', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1909, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jack' AND last_name = 'London'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Washington Square', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1880, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Poetry and Style', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -350, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aristotle' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Confessions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 398, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Saint' AND last_name = 'Augustine'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Politics of International Economic Relations', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joan' AND last_name = 'Edelman Spero'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Gargantua and Pantagruel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1534, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Francois' AND last_name = 'Rabelais'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Breaks of the Game', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Halberstam'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Foundations of the Metaphysics of Morals', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1785, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Immanuel' AND last_name = 'Kant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Life of Charlemagne', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 830, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Einhard' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Enquiry Concerning Human Understanding', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1748, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Hume'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Don Quixote', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1604, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Miguel' AND last_name = 'de Cervantes Saavedra'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Room of One''s Own', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1929, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Virginia' AND last_name = 'Woolf'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Dictionary of Accepted Ideas', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1882, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustave' AND last_name = 'Flaubert'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Book of the Courtier', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1518, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Baldesar' AND last_name = 'Castiglione'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('When Knighthood Was in Flower', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1898, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Major'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Oration on the Dignity of Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1487, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Giovanni' AND last_name = 'Pico della Mirandola'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nuclear Weapons and World Politics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'C. Gompert, Michael Mandelbaum, Richard L. Garwin, John H. Barton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The White Hotel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'D.M.' AND last_name = 'Thomas'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Doing Good(The Limits of Benevolence)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Willard' AND last_name = 'Gaylin, Ira Glasser, Steven Marcus, David Rochman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Emma', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1816, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Austen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On God and Political Duty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1535, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Calvin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Henry James - The Middle Years: 1882--1895', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leon' AND last_name = 'Edel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Book of Laughter and Forgetting', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Milan' AND last_name = 'Kundera'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Runaway Horses', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Yukio' AND last_name = 'Mishima'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The World As I See It', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1932, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Albert' AND last_name = 'Einstein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('First Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1860, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ivan' AND last_name = 'Turgenev'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Government and Politics of France', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vincent' AND last_name = 'Wright'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Wide Sargasso Sea', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sincerity and Authenticity', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lionel' AND last_name = 'Trilling'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Prater Violet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1945, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Christopher' AND last_name = 'Isherwood'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Waning of the Middle Ages', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1919, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Johan' AND last_name = 'Huizinga'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Black Sheep', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1842, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Judaism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1951, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Martin' AND last_name = 'Buber'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Napoleon and the French Empire', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Sylvester'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Three Ages of the Italian Renaissance', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'S. Lopez'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Crazy Horse', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1942, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marie' AND last_name = 'Sandoz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Indecent Exposure', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'McClintick'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Adolescent', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1874, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Goodbye to All That', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1929, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Graves'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ebony Kinship', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'G. Weisbord'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Feudal Society Vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marc' AND last_name = 'Bloch'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bech is Back', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Updike'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Book of Job', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1488, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bible' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Search for Alexander', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robin' AND last_name = 'Lane Fox'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Stephen Hero', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1906, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Joyce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Antony and Cleopatra', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1607, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Justine', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lawrence' AND last_name = 'Durrell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Varieties of Religious Experience', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1902, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nadja', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'André' AND last_name = 'Breton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ever Since Darwin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'Jay Gould'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Master and Margarita', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mikhail' AND last_name = 'Bulgakov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tinker, Tailor, Soldier, Spy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Le Carré'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Bridge of San Luis Rey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thornton' AND last_name = 'Wilder'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Introduction to Contemporary Civilization in the West, Vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1960, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Confessions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1781, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Painted Word', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Wolfe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bookends - The Simon and Garfunkel Story', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Patrick' AND last_name = 'Humphries'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Napoleon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1926, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emil' AND last_name = 'Ludwig'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Social Contract and', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1762, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Social Contract and Discourse on the Origin of Inequality', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1762, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Meteorology, an Introductory Course, Vol. 1 chapters 1, 2, 3', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arnt' AND last_name = 'Eliassen and Kaare Pedersen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Reveries of the Solitary Walker', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1778, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Walden', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1854, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'David Thoreau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Enlightenment (The Rise of Modern Pagasm) *', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Gay'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Makers of Rome (from Lives)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 100, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plutarch' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Narrow Road to the Deep North', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1690, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Basho' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Razor''s Edge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1944, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.' AND last_name = 'Somerset Maugham'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Copland on Music', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aaron' AND last_name = 'Copland'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('''The Misanthrope'' (a play)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1666, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Moliere' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Portrait of the Artist as a Young Dog', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dylan' AND last_name = 'Thomas'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Human Body', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Isaac' AND last_name = 'Asimov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lectures on Literature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladimir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Oresteian Trilogy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -480, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aeschylus' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('''Electra'' (a play)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -435, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sophocles' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('''Trolius and Cressida''', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1602, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Selected Works', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -60, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cicero' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Testament', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elie' AND last_name = 'Wiesel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Albert''s Bridge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Stoppard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('If You''re Glad I''ll Be Frank', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Stoppard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Artist Descending a Staircase', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Stoppard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Greek Lyrics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -500, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sappho,' AND last_name = 'Pindar, Solon, and 23 others'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('One Half of Robertson Davies', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robertson' AND last_name = 'Davies'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Modern Soviet Society', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Basile' AND last_name = 'Kerblay'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ulysses', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1921, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Joyce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Farmer', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jim' AND last_name = 'Harrison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Travel Journal', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1580, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michel' AND last_name = 'de Montaigne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ladies'' Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Price'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('So Long, See You Tomorrow', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Maxwell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ages of Man: readings by John Gielgud', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1600, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nine Stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1953, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.D.' AND last_name = 'Salinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Man Who Dreamed of Tomorrow: The Life and Thought of Wilhelm Reich', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.' AND last_name = 'Edward Mann and Edward Hoffman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Writing the Short Story', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hallie' AND last_name = 'Burnett'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Uncollected Short Stories, Vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.D.' AND last_name = 'Salinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Elements of Style', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Strunk, Jr. and E.B. White'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Confessions of Felix Krull Confidence Man (The Early Years)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Mann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Woman''s Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1883, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Guy' AND last_name = 'de Maupassant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Distracted Preacher'' and four other short stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1888, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hardy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('''The Kiss'' and other short stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1902, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anton' AND last_name = 'Chekhov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('George Bernard Shaw', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Olivia' AND last_name = 'Coolidge'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ninety-nine Novels', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anthony' AND last_name = 'Burgess'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Saint Joan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1924, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Bernard Shaw'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Portable Tolstoy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1908, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Life in Shakespeare''s England', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1634, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Dover Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('What is Art?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1896, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Doll''s House', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1879, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henrik' AND last_name = 'Ibsen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Wired: The Short Life and Fast Times of John Belushi', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bob' AND last_name = 'Woodward'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Republic', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -375, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plato' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Physics for Poets', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'H. March'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Creation', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gore' AND last_name = 'Vidal'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Baron in the Trees', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Italo' AND last_name = 'Calvino'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Managing U.S. - Soviet Rivalry', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alexander' AND last_name = 'L. George'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Italian Journey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1786, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.W.' AND last_name = 'Goethe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Fan''s Notes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Frederick' AND last_name = 'Exley'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fathers and Sons', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1861, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ivan' AND last_name = 'Turgenev'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Axel''s Castle', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1931, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mr. Midshipman Hornblower', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1941, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'C.S.' AND last_name = 'Forster'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Eugene Onegin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1830, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alexander' AND last_name = 'Pushkin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Hero of Our Time', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1839, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mikhail' AND last_name = 'Lermontov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Penguin Atlas of Recent History, Europe since 1815', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Colin' AND last_name = 'McEvedy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"A Simple Heart", "The Legend of St. Julian Hospitator"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1876, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustav' AND last_name = 'Flaubert'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Severed Head', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Iris' AND last_name = 'Murdoch'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Selected Fables', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1693, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'de La Fontaine'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Othello', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1604, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Meditations on First Philosophy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1641, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Réné' AND last_name = 'Descartes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Loneliness of the Long Distance Runner', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alan' AND last_name = 'Sillitoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Souls of Black Folk', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.E.B.' AND last_name = 'Dubois'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Light Years', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Salter'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Unbearable Lightness of Being', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Milan' AND last_name = 'Kundera'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Elizabethan World Picture', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.M.W.' AND last_name = 'Tillyard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Uses of Enchantment', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bruno' AND last_name = 'Bettelheim'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Vanity Fair', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1847, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'M. Thackeray'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mysteries', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1892, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Knut' AND last_name = 'Hamsun'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Home Before Dark', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Susan' AND last_name = 'Cheever'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Ides of March', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1948, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thornton' AND last_name = 'Wilder'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Revolutions and Revolutionaries', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.J.P.' AND last_name = 'Taylor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Breaking with Moscow', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arkady' AND last_name = 'N. Shevchenko'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Actor Prepares', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1936, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Constantin' AND last_name = 'Stanislavski'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Empty Seats', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'White'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Creating a Role', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1938, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Constantin' AND last_name = 'Stanislavski'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Breaks', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Price'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Flag for Sunrise', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Stone'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Neurotic Styles', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Shapiro'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Age of Religious Wars 1559-1715', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'S. Dunn'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Uncle Tom''s Cabin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1852, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harriet' AND last_name = 'Beecher Stowe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('This Man & Music', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anthony' AND last_name = 'Burgess'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Notre Dame of Paris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1831, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Victor' AND last_name = 'Hugo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On the Nature of the Universe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -54, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lucretius' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Codex Leicester', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1507, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leonardo' AND last_name = 'Da Vinci'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Caruso', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Howard' AND last_name = 'Greenfeld'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Guermantes Way', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1925, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fire in the Lake', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Frances' AND last_name = 'Fitzgerald'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Heartburn', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nora' AND last_name = 'Ephron'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Tao of Physics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fritjof' AND last_name = 'Capra'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tao Te Ching', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -600, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lao' AND last_name = 'Tsu'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bloomsbury - A House of Lions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leon' AND last_name = 'Edel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Miss Manners Guide to Excruciatingly Correct Behavior', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Judith' AND last_name = 'Martin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Confession', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1879, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'L.N.' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Color Purple', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alice' AND last_name = 'Walker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('James Joyce', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Ellmann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Queen Lucia part 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1920, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.F.' AND last_name = 'Benson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dubliners', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1905, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Joyce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mayor of Casterbridge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1886, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hardy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Early Church', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Chadwick'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Histories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -446, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Herodotus' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The House of Mirth', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1905, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edith' AND last_name = 'Wharton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A China Passage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.K.' AND last_name = 'Galbraith'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Essays and Aphorisms', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1851, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'Schopenhauer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Europeans', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Luigi' AND last_name = 'Barzini'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Quest for Beauty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rollo' AND last_name = 'May'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cosmos', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carl' AND last_name = 'Sagan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Zen in the Art of Archery', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1953, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Eugen' AND last_name = 'Herrigel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dialogues Concerning Natural Religion', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1775, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Hume'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Conquest of Gaul', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -52, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julius' AND last_name = 'Caesar'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Connecticut Yankee in King Arthur''s Court', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1889, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Linguistics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Hudson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Aeneid', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -30, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Virgil' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Colour of Saying Anthology of Verse', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Renaissance Florence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gene' AND last_name = 'A. Brucker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Politics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edward' AND last_name = 'I. Koch'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lives of the Artists', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1568, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Giorgio' AND last_name = 'Vasari'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Origin of Consciousness in the Breakdown of the Bicameral Mind', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julian' AND last_name = 'Jaynes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Who Rules America Now?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'G.' AND last_name = 'William Domhoff'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Poetry, Language, Thought', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Martin' AND last_name = 'Heidegger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Patterns of Sexuality and Reproduction', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alan' AND last_name = 'S. Parkes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Father and Son', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1907, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'Gosse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Self-Renewal', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Gardner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Inferno', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1314, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dante' AND last_name = 'Alighieri'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Howard''s End', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1910, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.M.' AND last_name = 'Forster'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Poetics of Space', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gaston' AND last_name = 'Bachelard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ironweed', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Kennedy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Odyssey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -700, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Homer' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Selected Letters, edited by Richard Ellman', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Joyce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Act One', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Moss' AND last_name = 'Hart'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Enchanter', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladimir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Heart of Emerson''s Journals, 1820-75', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1875, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ralph' AND last_name = 'Waldo Emerson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Lives of the Great Composers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harold' AND last_name = 'C. Schonberg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Triumph of Politics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'A. Stockman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Dublin Diary of Stanislaus Joyce', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1904, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stanislaus' AND last_name = 'Joyce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Leviathan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1651, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hobbes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Letters to Benvenuta', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1914, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rainer' AND last_name = 'Maria Rilke'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Behavioral Mechanisms in Ecology', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Douglass' AND last_name = 'H. Morse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Gilded Age', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1873, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain and Charles Dudley Warner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Conversations with James Joyce', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'Power'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Use and Abuse of Art', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacques' AND last_name = 'Barzun'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Among the Believers (an Islamic Journey)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'V.S.' AND last_name = 'Naipaul'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Postcards from the Edge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carrie' AND last_name = 'Fisher'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Essays', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1580, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michel' AND last_name = 'Montaigne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cities of the Plain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1913, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Bourgeois Experience Education of the Senses', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Gay'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Ego and the Id', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1923, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sigmund' AND last_name = 'Freud'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Imperialism, The Highest Stage of Capitalism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1916, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'V.I.' AND last_name = 'Lenin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lonesome Dove', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Larry' AND last_name = 'McMurtry'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Between Meals', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.J.' AND last_name = 'Liebling'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Radio in the Television Age', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Fornatale & Joshua E. Mills'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Einstein''s Monsters', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Martin' AND last_name = 'Amis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Arctic Dreams', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Barry' AND last_name = 'Lopez'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Golden Notebook', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Doris' AND last_name = 'Lessing'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Practical Cogitator, The Thinker''s Anthology', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1945, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jurgen', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1919, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Branch Cabell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Deutschland', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1843, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Heinrich' AND last_name = 'Heine'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jews, God and History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Max' AND last_name = 'I. Dimont'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Introduction to American Literature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jorge' AND last_name = 'Luis Borges'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Travels', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1298, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marco' AND last_name = 'Polo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Discourse on Thinking', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Martin' AND last_name = 'Heidegger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Culture of Ancient Egypt', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1951, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'A. Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rameau''s Nephew', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1761, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Denis' AND last_name = 'Diderot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Just So Stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1902, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rudyard' AND last_name = 'Kipling'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Elements of Acoustic Phonetics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Ladefoged'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Nietzsche Reader', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1880, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Friedrich' AND last_name = 'Nietzche'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mansfield Park', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1814, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Austen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Two Cultures & A Second Look', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'C.P.' AND last_name = 'Snow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Life on the Mississippi', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1882, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Game Plan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Zbigniew' AND last_name = 'Brzezinski'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ursule Mirouet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Penguin Atlas of Ancient History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Celia' AND last_name = 'McEvedy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Classic Slum', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Roberts'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Break of Day', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Colette' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Man''s Fate', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'André' AND last_name = 'Malraux'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Andromache', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1672, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Racine'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Getting to Yes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Roger' AND last_name = 'Fisher, William Ury'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Language and Myth', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ernst' AND last_name = 'Cassirer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Perestroika', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mikhail' AND last_name = 'Gorbachev'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Essential Talmud', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Adin' AND last_name = 'Steinsaltz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Midsummer Night''s Dream', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1600, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Letters on England', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1733, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Voltaire' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Bonfire of the Vanities', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Wolfe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Beowulf', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 800, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Beowulf' AND last_name = 'Poet'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Inimitable Jeeves', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1924, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.G.' AND last_name = 'Wodehouse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Singers and the Song', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gene' AND last_name = 'Lees'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tom Sawyer Abroad and Tom Sawyer Detective', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1896, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Notes from the Underground', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1864, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Solace of Open Spaces', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gretel' AND last_name = 'Ehrlich'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Joseph Andrews', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1742, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Fielding'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Later Middle Ages, 1272--1485', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Holmes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The F.B.I. and Martin Luther King, Jr.', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'J. Garrow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Middlemarch', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1872, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Eliot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The 42nd Parallel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1930, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Dos Passos'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Vinland Sagas', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1250, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anonymous' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Money and Politics in the United States', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'J. Malbin, ed.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('For the Record', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Donald' AND last_name = 'T. Regan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Autobiography and other writings', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1790, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Benjamin' AND last_name = 'Franklin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elia' AND last_name = 'Kazan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Oregon Trail', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1849, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Francis' AND last_name = 'Parkman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Art of Literature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'Schopenhauer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('November', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1842, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustave' AND last_name = 'Flaubert'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sidelights on Relativity', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1921, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Albert' AND last_name = 'Einstein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Analects', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -500, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Confucius' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Lake', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Yasunari' AND last_name = 'Kawabata'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Reading', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1905, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"The Paranoid Style in American Politics and Other Essays"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Hofstadter'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Poet''s Work', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'collected' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Epistulae Morales vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 65, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Seneca' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Portable Nabokov', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladimir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Quarrels that have Shaped the Constitution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Word or Two Before You Go', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacques' AND last_name = 'Barzun'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Framely Parsonage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1860, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anthony' AND last_name = 'Trollope'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Metamorphoses', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 5, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ovid' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Third World Politics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Christopher' AND last_name = 'Clapham'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Risk Pool', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Russo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bleak House', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1853, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ancient and Classical Art', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.P.' AND last_name = 'Xahane'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Paris Spleen', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1869, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Baudelaire'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('O Pioneers!', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1913, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Willa' AND last_name = 'Cather'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Late Bourgeois World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nadine' AND last_name = 'Gordimer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Life of Birds, vol. 2', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Corst'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Philosophical Dictionary', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1764, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Voltaire' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Europe Unfolding 1648-1688', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Stoye'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Billy Bathgate', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.L.' AND last_name = 'Doctorow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bernini', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Howard' AND last_name = 'Hibbard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fundamentals of Buddhism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Yasuji' AND last_name = 'Kirimura'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Poetry and Mathematics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1929, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Scott' AND last_name = 'Buchanan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lincoln', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gore' AND last_name = 'Vidal'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Love in the Time of Cholera', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gabriel' AND last_name = 'Garcia Marquez'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Bible', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1488, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bible' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nora - The Real Life of Molly Bloom', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Brenda' AND last_name = 'Maddox'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Paradise Lost', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1667, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Milton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Epitaph for Kings', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sanche' AND last_name = 'de Gramont'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Brief History of Time', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'W. Hawking'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Necessary Angel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1951, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Wallace' AND last_name = 'Stevens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Portable Greek Reader', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1948, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'edited' AND last_name = 'by W.H. Auden'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Wild Ass''s Skin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1831, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Manners from Heaven', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Quentin' AND last_name = 'Crisp'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Civilization and Its Discontents', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1930, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sigmund' AND last_name = 'Freud'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Other America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Harrington'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Still Water - Prose Poems', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Art' AND last_name = 'Garfunkel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Art and Beauty in the Middle Ages', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Umberto' AND last_name = 'Eco'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Fiancée and other stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1890, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anton' AND last_name = 'Chekhov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An American Tragedy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1925, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Theodore' AND last_name = 'Dreiser'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Guidelines to Faith', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Santoru' AND last_name = 'Izumi'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Travels with a Donkey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1879, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Louis Stevenson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Double Helix', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'D. Watson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Manufacturing Consent', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Noam' AND last_name = 'Chomsky, Edward S. Herman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Autobiography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1883, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anthony' AND last_name = 'Trollope'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Power of Myth', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joseph' AND last_name = 'Campbell (with Bill Moyers)'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Quiet Days in Clichy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Miller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Penguin Atlas of Modern History (to 1815)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Colin' AND last_name = 'McEvedy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Stuart England', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.P.' AND last_name = 'Kenyon'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The History of Sexuality vol. 1: An Introduction', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michel' AND last_name = 'Foucault'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Contemporary Writers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1920, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Virginia' AND last_name = 'Woolf'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Henry V"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1599, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lost Illusions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1843, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Great Plains', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ian' AND last_name = 'Frazier'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tales from the Thousand and One Nights', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -850, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anonymous' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Interview With the Vampire', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anne' AND last_name = 'Rice'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Cost of Good Intentions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'R. Morris'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Portable Renaissance Reader', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1500, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bohemian Paris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jerrold' AND last_name = 'Seigel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Connoisseur''s Guide to the Met', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Magriel, John T. Spike'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Innocents Abroad', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1867, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Bell Jar', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sylvia' AND last_name = 'Plath'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Men at Work', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'F. Will'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mythology', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edith' AND last_name = 'Hamilton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Moveable Feast', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1960, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ernest' AND last_name = 'Hemingway'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ethan Frome', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1911, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edith' AND last_name = 'Wharton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Trial of Socrates', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.F.' AND last_name = 'Stone'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Peoples and Cultures of the Middle East', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Bates, Amal Rassam'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"The Knights," "Peace," "The Birds," "Wealth"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -388, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aristophanes' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Histories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 98, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tacitus' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Surrender the Pink', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carrie' AND last_name = 'Fisher'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rising from the Plains', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'McPhee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Lifted Veil', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1879, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Eliot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Magic Mountain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Mann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hit Men', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fredric' AND last_name = 'Dannen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Koran', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 610, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'The' AND last_name = 'Koran'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Human Agenda', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Roderic' AND last_name = 'Gorney'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The History of Henry Esmond', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1852, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Thackeray'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Silent Spring', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rachel' AND last_name = 'Carlson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('It Would Be So Nice If You Weren''t Here', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Grodin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Story of Civilization VIII:', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Will' AND last_name = 'and Ariel Durant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Story of Civilization VIII: The Age of Louis XIV', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Will' AND last_name = 'and Ariel Durant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Coming of Age in Samoa', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'Mead'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('From Beirut to Jerusalem', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'L. Friedman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jamaica Inn', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1936, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daphne' AND last_name = 'du Maurier'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Creative Family', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daisaku' AND last_name = 'Ikeda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Meditations', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 177, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcus' AND last_name = 'Aurelius'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ceremonial Chemistry', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Szasz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Captive', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1921, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Under the Greenwood Tree', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1872, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hardy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Darkness at Noon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'Koestler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Eros and Civilization', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Herbert' AND last_name = 'Marcuse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Two German States and European Security', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'edited' AND last_name = 'by F. Stephen Larrabee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Feudal Society, vol. 2', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marc' AND last_name = 'Bloch'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mambo Kings Play Songs of Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Oscar' AND last_name = 'Hijuelos'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dalva', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jim' AND last_name = 'Harrison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Barbarian Sentiments', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Pfaff'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Princess of Cleves', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1678, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Madame' AND last_name = 'de Lafayette'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rabbit, Run', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1960, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Updike'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bad', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Fussell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Confessions of Nat Turner', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Styron'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Future of an Illusion', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sigmund' AND last_name = 'Freud'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('England in the Late Middle Ages', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.R.' AND last_name = 'Myers'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Making of Urban Europe 1000--1950', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Hohenberg, Lynn Hollen Lees'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Notebooks of Leonardo Da Vinci', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1490, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leonardo' AND last_name = 'Da Vinci'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Simon and Garfunkel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joseph' AND last_name = 'Morella, Patricia Barey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Art of War', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -400, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sun' AND last_name = 'Tzu'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rebuilding Russia', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aleksandr' AND last_name = 'Solzhenitsyn'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Short History of the World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1922, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'H.G.' AND last_name = 'Wells'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Scarlet Pimpernel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1905, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Baroness' AND last_name = 'Orczy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Vintage Mencken', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1933, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'H.L.' AND last_name = 'Mencken'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dr. Jekyll and Mr. Hyde', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1886, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Louis Stevenson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Truly Disadvantaged', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Julius Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sermon on the Mount according to Vendanta', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Swami' AND last_name = 'Prabhavananda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Outline of Psycho-Analysis', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1938, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sigmund' AND last_name = 'Freud'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Narrative of Arthur Gordon Pym', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1938, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edgar' AND last_name = 'Allan Poe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Art of Courtly Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1180, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Andreas' AND last_name = 'Capellanus'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sound and the Fury', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1931, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Faulkner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The House of the Seven Gables', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1851, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nathaniel' AND last_name = 'Hawthorne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Reflections on the Revolution in France', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1790, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'Burke'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Diary of a Madman," "The Nose," "The Overcoat"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1834, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nikolai' AND last_name = 'Gogol'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"The Trajedy of Julius Caesar"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1599, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('America: What Went Wrong?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Donald' AND last_name = 'L. Barlett, James B. Steele'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Nile', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1936, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emil' AND last_name = 'Ludwig'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Before France & Germany', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Patrick' AND last_name = 'J. Geary'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Nun', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1760, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Denis' AND last_name = 'Diderot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mortal Lessons - Notes on the Art of Surgery', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Selzer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Media Monopoly', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ben' AND last_name = 'H. Bagdikian'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Egyptian Art', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cyril' AND last_name = 'Aldred'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Blithedale Romance', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1852, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nathaniel' AND last_name = 'Hawthorne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Murder of Napoleon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ben' AND last_name = 'Weider, David Hapgood'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Jew Today', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elie' AND last_name = 'Wiesel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rome and the Mediterranean', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 17, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Livy' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Man Who Mistook His Wife for a Hat', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Oliver' AND last_name = 'Sacks'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Portable Dorothy Parker', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dorothy' AND last_name = 'Parker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Doctrine of Virtue', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1797, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Immanuel' AND last_name = 'Kant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('American Popular Song', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alec' AND last_name = 'Wilder'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Brain Surgeon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lawrence' AND last_name = 'Shainberg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Letters', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1772, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lord' AND last_name = 'Chesterfield'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sex, Art, and American Culture', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Camille' AND last_name = 'Paglia'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Silas Marner', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1861, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Eliot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Body', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harry' AND last_name = 'Crews'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Demian', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1919, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hermann' AND last_name = 'Hesse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Six Psychological Studies', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Piaget'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Absalom, Absalom!', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1936, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Faulkner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Huxley in Hollywood', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'King Dunaway'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Brideshead Revisited', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1945, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Evelyn' AND last_name = 'Waugh'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('anthology: The European Security Framework in Transition 1984-92', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Unknown' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Random House Dictionary of the English Language', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jess' AND last_name = 'Stein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Dreams', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1901, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sigmund' AND last_name = 'Freud'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Green Hills of Africa', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1935, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ernest' AND last_name = 'Hemingway'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On the Black Hill', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bruce' AND last_name = 'Chatwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Greek Homosexuality', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'K.J.' AND last_name = 'Dover'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('England in the Twentieth Century', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Thomson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('To the Lighthouse', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Virginia' AND last_name = 'Woolf'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Culture We Deserve', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacques' AND last_name = 'Barzun'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('White People', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Allan' AND last_name = 'Gurganus'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Left-Hander Syndrome', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stanley' AND last_name = 'Coren'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Forged Coupon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1904, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leo' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dreaming in Cuban', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cristina' AND last_name = 'Garcia'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cousin Pons', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1847, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Who Runs Congress?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Green'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Golden Door', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Kessner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('White Noise', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Don' AND last_name = 'DeLillo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Utilitarianism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1861, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Stuart Mill'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Kim', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1901, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rudyand' AND last_name = 'Kipling'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Einstein''s Dreams', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alan' AND last_name = 'Lightman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Joan of Arc', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jules' AND last_name = 'Michelet'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Early Socratic Dialogues', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -327, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plato' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Escape from Freedom', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1941, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erich' AND last_name = 'Fromm'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Offensive Traveller', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'V.S.' AND last_name = 'Pritchett'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('An Outline of American Literature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'B. High'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('AIDS and Its Metaphors', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Susan' AND last_name = 'Sontag'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bonjour Tristesse', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Françoise' AND last_name = 'Sagan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Winesburg, Ohio', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1919, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sherwood' AND last_name = 'Anderson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mystery and Manners', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Flannery' AND last_name = 'O''Connor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Turn of the Screw', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1898, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Cabala', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1926, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thornton' AND last_name = 'Wilder'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Atlas of Medieval Europe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Donald' AND last_name = 'Matthew'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Thousand Acres', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Smiley'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Basic Astronomy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Patrick' AND last_name = 'Moore'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mont Saint Michael and Chartres', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1904, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Adams'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Germinal', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1885, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emile' AND last_name = 'Zola'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Prose Poems and La Fanfarlo', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1865, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Baudelaire'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Old Curiosity Shop', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Delusions of Grandma', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carrie' AND last_name = 'Fisher'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Sentimental Journey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1768, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Laurence' AND last_name = 'Sterne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Trial', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1920, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Franz' AND last_name = 'Kafka'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Confessions of an English Opium Eater', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1822, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'DeQuincy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Writing Down the Bones', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Natalie' AND last_name = 'Goldberg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Journal of the Plague Year', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1725, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Defoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('After Leaving Mr. Mackenzie', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1931, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sweet Cheat Gone', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1922, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Beginnings of English Society', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dorothy' AND last_name = 'Whitelock'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Hurlyburly"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Rabe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Diplomacy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Kissinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Songlines', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bruce' AND last_name = 'Chatwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Seat of the Soul', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gary' AND last_name = 'Zukav'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Denial of Death', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ernest' AND last_name = 'Becker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Life and Opinions of Tristam Shandy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1767, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Laurence' AND last_name = 'Sterne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Babbitt', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1922, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sinclair' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('China - A New History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'King Fairbank'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Beloved', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Toni' AND last_name = 'Morrison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Amerika', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Franz' AND last_name = 'Kafka'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Choose Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arnold' AND last_name = 'Toynbee & Daisaku Ikeda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How We Die', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sherwin' AND last_name = 'B. Nuland'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Kant''s Moral Philosophy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'H.B.' AND last_name = 'Acton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Call of the Wild', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jack' AND last_name = 'London'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Conversations with Kafka', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1923, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustav' AND last_name = 'Janouch'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Way of All Flesh', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Butler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Journals of Lewis and Clark', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1804, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Meriwether' AND last_name = 'Lewis and William Clark'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The New Chinatown', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Kwong'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Devils', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1871, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoyevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Magic Years', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Selma' AND last_name = 'H. Fraiberg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Making of a Public Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sol' AND last_name = 'M. Linowitz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Red and the Black', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1830, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stendhal' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('England in the Eighteenth Century', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1950, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.H.' AND last_name = 'Plumb'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Psychology of Man''s Possible Evolution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.D.' AND last_name = 'Ouspensky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Heart is a Lonely Hunter', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carson' AND last_name = 'McCullers'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Black Water', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joyce' AND last_name = 'Carol Oates'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Slavery Defended', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1857, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'editor,' AND last_name = 'Eric L. McKitrick'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Raising a Son', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Don,' AND last_name = 'Jeanne Elium'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Master and Commander', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1970, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Patrick' AND last_name = 'O''Brian'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Continental Drift', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Russell' AND last_name = 'Banks'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Bhagavad Gita', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -500, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vyasa' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Utopia', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1516, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'More'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ragtime', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.L.' AND last_name = 'Doctorow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Early Greek Thinking', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1950, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Martin' AND last_name = 'Heidegger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Drama of the Gifted Child', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alice' AND last_name = 'Miller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Emotional Intelligence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Goleman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Ethics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1663, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Benedict' AND last_name = 'de Spinoza'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Who''s Who in the Ancient World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Betty' AND last_name = 'Radice'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Federalist Papers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1788, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alexander' AND last_name = 'Hamilton and James Madison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Beyond the Melting Pot', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nathan' AND last_name = 'Glazer and Daniel P. Moynihan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Your Five-Year Old', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Louise' AND last_name = 'Ames'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Robinson Crusoe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1719, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Defoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Towards Understanding Islam', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Abul' AND last_name = 'A''La Mawdudi'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Red Badge of Courage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1895, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'Crane'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Latin Literature - an Anthology', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 400, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Life of Samuel Johnson', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1791, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Boswell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Balkan Ghosts', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'D. Kaplan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Primary Colors', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'anonymous' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Henry IV, Part One"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1597, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Growing Up', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Russell' AND last_name = 'Baker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Flaubert in Egypt', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1850, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustave' AND last_name = 'Flaubert'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('You''ll Never Make Love in this Town Again', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robin,' AND last_name = 'Liza, Linda, Tiffany'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('I, Claudius', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Graves'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Our Crowd"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'Birmingham'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Breast Cancer', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'I. Pressman and Yahsar Hirshaut'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Future of Capitalism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lester' AND last_name = 'C. Thurow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Murky Business', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honoré' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pensées', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1661, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Blaise' AND last_name = 'Pascal'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Quantum Healing', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Deepak' AND last_name = 'Chopra'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Childhood', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1913, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Maxim' AND last_name = 'Gorky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Riding the Iron Rooster', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Theroux'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Discourse on Method and The Meditations', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1637, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'René' AND last_name = 'Descartes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('You Just Don''t Understand', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Deborah' AND last_name = 'Tannen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Natural History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 76, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Pliny' AND last_name = 'the Elder'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Shogun', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1975, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Clavell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Conversations with Socrates', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -401, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Xenophon' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dispatches', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Herr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Invisible Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1897, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'H.G.' AND last_name = 'Wells'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Absolute Power', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Baldacci'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Second Sex', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Simone' AND last_name = 'DeBeauvoir'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jonathan Wild', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1743, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Fielding, Daniel Defoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Liars'' Club', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'Karr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Grooming, Gossip, and the Evolution of Language', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robin' AND last_name = 'Dunbar'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Club of Queer Trades', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1905, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'G.K.' AND last_name = 'Chesterton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Origins of the Middle Ages', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bryce' AND last_name = 'Lyon'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Night Flight', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1932, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Antoine' AND last_name = 'de Saint Exupery'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tales from Shakespeare', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1807, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'and Mary Lamb'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Le Morte D''Arthur, vol. 1 book I-VII', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1485, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sir' AND last_name = 'Thomas Malory'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Twelve Steps and Twelve Traditions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alcoholics' AND last_name = 'Anonymous'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mao II', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Don' AND last_name = 'DeLillo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Around the World in Eighty Days', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1873, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jules' AND last_name = 'Verne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hitler''s Willing Executioners', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Johan Goldhagen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Enlightenment - The Science of Freedom', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1969, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Gay'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Feast of Snakes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harry' AND last_name = 'Crews'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Émile', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1760, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Narcissus and Goldmund', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1930, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hermann' AND last_name = 'Hesse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Classical Literary Criticism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -10, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aristotle,' AND last_name = 'Horace'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fiesta, The Sun Also Rises', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ernest' AND last_name = 'Hemingway'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cut of America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Keith' AND last_name = 'B. Richburg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Shame of the Cities', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1904, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lincoln' AND last_name = 'Steffens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Les Liaisons Dangereuses', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1782, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Choderlos' AND last_name = 'DeLaclos'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Civil Action', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Harr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('To Kill a Mockingbird', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1960, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harper' AND last_name = 'Lee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Great Books', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Denby'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lake Wobegon Days', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Garrison' AND last_name = 'Keillor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Paul McCartney - Many Years from Now', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Barry' AND last_name = 'Miles'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Satires and Epistles', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -18, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Horace' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Shipping News', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.' AND last_name = 'Annie Proulx'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Closing of the American Mind', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Allan' AND last_name = 'Bloom'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Prince', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1514, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Niccolò' AND last_name = 'Machiavelli'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Democracy in America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1835, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alexis' AND last_name = 'De Tocqueville'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Angela''s Ashes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Frank' AND last_name = 'McCourt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('my old sweetheart', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1982, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Susanna' AND last_name = 'Moore'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Culture of Complaint', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Hughes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Perfume', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Patrick' AND last_name = 'Suskind'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Simon and Garfunkel - The Definitive Biography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Victoria' AND last_name = 'Kingston'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Second Treatise of Government', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1690, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Locke'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Phaedrus', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -375, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plato' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Barnaby Rudge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Zuckerman Unbound', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Philip' AND last_name = 'Roth'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Twist in the Tale - 4 short stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jeffrey' AND last_name = 'Archer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tudor England', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1950, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'S.T.' AND last_name = 'Bindoff'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Appointment in Samarra', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'O''Hara'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Invisible Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ralph' AND last_name = 'Ellison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Matisse Stories', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.S.' AND last_name = 'Byatt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Decameron', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1350, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Giovanni' AND last_name = 'Boccaccio'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Representations of the Intellectual', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edward' AND last_name = 'W. Said'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Greek Myths: 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Graves'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Art of the Renaissance', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'and Linda Murray'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Beggar and the Professor', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emmanuel' AND last_name = 'Le Roy Ladurie'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Buddha in Daily Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Causton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tuesday with Morrie', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mitch' AND last_name = 'Albom'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sons and Lovers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1913, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'D.H.' AND last_name = 'Lawrence'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Silk', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alessandro' AND last_name = 'Baricco'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Asian Financial Crisis: Causes, Cures, and Systemic Implications', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Morris' AND last_name = 'Goldstein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tunesmith', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jimmy' AND last_name = 'Webb'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Golden Bowl', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1904, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Quartet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Covering Islam', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edward' AND last_name = 'W. Said'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Other Inquisitions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jorge' AND last_name = 'Luis Borges'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Road Ahead', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'Gates'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Memoirs of a Geisha', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'Golden'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Hand', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Frank' AND last_name = 'R. Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Tour Through the Whole Island of Great Britain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1724, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'DeFoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cloudsplitter', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Russell' AND last_name = 'Banks'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Moral Animal', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Wright'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('French Leave', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.G.' AND last_name = 'Wodehouse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Past Recaptured', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1922, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marcel' AND last_name = 'Proust'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hiroshima', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Hersey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Liberty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1859, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Stuart Mill'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('American Pastoral', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Philip' AND last_name = 'Roth'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Paridiso', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1308, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dante' AND last_name = 'Alighieri'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How The Other Half Lives', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1890, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacob' AND last_name = 'A. Riis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cycle of Violence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Colin' AND last_name = 'Bateman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Identity of France', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fernand' AND last_name = 'Braudel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('It Can''t Happen Here', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1935, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sinclair' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lords of the Horizons - A History of the Ottoman Empire', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jason' AND last_name = 'Goodwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The World''s Most Famous Math Problem', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marilyn' AND last_name = 'Vos Savant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mansion on the Hill', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fred' AND last_name = 'Goodman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Toward a Culture of Peace: A Cosmic View', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daisaku' AND last_name = 'Ikeda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Raising Cain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dan' AND last_name = 'Kindlon, Michael Thompson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Longitude', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dava' AND last_name = 'Sobol'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fear and Trembling', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1843, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Søren' AND last_name = 'Kierkegaard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Antigone"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -441, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sophocles' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Where Did I Go Right?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bernie' AND last_name = 'Brillstein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Selfish Gene', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Dawkins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Struggle for Mastery in Europe - 1848 - 1918', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.J.P.' AND last_name = 'Taylor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Endurance - Shackleton''s Incredible Voyage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alfred' AND last_name = 'Lansing'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"Andromache"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -425, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Euripides' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Erewhon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1871, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Butler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All Too Human', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Stephanopoulos'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tom Jones', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1749, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Fielding'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('City of Night', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Rechy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My German Question', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Gay'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Their Eyes Were Watching God', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1937, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Zora' AND last_name = 'Neale Hurston'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mysterious Stranger', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1906, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Twain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Interpreter of Maladies', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jhumpa' AND last_name = 'Lahiri'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Grapes of Wrath', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Steinbeck'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The New New Thing', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('From Dawn to Decadence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacques' AND last_name = 'Barzun'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Alps & Sanctuaries', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1881, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Butler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Three Musketeers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1844, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alexander' AND last_name = 'Dumas'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Christopher Columbus, Mariner', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1942, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Eliot Morison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Princess of Cleves', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1677, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Madame' AND last_name = 'de Lafayette'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Man in Full', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Wolfe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Samson Agonistes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1671, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Milton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Shape of Time', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Kubler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Diary of a Napoleonic Foot Soldier', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1830, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jakob' AND last_name = 'Walter'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1819, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stendhal' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Diplomacy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sir' AND last_name = 'Harold Nicolson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Liber Amoris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1823, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Hazlitt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The History of the Standard Oil Company', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ida' AND last_name = 'M. Tarbell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mein Kampf', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1926, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Adolph' AND last_name = 'Hitler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Physiology of Marriage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1824, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honore' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Henderson the Rain King', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Saul' AND last_name = 'Bellow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mind of the Maker', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1941, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dorothy' AND last_name = 'L. Sayers'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The World of the Pharoahs', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Christine' AND last_name = 'Hobson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ragged Dick', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1868, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Horatio' AND last_name = 'Alger, Jr.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A World Restored', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Kissinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Chouans', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1827, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honore' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Operator', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'King'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Selected Letters of Lord Byron', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1798, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lord' AND last_name = 'Byron'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('La Nouvelle Heloise', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1758, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Physics and Politics', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1872, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Walter' AND last_name = 'Bagehot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Rites of Autumn', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dan' AND last_name = 'O''Brien'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Can Japan Compete?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'E. Porter, Hirotaka Takeuchi, Mariko Sakakibara'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Courbet', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sarah' AND last_name = 'Faunce'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Waves', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1931, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Virginia' AND last_name = 'Woolf'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Understanding War', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1992, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Paret'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jeeves in the Morning', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.' AND last_name = 'G. Wodehouse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sister Carrie', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1900, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Theodore' AND last_name = 'Dreiser'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jihad vs. McWorld', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Benjamin' AND last_name = 'R. Barber'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Harry Potter and the Sorcerer''s Stone', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.K.' AND last_name = 'Rowling'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Universe in a Nutshell', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'Hawking'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Trouble with Cinderella', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Artie' AND last_name = 'Shaw'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Autobiography of a Yogi', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paramahansa' AND last_name = 'Yogananda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('What Went Wrong?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bernard' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Wives and Daughters', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1866, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elizabeth' AND last_name = 'Gaskell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Jungle', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1905, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Upton' AND last_name = 'Sinclair'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Foundations of Early Modern Europe, 1460-1569', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Eugene' AND last_name = 'F. Rice, Jr.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dream Catcher', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'A. Salinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Selected Journals of Henry David Thoreau', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1862, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'David Thoreau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sleep It Off Lady', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fall of the Roman Republic', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 90, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Plutarch' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hornblower and Hotspur', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'C.S.' AND last_name = 'Forester'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Splendid Century', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1953, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.H.' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Fatal Shore', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Hughes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Profit Over People', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Noam' AND last_name = 'Chomsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Progress and Poverty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1879, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'George'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Choose Hope', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Krieger, Daisaku Ikeda'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Under the Volcano', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1947, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Malcolm' AND last_name = 'Lowry'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Good Terrorist', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Doris' AND last_name = 'Lessing'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Man''s Search for Meaning', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Viktor' AND last_name = 'E. Frankl'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Good Behavior', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harold' AND last_name = 'Nicolson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Good Behavior', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lucien' AND last_name = 'Febvr, Henri-Jean Martin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Take on the Street', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthure' AND last_name = 'Levitt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Post Office', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Bukowski'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Cove', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jose' AND last_name = 'Saramago'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Women in Western Political Thought', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Susan' AND last_name = 'Mollin Okin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Veron God Little', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'DBC' AND last_name = 'Pierre'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Persian Boy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'Renault'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hollywood', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Bukowski'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Early Christian & Byzantine Art', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Lowden'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Woman - An Intimate Geography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Natalie' AND last_name = 'Angier'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('History of the Franks', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 584, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gregory' AND last_name = 'Bishop of Tours'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Terror and Liberalism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Berman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Groves of Academe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1951, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'McCarthy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Does America Need a Foreign Policy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Kissinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Giacometti Portrait', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Lord'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Budda', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Karen' AND last_name = 'Armstrong'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Islam', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Karen' AND last_name = 'Armstrong'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Adam Bede', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1859, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Eliot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Global Civilization - A Buddist Islanic Dialogue', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daisaku' AND last_name = 'Ikeda, Majid Tehranian'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Third Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1950, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Graham' AND last_name = 'Greenauthor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Years of Lyndon Johnson - Master of the Senate', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'A. Caro'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Republic and the School', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1848, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Horace' AND last_name = 'Mann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Benjamin Franklin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'S. Morgan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bruegel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Claude' AND last_name = 'Mettra'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Waiting for the Barbarians', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.' AND last_name = 'M. Coetzee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Da Vinci Code', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dan' AND last_name = 'Brown'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Memoirs of a Madman', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1837, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gustave' AND last_name = 'Flaubert'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('"The Acharnians", "The Clouds", "Lysistrata"', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -410, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aristophanes' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Girl With a Pearl Earing', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tacey' AND last_name = 'Chevalier'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Western Canon', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harold' AND last_name = 'Bloom'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Renaissance', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1873, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Walter' AND last_name = 'Pater'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Real Boys', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Pollack'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Complete Fables', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -550, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aesop' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Satires', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 130, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Juvenal' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Love Groucho', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Groucho' AND last_name = 'Marx'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Man Who Was Thursday', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1908, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'G.K.' AND last_name = 'Chesterton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Confederacy of Dunces', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Kennedy Toole'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Roman Imperial Civilization', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Harold' AND last_name = 'Mattingly'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A London Girl of the 1880''s', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Molly' AND last_name = 'Hughes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How To Be Good', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nick' AND last_name = 'Hornby'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Pilgrim''s Progress', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1684, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Bunyan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Moyers on America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'Moyers'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Specimen Days', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1865, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Walt' AND last_name = 'Whitman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Eleven Minutes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paulo' AND last_name = 'Coelho'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Christianity, Social Torerance and Homosexuality', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Boswell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Persian Gulf in Transition', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lawrence' AND last_name = 'Potter'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Perpetual Peace', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1795, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Immanuel' AND last_name = 'Kant'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Chronicles, vol. 1', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bob' AND last_name = 'Dylan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Gladiators', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1949, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arthur' AND last_name = 'Koestler'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('From Puritan to Yankee', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'L. Bushman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Study of History, vols I-VI', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Arnold' AND last_name = 'Toynbee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The End of Nature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'McKibben'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('House of Bush, House of Saudi', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Craig' AND last_name = 'Unger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Glorious Appearing', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tim' AND last_name = 'LaHaye, Jerry B. Jenkins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Story Like the Wind', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Laurens' AND last_name = 'Van der Post'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Gilead', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marilynne' AND last_name = 'Robinson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The French Revolution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1837, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Carlyle'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Johnny Got His Gun', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dalton' AND last_name = 'Trumbo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mon Cher Papa, Franklin and the Ladies of Paris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1966, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Claude-Anne' AND last_name = 'Lopez'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bushworld', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Maureen' AND last_name = 'Dowd'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1886, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anton' AND last_name = 'Chekhov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Renaissance Europe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.R.' AND last_name = 'Hale'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Passage to India', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1924, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.M.' AND last_name = 'Forster'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Crimes Against Nature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'F. Kennedy, Jr.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sandy Koufax', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Leavy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('1776', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'McCullough'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Octopus', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1900, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Frank' AND last_name = 'Norris'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hang a Thousand Trees with Ribbons', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ann' AND last_name = 'Rinaldi'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bartleby the Scrivener', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1853, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Herman' AND last_name = 'Melville'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Chapters in Western Civilization vol II', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Various' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lives of the Great Songs', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tim' AND last_name = 'De Lisle'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('As Thousands Cheer - The Life of Irving Berlin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Laurence' AND last_name = 'Bergreen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Way We Live Now', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1873, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anthony' AND last_name = 'Trollope'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Shopgirl', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2000, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Steve' AND last_name = 'Martin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Debacle', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1870, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emile' AND last_name = 'Zola'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A History of Japan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Kenneth' AND last_name = 'Henshall'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Rise of Theodore Roosevelt', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'Morris'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Education of Henry Adams', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1907, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Adams'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Freedom: Credos from the Road', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sonny' AND last_name = 'Barger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Day of the Locust', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nathanael' AND last_name = 'West'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Good Soldier', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1915, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ford' AND last_name = 'Maddox Ford'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Vindication of the Rights of Woman', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1792, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'Wollstonecraft'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Age of Innocence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1920, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edith' AND last_name = 'Wharton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Of Human Bondage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1915, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.' AND last_name = 'Somerset Maugham'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Team of Rivals', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Doris' AND last_name = 'Kearns Goodwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Postwar', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tony' AND last_name = 'Judt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Here, There, and Everywhere', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Geoff' AND last_name = 'Emerick'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Angle of Repose', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Wallace' AND last_name = 'Stegner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('James Dean, The Mutant King', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Dalton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('India: A Wounded Civilisation', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'V.S.' AND last_name = 'Naipaul'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Adventures of Pinocchio', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1881, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carlo' AND last_name = 'Collodi'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Women in Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1916, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'D.' AND last_name = 'H. Lawrence'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Economic and Social History of Medieval Europe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1936, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henri' AND last_name = 'Pirenne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Farther Reaches of Human Nature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'A.' AND last_name = 'H. Maslow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Our Mutual Friend', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1865, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Speak Memory', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1947, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladimir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Steppenwolf', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hermann' AND last_name = 'Hesee'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Richard Hofstadter. An Intellectual Biography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'S. Brown'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All the King''s Men', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Penn Warren'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Friendship', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1580, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michel' AND last_name = 'DeMontaigne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('1215 The Year of Magna Carta', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Danny' AND last_name = 'Danzinger & John Gillingham'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Legends of the Fall', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jim' AND last_name = 'Harrison'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Collapse - How Societies Choose to Fail Or Succeed', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jared' AND last_name = 'Diamond'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Future of Freedom', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fareed' AND last_name = 'Zakaria'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Ginger Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.P.' AND last_name = 'Donleavy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Movie Business', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Irving'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All''s Well That Ends Well', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1602, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Quiet American', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1955, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Graham' AND last_name = 'Greene'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The History of Alexander', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 44, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Quintus' AND last_name = 'Curtius Rufus'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Autocrat of the Breakfast Table', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1858, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Oliver' AND last_name = 'Wendell Holmes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jackson''s Dilemma', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Iris' AND last_name = 'Murdoch'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Corrections', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Franzen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Pilgrim''s Progress', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'W.S. Trow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Carolingian Empire', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Heinrich' AND last_name = 'Fichtenau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('God, Guns and Israel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jill' AND last_name = 'Hamilton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The History of King Richard III', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1557, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sir' AND last_name = 'Thomas More'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Confessions', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1781, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean-Jacques' AND last_name = 'Rousseau'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Marble Faun', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1860, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nathaniel' AND last_name = 'Hawthorne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Russian Thinkers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Isaiah' AND last_name = 'Berlin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Don''t You Forget About Me', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cecily' AND last_name = 'von Ziegesar'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Chesil Beach', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ian' AND last_name = 'McEwan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Motherless Brooklyn', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Lethem'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Essential Fromm', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erich' AND last_name = 'Fromm'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Gospel According to Jesus Christ', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'José' AND last_name = 'Saramago'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mass-Mediated Terrorism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Brigitte' AND last_name = 'L. Nacos'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Year of Magical Thinking', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joan' AND last_name = 'Didion'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Waiting for Godot', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Beckett'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Prophecies', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1519, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leonardo' AND last_name = 'da Vinci'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Depleted Self', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Donald' AND last_name = 'Capps'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tigers are Better Looking', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jean' AND last_name = 'Rhys'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Leaves from the Notebook of a Tamed Cynic', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Reinhold' AND last_name = 'Niebuhr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Harlemworld', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'J. Jackson, Jr.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Philosophical Enquiry into the Origin of our Ideas of the Sublime and Beautiful', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1757, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'Burke'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Labyrinth of Solitude', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Octavio' AND last_name = 'Paz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Bend in the River', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'V.S.' AND last_name = 'Naipaul'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bold Spirit- Helga Estby''s Forgotten Walk Across Victorian America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Linda' AND last_name = 'Lawrence Hunt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Gambler', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1866, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nobel Lecture', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1972, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Aleksandr' AND last_name = 'Solzhenitsyn'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Maimonides: A Guide for Today''s Perplexed', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Kenneth' AND last_name = 'Seeskin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Magnificent Ambersons', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1918, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Booth' AND last_name = 'Tarkington'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Death and Life of Great American Cities', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1961, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jane' AND last_name = 'Jacobs'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Assault on Reason', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Al' AND last_name = 'Gore'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fires', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1984, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Raymond' AND last_name = 'Carver'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Black Swan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nassim' AND last_name = 'Nicholas Taleb'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last Hero', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Forbath'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Essays', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1625, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Francis' AND last_name = 'Bacon'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Restoration', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1989, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rose' AND last_name = 'Tremain'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The History of England', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1849, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lord' AND last_name = 'Macaulay'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Lover', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marguerite' AND last_name = 'Duras'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Last Letters - Prisons & Prisoners of the French Revolution 1793-94', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Olivier' AND last_name = 'Blanc'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Human Nature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1640, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Hobbes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Confessions of an Economic Hit Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Perkins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Orientalism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edward' AND last_name = 'W. Said'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Places in Between', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rory' AND last_name = 'Stewart'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Handful of Dust', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Evelyn' AND last_name = 'Waugh'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Cold War', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Lewis Gaddis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Girls of Slender Means', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Muriel' AND last_name = 'Spark'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Shia Revival', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vali' AND last_name = 'Nasr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Blood, Toil, Tears and Sweat', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Lukacs'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Restless', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Boyd'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Five Easy Decades', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dennis' AND last_name = 'McDouglas'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Of Time and the River', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1935, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Wolfe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Professor and the Madman', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Simon' AND last_name = 'Winchester'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Call It Sleep', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Roth'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Brief Wondrous Life of Oscar Wao', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Junot' AND last_name = 'Diaz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Limits of Power', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Andrew' AND last_name = 'J. Bacevich'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Some Times a Great Notion', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ken' AND last_name = 'Kesey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lady Chatterley''s Lover', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'D.H.' AND last_name = 'Lawrence'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Courage to Be', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Tillich'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Murphy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1938, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Beckett'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cranford', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1853, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elizabeth' AND last_name = 'Gaskell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rimbaud - The Double Life of a Rebel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'White'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Perspective of the World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1979, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fernand' AND last_name = 'Braudel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Death of the Heart', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1938, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elizabeth' AND last_name = 'Bowen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Tolstoy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henri' AND last_name = 'Troyat'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Palestine, Peace Not Apartheid', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jimmy' AND last_name = 'Carter'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Skyscraper Dreams', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Shachtman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Principles of Human Knowledge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1710, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Berkeley'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The English Constitution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1867, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Walter' AND last_name = 'Bagehot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Post-American World', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fareed' AND last_name = 'Zakaria'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('And Quiet Flows the Don', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mikhail' AND last_name = 'Sholokhov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Beak of the Finch', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1994, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Weiner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hua Hu Ching', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -600, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lao' AND last_name = 'Tzu'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Singularity Is Near', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ray' AND last_name = 'Kurzweil'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Treasure Island', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1883, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Louis Stevenson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Kite Runner', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Khaled' AND last_name = 'Hosseini'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rhyming Life & Death', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Amos' AND last_name = 'Oz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Moon and Sixpence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1919, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.' AND last_name = 'Somerset Maugham'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On the Good Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -60, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cicero' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Beauty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Zadie' AND last_name = 'Smith'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Wishful Drinking', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Carrie' AND last_name = 'Fisher'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How I Got to Be Whoever It is I Am', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Grodin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Byron in Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edna' AND last_name = 'O''Brien'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last of Mr. Norris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1935, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Christopher' AND last_name = 'Isherwood'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Goodbye to Berlin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1945, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Christopher' AND last_name = 'Isherwood'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Alexandria - A History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1918, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.M.' AND last_name = 'Forster'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pamela', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1740, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Samuel' AND last_name = 'Richardson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fanny Hill', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1749, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Cleland'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Roxanna', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1724, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Defoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('New Science', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1725, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Giambattista' AND last_name = 'Vico'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('I Feel Bad About My Neck', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nora' AND last_name = 'Ephron'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Civilization of the Renaissance in Italy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1857, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacob' AND last_name = 'Burckhardt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Oblomov', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1859, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ivan' AND last_name = 'Goncharov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Darwin’s Worms', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Adam' AND last_name = 'Phillips'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Justine', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1787, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'D.A.F.' AND last_name = 'Marquis deSade'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Story of a Year 1848', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Raymond' AND last_name = 'Postgate'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Essays on Miscellaneous Subjects; with an Inquiry Into the Present State of Polite Learning', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1774, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Oliver' AND last_name = 'Goldsmith'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Income InEquality in America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Ryscavage'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The SeaWolf', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1903, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jack' AND last_name = 'London'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Origins of the Second World War in Asia and the Pacific', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1987, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Akira' AND last_name = 'Iriye'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Race: A Study in Superstition', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1937, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jacques' AND last_name = 'Barzun'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Why I Write', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1946, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Orwell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Collection of Genteel and Ingenious Conversation', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1754, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Swift'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Too Big To Fail', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Andrew' AND last_name = 'Ross Sorkin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Red Harvest', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1929, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Dashielle' AND last_name = 'Hammett'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Reflections on the Revolution in Europe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Christopher' AND last_name = 'Caldwell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Rise of the Roman Empire', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 130, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Polybius' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Drinking Den', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1877, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emile' AND last_name = 'Zola'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('War in European History', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1976, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Howard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Game Change', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Heileman, Mark Halperin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cakes and Ale', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1930, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'W.Somerset' AND last_name = 'Maughan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Oedipus at Colonus', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -410, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sophocles' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Backing Into Forward', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jules' AND last_name = 'Feiffer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Journey to the East', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hermann' AND last_name = 'Hesse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Native Son', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1940, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Richard' AND last_name = 'Wright'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Gurdjieff', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Moore'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Shantaram', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gregory' AND last_name = 'David Roberts'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Shattered Peace', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'A. Andelman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Girl With The Dragon Tattoo', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stieg' AND last_name = 'Larsson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sailing Alone Around The Room', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1998, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Billy' AND last_name = 'Collins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nothing Special', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1993, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charlotte' AND last_name = 'Joko Beck'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Alchemist', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paulo' AND last_name = 'Coelho'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Woman in White', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1860, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Wilkie' AND last_name = 'Collins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Help', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Kathryn' AND last_name = 'Stockett'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The House of Morgan', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ron' AND last_name = 'Chernow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Game From Where I Stand', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Doug' AND last_name = 'Glanville'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Brain That Changes Itself', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Norman' AND last_name = 'Doidge, M.D.'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Other People’s Money and How Bankers Use It', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1913, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Louis' AND last_name = 'D. Brandeis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How To Be Alone', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Franzen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Heart Without Measure', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1999, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ravi' AND last_name = 'Ravindra'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Murder On The Orient Express', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Agatha' AND last_name = 'Christie'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Rambles Beyond Railways', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1852, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Wilkie' AND last_name = 'Collins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Gorky Park', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Martin' AND last_name = 'Cruz Smith'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Examined Lives', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Miller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Doctor Faustus', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1947, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Mann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('One, No One & One Hundred Thousand', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1926, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Luigi' AND last_name = 'Pirandello'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Wilderness & The American Mind', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Roderick' AND last_name = 'Frazier Nash'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Main Street', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1920, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sinclair' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Thousand-Mile Walk to The Gulf', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1867, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Muir'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Journey of the Universe', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Brian' AND last_name = 'Thomas Swimme & Mary Evelyn Tucker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Poetic Lives: Keats', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Mighall'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('John Keats A Beginner’s Guide', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Edwards'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Keith Richards The Biography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Victor' AND last_name = 'Bockris'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Moll Flanders', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1722, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Daniel' AND last_name = 'Defoe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Backstabbing For Beginners', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Soussan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Beyond Good and Evil', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1886, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Friedrich' AND last_name = 'Nietzsche'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Song of The Lark', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1915, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Willa' AND last_name = 'Cather'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Vendetta', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1830, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honore' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Book of Silence', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sara' AND last_name = 'Maitland'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Memoirs of An Egotist', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1832, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stendhal' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('History and The Enlightenment', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hugh' AND last_name = 'Trevor-Roper'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('For a Night of Love, Nantas, Fasting', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1876, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emile' AND last_name = 'Zola'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Life of Pi', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Yann' AND last_name = 'Martel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ninety Minutes in Heaven', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Don' AND last_name = 'Piper with Cecil Murphy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Quiet Chaos', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sandro' AND last_name = 'Veronesi'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Sketches By Boz', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1836, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Present Indicative: An Autobiography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1937, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Noel' AND last_name = 'Coward'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fire and Rain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Browne'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Deep Secrets', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Niobe' AND last_name = 'Way'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pnin', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1953, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladmir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('In The Garden Of Beasts', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erik' AND last_name = 'Larson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Night', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elie' AND last_name = 'Wiesel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Even This', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1953, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sanford' AND last_name = 'D. Greenberg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Garden Squabble', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1835, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nikolai' AND last_name = 'Gogol'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ladies and Gentlemen: Lenny Bruce!', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1971, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Albert' AND last_name = 'Goldman, Lawrence Schiller'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Elegance of the Hedgehog', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Muriel' AND last_name = 'Barbery'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Full Service', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2012, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Scotty' AND last_name = 'Bowers'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Unbroken', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Laura' AND last_name = 'Hillenbrand'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Nana', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1880, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emile' AND last_name = 'Zola'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Buddha in the Attic', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julie' AND last_name = 'Otsuka'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Gone for a Ride', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2007, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Timothy' AND last_name = 'L. Hoffmann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fifty Shades of Grey', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'E.L.' AND last_name = 'James'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pale Fire', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1959, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Vladimir' AND last_name = 'Nabokov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Intelligent Investor', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Benjamin' AND last_name = 'Grahanm, Jason Zweig'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Uncle Fred in the Springtime', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1939, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.G.' AND last_name = 'Wodehouse'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Book Addict''s Treasury', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julie' AND last_name = 'Rugg, Linda Murphy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Heart of the Matter', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1948, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Graham' AND last_name = 'Greene'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Man of Fifty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1818, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Johann' AND last_name = 'Wolfgang von Goethe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Early Medieval Europe 300-1000', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1991, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Roger' AND last_name = 'Collins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('I Am Charlotte Simmons', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Tom' AND last_name = 'Wolfe'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('blink', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Malcolm' AND last_name = 'Gladwell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Seize the Day', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Saul' AND last_name = 'Bellow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Children of Paradise', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1990, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lee' AND last_name = 'Hausner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('In the American Grain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1925, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Carlos Williams'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Killer Angels', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1974, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Shaara'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sound of a Wild Snail Eating', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elisabeth' AND last_name = 'Tova Bailey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On China', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Kissinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Felix Holt: The Radical', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1866, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'George' AND last_name = 'Eliot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Winston Spencer Churchill The Last Lion Part 2 - Alone. 1932-40', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Manchester'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Revenge of Geography', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2012, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'D. Kaplan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Fortunate Pilgrim', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mario' AND last_name = 'Puzo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Voltaire in Love', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1957, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Nancy' AND last_name = 'Mitford'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Revolutionary Biology - The New Gene- Centered View of Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2001, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Barash'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Catherine the Great', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'K Massie'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The House in Paris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1935, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elizabeth' AND last_name = 'Bowen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Daily Rituals - How Artists Work', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mason' AND last_name = 'Currey'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Genius and Character', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1927, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Emil' AND last_name = 'Ludwig'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('France Under the Germans', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1995, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Phillippe' AND last_name = 'Burrin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Street of Crocodiles', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1934, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bruno' AND last_name = 'Schulz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Bing Crosby - The Hollow Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Donald' AND last_name = 'Shepherd'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Distant Mirror', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1978, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Barbara' AND last_name = 'W. Tuchman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cosmos', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1967, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Witold' AND last_name = 'Gombrowicz'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('1493', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'C. Mann'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Do Androids Dream of Eletric Sheep?', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1968, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Philip' AND last_name = 'K. Dick'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Law of Divine Compensation', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2012, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marianne' AND last_name = 'Williamson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The War That Ended Peace', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'Macmillan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Benito Cereno', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1855, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Herman' AND last_name = 'Melville'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Duel', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1891, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anton' AND last_name = 'Chekhov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Cosmopolis', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Don' AND last_name = 'DeLillo'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Life of Barbara Stanwyck', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Victoria' AND last_name = 'Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Invisible Bridge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julie' AND last_name = 'Orringer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dissident Gardens', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Lethem'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Thinking About Science:Max Delbruck & the Origins of Molecular Biology', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1988, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ernst' AND last_name = 'Fischer, Carol Lipson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('When I Was A Child I Read Books', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2012, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marilynne' AND last_name = 'Robinson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Dear Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2012, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alice' AND last_name = 'Munro'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Little Women', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1868, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Louisa' AND last_name = 'May Alcott'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Month in the Country', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.L.' AND last_name = 'Carr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('World Order', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Henry' AND last_name = 'Kissinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Deerslayer', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1841, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Fenimore Cooper'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Kingdom of God is Within You', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1893, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Leo' AND last_name = 'Tolstoy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Fifties', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Edmund' AND last_name = 'Wilson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Watch Me', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anjelica' AND last_name = 'Huston'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Redeployment', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Phil' AND last_name = 'Klayn'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Virgin Soil', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1877, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ivan' AND last_name = 'Turgenev'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Struggle', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2009, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Karl' AND last_name = 'Ove Knausgaard'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Time of Gifts', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1977, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Patrick' AND last_name = 'Leigh Fermor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pictures From An Institution', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1952, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Randall' AND last_name = 'Jarrell'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('In Another Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Howard' AND last_name = 'Felperin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Mauve Decade', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1926, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Thomas' AND last_name = 'Beer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Little Dorrit', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1857, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Dickens'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Grown-Up Marriage', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Judith' AND last_name = 'Viorst'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Alexander Hamilton', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2004, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ron' AND last_name = 'Chernov'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Marketing to Millennials', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jeff' AND last_name = 'Fromm'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Deep in a Dream. The Long Night of Chet Baker', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Gavin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Wrong Side of Paris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1845, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honore' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('NeuroTribes.The Legacy of Autism', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Steve' AND last_name = 'Silberman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Human Comedy', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1840, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Honore' AND last_name = 'de Balzac'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Three Nights in August', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2005, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Buzz' AND last_name = 'Bissinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pete Rose. An American Dilemma', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Kostya' AND last_name = 'Kennedy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Moneyball', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Lewis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Freedom', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2010, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jonathan' AND last_name = 'Franzen'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Why Not Say What Happened', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2015, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Morris' AND last_name = 'Dickstein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Swerve', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stepen' AND last_name = 'Greenblatt'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Tempest', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1611, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'William' AND last_name = 'Shakespeare'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Days of Dylan Thomas', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1964, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'Read'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Lorna Doone', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1869, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'R.D.' AND last_name = 'Blackmore'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('J.S. Bach vol.two.', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1911, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Albert' AND last_name = 'Schweitzer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Prince of Privilege', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Madeline' AND last_name = 'Levine'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('White Girls', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Hilton' AND last_name = 'Als'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Guns of August', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Barbara' AND last_name = 'Tuchman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Art of Memoir', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2015, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'Karr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Everything That Rises Must Converge', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1965, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Flannery' AND last_name = 'O''Connor'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Crown of Feathers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Isaac' AND last_name = 'Bashevis Singer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Avid Reader', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Gottlieb'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Garden of Peace', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2008, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Rabbi' AND last_name = 'Shalom Arush'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Devil in the White City', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2003, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erik' AND last_name = 'Larson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Girl on the Train', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2015, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paula' AND last_name = 'Hawkins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last Interview', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Oliver' AND last_name = 'Sacks'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mutiny On the Bounty', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1932, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Nordhoff, James Norman Hall'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Little History Of Literature', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Sutherland'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Against The Current', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1985, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Frances' AND last_name = 'Kroll Ring'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Giovanni''s Room', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1956, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Baldwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Cake And The Rain', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jimmy' AND last_name = 'Webb'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last Interview', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.D.' AND last_name = 'Salinger'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('On Tyranny', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Timothy' AND last_name = 'Snyder'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Trump The Art of the Deal', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Donald' AND last_name = 'Trump'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('American Sphinx: The Character Of Thomas Jefferson', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1996, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joseph' AND last_name = 'J. Ellis'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Fire Next Time', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1962, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Baldwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Four Princes', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Julius Norwich'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Elizabeth', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Lisa' AND last_name = 'Hilton'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All Quiet On The Western Front', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1928, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erich' AND last_name = 'Maria Remarque'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Anti-Education', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1872, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Friedrich' AND last_name = 'Nietzsche'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Giant Of The Senate', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Al' AND last_name = 'Franken'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Days Of Abandonment', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2002, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elena' AND last_name = 'Ferrante'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Netochka Nezvanova', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1849, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Fyodor' AND last_name = 'Dostoyevsky'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Konundrum', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1914, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Franz' AND last_name = 'Kafka'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('My Name Is Lucy Barton', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Elizabeth' AND last_name = 'Strout'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How To Grow Old', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, -44, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cicero' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Ties', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Domenico' AND last_name = 'Starnone'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fire and Fury', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2018, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Michael' AND last_name = 'Wolff'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Oh Florida!', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Craig' AND last_name = 'Pittman'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Facism - a warning', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2018, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Madeleine' AND last_name = 'Albright'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How to Talk So Kids Will Listen & How to Listen So Kids Will Talk', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1980, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Adele' AND last_name = 'Faber & Elaine Mazlish'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Of Mice and Men', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1937, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'John' AND last_name = 'Steinbeck'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Sense of an Ending', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2011, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julian' AND last_name = 'Barnes'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Paul Simon, The Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2018, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Hilburn'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Masters of Deceit', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1958, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'J.' AND last_name = 'Edgar Hoover'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Story of a Shipwrecked Sailor', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gabriel' AND last_name = 'Garcia Marquez'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Modern Ethics in 77 Arguments', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Peter' AND last_name = 'Catapano'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('In Her Own Words', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2018, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ruth' AND last_name = 'Bader Ginsburg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Fear', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bob' AND last_name = 'Woodward'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Fountainhead', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1943, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ayn' AND last_name = 'Rand'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Widening Gyre', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1983, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Robert' AND last_name = 'Parker'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All the Light We Cannot See', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2014, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Anthony' AND last_name = 'Doerr'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('How to Think', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Alan' AND last_name = 'Jacobs'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Road', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2006, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cormac' AND last_name = 'McCarthy'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Killing the SS', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2018, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'O''Reilly'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The True Flag', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Stephen' AND last_name = 'Kinzer'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Healing the Soul of America', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1997, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Marianne' AND last_name = 'Williamson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Disordered Mind', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2018, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Eric' AND last_name = 'Kandel'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Walk in the Woods', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1981, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bill' AND last_name = 'Bryson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('No Is Not Enough', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2017, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Naomi' AND last_name = 'Klein'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Duel With The Devil', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2013, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Paul' AND last_name = 'Collins'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Team of Vipers', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Cliff' AND last_name = 'Sims'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Call Sign Chaos', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jim' AND last_name = 'Mattis, Bing West'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Handmaid''s Tale', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1986, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'Attwood'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Have You an Educated Heart', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1923, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Gelett' AND last_name = 'Burgess'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Devil’s Chessboard, Allen Dulles, the CIA and the Rise of America’s Secret Government', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2015, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Talbot'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Splendid and the Vile', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Erik' AND last_name = 'Larson'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Yes to Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Viktor' AND last_name = 'E. Frankl'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Hello Darkness, My Old Friend', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Sanford' AND last_name = 'D. Greenberg'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Too Much and Never Enough', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mary' AND last_name = 'L. Trump'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Leadership', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Doris' AND last_name = 'Kearns Goodwin'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Stanley Kubrick', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'Mikie'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Plaza', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Julie' AND last_name = 'Satow'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Life Isn’t Everything – Mike Nichols as Remembered by 150 of His Closest Friends', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ash' AND last_name = 'Carter and Sam Kashner'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Strongmen (Mussolini to the Present)', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Ruth' AND last_name = 'Ben-Ghiat'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Mike Nichols A Life', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2021, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mark' AND last_name = 'Harris'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Last American Aristocrat', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'David' AND last_name = 'S. Brown'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Jeeves and the Feudal Sprit', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1954, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'P.G.Wodehouse' AND last_name = ''
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Paris', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1919, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Margaret' AND last_name = 'MacMillan'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Music of Bach', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Charles' AND last_name = 'Terry'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Pygmalion', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1913, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bernard' AND last_name = 'Shaw'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Never Sit if You Can Dance', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2019, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Jo' AND last_name = 'Giese'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Peril', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2021, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Bob' AND last_name = 'Woodward, Robert Costa'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('A Gentleman in Moscow', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2016, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Amor' AND last_name = 'Towles'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('All About Me!', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2021, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Mel' AND last_name = 'Brooks'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Caravans', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1963, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'James' AND last_name = 'Michener'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('The Spiritual Growth of a Public Man', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 1973, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Abraham' AND last_name = 'Lincoln'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

WITH new_book AS (
  INSERT INTO book (book_title, isbn_code, category_id, copies_total, copies_available, published_year, description, cover_url)
  VALUES ('Saving Freedom', NULL, (SELECT category_id FROM category WHERE category_name = 'Uncategorized'), 1, 1, 2020, NULL, NULL)
  RETURNING book_id
),
auth AS (
  SELECT author_id FROM author WHERE first_name = 'Joe' AND last_name = 'Scarborough'
)
INSERT INTO book_author (book_id, author_id)
SELECT new_book.book_id, auth.author_id FROM new_book, auth;

COMMIT;