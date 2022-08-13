#!usr/bin/perl

use strict;
use warnings;

my $file = "$ARGV[0]";

open(FH, '<', $file) or die "Erro ao abrir o arquivo. $!";

my $string;

while(<FH>){
	$string .= $_;
}

my $poemas = () = $string =~ /.\n{3}./g;
my $versos = () = $string =~ /.\n.|.\n{2}.|.\n{3}./g;
my $estrofes = () = $string =~ /.\n{2}.|.\n{3}./g;
my $sextilhas = () = $string =~ /\n{2}\N+\n\N+\n\N+\n\N+\n\N+\n\N+((?=\n{2})|$)/g;
my $sonetos = () = $string =~ /\n{3}\N+\n\N+\n\N+\n\N+\n{2}\N+\n\N+\n\N+\n\N+\n{2}\N+\n\N+\n\N+\n{2}\N+\n\N+\n\N+(\n{5}|$)/g;

print "Numero total de poemas: $poemas\n";
print "Numero total de versos: $versos\n";
print "Numero total de estrofes: $estrofes\n";
print "Numero de estrofes sextilha: $sextilhas\n";
print "Numero de sonetos: $sonetos\n\n";

my $sizeVersos;
my $sizeEstrofes;
my $sizePoemas;
my $contChar = () = $string =~ /\S/g;
my $titulos = () = (join(' ', $string =~ /.+(?=\n\n\n.)/g) =~ /\S/g);

$sizeVersos = sprintf('%.1f', ($contChar - $titulos) / $versos);
$sizeEstrofes = sprintf('%.1f', ($contChar - $titulos) / $estrofes);
$sizePoemas = sprintf('%.1f', ($contChar - $titulos / $poemas));

print "Tamanho medio dos versos: $sizeVersos caracteres.\n";
print "Tamanho medio das estrofes: $sizeEstrofes caracteres.\n";
print "Tamanho medio dos poemas: $sizePoemas caracteres\n";

close(FH);