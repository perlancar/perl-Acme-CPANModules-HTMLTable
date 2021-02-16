package Acme::CPANModules::HTMLTable;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
#use utf8;

sub _make_table {
    my ($cols, $rows, $celltext) = @_;
    my $res = [];
    push @$res, [];
    for (0..$cols-1) { $res->[0][$_] = "col" . ($_+1) }
    for my $row (1..$rows) {
        push @$res, [ map { $celltext // "row$row.$_" } 1..$cols ];
    }
    $res;
}

our $LIST = {
    summary => 'Modules that generate HTML tables',
    entry_features => {
    },
    entries => [
        {
            module => 'Text::Table::Any',
            description => <<'_',

This is a common frontend for many text table modules as backends,
L<Text::Table::HTML> being one.

_
            bench_code => sub {
                my ($table) = @_;
                Text::Table::Any::table(rows=>$table, header_row=>1, backend=>'Text::Table::HTML');
            },
            features => {
            },
        },

        {
            module => 'Text::Table::HTML',
            bench_code => sub {
                my ($table) = @_;
                Text::Table::HTML::table(rows=>$table, header_row=>1);
            },
            features => {
            },
        },

        {
            module => 'Text::Table::HTML::DataTables',
            bench_code => sub {
                my ($table) = @_;
                Text::Table::HTML::DataTables::table(rows=>$table, header_row=>1);
            },
            features => {
            },
        },

        {
            module => 'Text::Table::Manifold',
            bench_code => sub {
                my ($table) = @_;
                my $t = Text::Table::Manifold->new(format => Text::Table::Manifold::format_html_table());
                $t->headers($table->[0]);
                $t->data([ @{$table}[1 .. $#{$table}] ]);
                join("\n", @{$t->render(padding => 1)}) . "\n";
            },
            features => {
            },
        },

    ], # entries

    bench_datasets => [
        {name=>'tiny (1x1)'          , argv => [_make_table( 1, 1)],},
        {name=>'small (3x5)'         , argv => [_make_table( 3, 5)],},
        {name=>'wide (30x5)'         , argv => [_make_table(30, 5)],},
        {name=>'long (3x300)'        , argv => [_make_table( 3, 300)],},
        {name=>'large (30x300)'      , argv => [_make_table(30, 300)],},
    ],

};

1;
# ABSTRACT:

=head1 SEE ALSO

L<Acme::CPANModules::TextTable>
