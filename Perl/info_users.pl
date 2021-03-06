#!/usr/bin/perl -w
#   
#   Nom du script : info_users.pl 
# 
# Lecture du fichier passwd
use DBI;
use warnings;

# Connexion à la base de données comptes_linux
$dsn = "DBI:mysql:comptes_linux";
$username = "root"; 
$password = "crosemont";
$dbh = DBI->connect( $dsn, chomp($username), chomp($password),
                        { RaiseError => 1, AutoCommit => 0});

# Exeécution des instructions mysql en utilisant le module DBI
$sth = $dbh->prepare("SELECT * FROM users"); # sth = Statement Handle Object
print "Entrez un des critères selon lequel afficher les résultats [nom, uid, gid ou programme]: ";
chomp($user_input = <STDIN>);
# La fonction uppercase (UC) permet d'ignorer la casse
if (uc($user_input) eq "NOM") {
		$sth->execute(nom_user)
	} elsif (uc($user_input) eq "UID") {
		$sth->execute(id_user)
	} elsif (uc($user_input) eq "GID") {
		$sth->execute(id_group)
	}elsif (uc($user_input) eq "PROGRAMME") {
		$sth->execute(exec)
	} else { 
		print "Erreur       :  Veuillez entrer un des choix proposés.\n";
		print "Choix permis :  nom | uid | gid | programme\n";
};

while (@row = $sth->fetchrow_array){
    print ("@row");
}
#$dbh->disconnect;
