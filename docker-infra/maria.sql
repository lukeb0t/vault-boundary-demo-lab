CREATE DATABASE vaultdemo;
CREATE DATABASE vaultdemo_deny;

USE vaultdemo; 
 CREATE TABLE `contacts` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `Name` varchar(255) default NULL,
  `Email` varchar(255) default NULL,
  `Phone` varchar(100) default NULL,
  `Company` varchar(255),
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO `contacts` (`Name`,`Email`,`Phone`,`Company`) VALUES ("Wade Blanchard","est@non.net","1-945-260-1918","Mollis Vitae Foundation"),("Keefe Wall","ligula@tellusidnunc.com","1-587-134-2488","Ipsum Cursus Industries"),("Oren Cooke","Donec.nibh@necorciDonec.org","1-328-186-5991","Ut Ltd"),("Odysseus Beck","iaculis.nec.eleifend@anteMaecenasmi.net","1-567-611-9774","Sodales Mauris Corporation"),("Channing Poole","Nulla.tincidunt.neque@luctusetultrices.com","1-298-462-4296","Et Inc."),("Timothy Cantrell","Donec@pedeacurna.org","1-885-189-4080","Eu Foundation"),("Alec Mack","imperdiet.nec.leo@Fusce.net","1-390-611-2337","Ridiculus Company"),("Knox Leon","ornare@aliquet.net","1-816-404-2338","Ac Limited"),("Allen Craig","Vivamus.euismod.urna@liberoettristique.co.uk","1-109-183-5671","Ligula Eu Corp."),("Colt Klein","tortor.dictum.eu@mauris.co.uk","1-746-714-2751","Nibh Limited");
INSERT INTO `contacts` (`Name`,`Email`,`Phone`,`Company`) VALUES ("Barclay Flores","massa.rutrum.magna@metus.ca","1-337-552-0064","Hymenaeos LLP"),("Jackson Graves","hendrerit.neque.In@aliquetmetus.co.uk","1-350-740-2984","Commodo Tincidunt Nibh Corporation"),("Elijah Price","lectus@necmollis.com","1-583-566-4063","Aenean Ltd"),("Asher Avila","tellus.non.magna@maurissapien.org","1-130-588-2813","Posuere Enim Nisl LLP"),("Elvis Mccray","sem.Pellentesque.ut@velconvallis.net","1-709-707-9232","Aenean Gravida Foundation"),("Kareem Talley","a.sollicitudin@montesnasceturridiculus.co.uk","1-673-858-7841","Duis Company"),("Wallace Shannon","magna@anteiaculisnec.com","1-229-178-9854","Feugiat Limited"),("Ali Cantrell","justo.faucibus@fermentum.co.uk","1-318-296-2974","Nulla Integer Urna Industries"),("Ulysses Heath","rhoncus.Proin@egestas.com","1-497-805-7257","Magnis Dis Incorporated"),("Channing Schneider","commodo@duiFusce.com","1-464-978-6053","Libero Nec Ligula PC");
INSERT INTO `contacts` (`Name`,`Email`,`Phone`,`Company`) VALUES ("Eric Burnett","augue.malesuada.malesuada@nonenim.org","1-111-819-4764","Laoreet Ipsum Curabitur Limited"),("Octavius Fitzgerald","ultrices.posuere.cubilia@tortor.co.uk","1-620-967-9500","Faucibus Ut Nulla Corporation"),("Perry Parker","at.lacus.Quisque@vehiculaaliquetlibero.com","1-824-258-0112","Primis In Faucibus Institute"),("Kennedy Pena","torquent@lacinia.ca","1-372-789-3302","Proin Associates"),("Elmo Boone","malesuada.malesuada@libero.com","1-700-829-4136","In LLC"),("Silas Cunningham","ullamcorper@sodales.com","1-713-159-6990","Nibh Ltd"),("Vance Mack","quam.Pellentesque@penatibuset.com","1-618-724-3568","Metus Eu Erat LLC"),("Malachi Sanders","posuere.cubilia.Curae@dolorvitae.edu","1-678-270-2935","Vitae Dolor Donec Corp."),("Colby Huffman","montes@euodiotristique.ca","1-622-221-5377","Elementum At Egestas Inc."),("Trevor Patton","vel@duiaugueeu.ca","1-814-454-2862","Ridiculus Corporation");

FLUSH PRIVILEGES; 

CREATE USER vaultuser IDENTIFIED BY 'vaultpass';GRANT ALL PRIVILEGES ON *.* TO vaultuser;GRANT GRANT OPTION ON *.* to 'vaultuser';