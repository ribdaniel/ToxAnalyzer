#!/usr/bin/perl
# Main.pl, part of the Final Project for Computational Modelling for Bioinformatics

use strict;
use warnings;
use LWP::Simple; # Library to access content over the internet

################################################# Obtendo a tabela do CTD
print "Type the name of a chemical compound: ";
my $input = <STDIN>;
chomp $input;
my $url = "http://ctdbase.org/tools/batchQuery.go?inputType=chem&inputTerms=$input&report=genes_curated&format=tsv";

print "Obtaining table from server... \n";
#sleep 2;

my $ctd_result = get($url);

#print "$ctd_result\n";

if ($ctd_result =~ /Object not found/){
   die "The database could not find the chemical you were looking for.
Either enter a valid chemical name or try again!\n"
}


########################################## Imprimindo a lista de genes e de organismos
#print "Printing gene list... \n";
#sleep 2;
my @genes = ();
my @ctd_lines = split(/\t/, $ctd_result);
for (my $lines = 12; $lines < (scalar(@ctd_lines)); $lines = $lines + 8)
{
  #print "$ctd_lines[$lines]\n";
  push (@genes, $ctd_lines[$lines]);

}
#print "@genes\n";

#print "\n\n";
#print "Printing organism list... \n";
#sleep 2;

my @organisms = ();
for (my $lines = 14; $lines < (scalar(@ctd_lines)); $lines = $lines + 8)
{
  chomp $lines;
  #print "$ctd_lines[$lines]\n";
  push (@organisms, $ctd_lines[$lines]);
}

#print "@organisms\n";
#print (scalar(@organisms));
#print "\n";
#print (scalar(@genes));
#print "\n";
#########################################################

#########################################################
my %number_of_genes; # gera a hash que armazena os organismos com o respectivo numero de genes

################################################################ Populando a hash

for (my $i = 0; $i < scalar(@organisms); $i++)
{
  $number_of_genes{$organisms[$i]} = 0;
  for (my $j = 0; $j < scalar(@organisms); $j++)
  {
    if ($organisms[$i] eq $organisms[$j])
    {
      $number_of_genes{$organisms[$i]}++;
    }
  }
}

delete $number_of_genes{""}; # deleta os genes que nao tem organismo com eles
my @temp = %number_of_genes;
print "@temp\n"; # printa as hashes

################################################################# gera um txt com os organismos e numero de genes
print "Gerando arquivo .txt...\n";
open (my $file, ">", $input."_organisms.txt") or die "Could not open $input.txt!\n";
foreach my $key (sort keys %number_of_genes) {
  print $file "$key";
  print $file "\t";
  print $file "$number_of_genes{$key}";
  print $file "\n";
}
close $file;

################################################################## gerando o arquivo R
print "Gerando arquivo .R...\n";
open (my $file, ">", $input."_organisms.R") or die "Could not open $input.R\n";
  print $file "library(ggplot2)";
  print $file "\n";
  #print $file "library(waffle)";
  #print $file "\n";
  print $file "var <- read.table(";
  print $file "'$input";
  print $file "_organisms.txt', header = FALSE, sep = ";
  print $file "'\\t')";
  print $file "\n";
  print $file "pdf('$input";
  print $file ".pdf')";
  print $file "\n";
  print $file "ggplot(var, aes(x=(var\$V1), y=(var\$V2))) + geom_bar(stat='identity') + labs(title='# of genes interacting with $input in different organisms',
  x='Organisms', y='# of genes') + coord_flip()";
  print $file "+ theme(axis.title= element_text(face='bold'))";
  print $file "\n";
  print $file "dev.off()";
close $file;
################################################################## chamando o script em R

my $temp = $input."_organisms.R";

print "Gerando gráficos...\n";
system("Rscript $temp");

##################################################################
