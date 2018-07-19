#!/usr/bin/perl
#

open OLD, "../monotherapy/mono_therapy_spread_test.txt" or die;
## first drug 2 then drug 1.;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	$i=1;
	while ($i<6){
		$ref{$drug2}{$cell}{$i}+=$table[$i];
		$count{$drug2}{$cell}{$i}++;
		$i++;
	}
	$i=6;
	while ($i<11){
		$ref{$drug1}{$cell}{$i}+=$table[$i];
		$count{$drug1}{$cell}{$i}++;
		$i++;
	}
}
close OLD;

open OLD, "../monotherapy/mono_therapy_spread_test.txt" or die;
open NEW, ">../monotherapy/mono_therapy_spread_diff_test.txt" or die;
open NEW1, ">../monotherapy/mono_therapy_spread_reverse_diff_test.txt" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	print NEW "$table[0]";
	print NEW1 "$table[0]";
	
	$i=1;
	while ($i<6){
		$avg=$ref{$drug2}{$cell}{$i}/$count{$drug2}{$cell}{$i};
		$val=$table[$i]-$avg;
		print NEW "\t$val";
		$i++;
	}
	$i=6;
	while ($i<11){
		$avg=$ref{$drug1}{$cell}{$i}/$count{$drug1}{$cell}{$i};
		$val=$table[$i]-$avg;
		print NEW "\t$val";
		$i++;
	}



	$i=6;
	while ($i<11){
		$avg=$ref{$drug1}{$cell}{$i}/$count{$drug1}{$cell}{$i};
		$val=$table[$i]-$avg;
		print NEW1 "\t$val";
		$i++;
	}
	$i=1;
	while ($i<6){
		$avg=$ref{$drug2}{$cell}{$i}/$count{$drug2}{$cell}{$i};
		$val=$table[$i]-$avg;
		print NEW1 "\t$val";
		$i++;
	}



	print NEW "\n";
	print NEW1 "\n";
}
close NEW;
close NEW1;
