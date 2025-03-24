# obl2chyper

[obl2cypher](https://drive.google.com/file/d/1gtwlArg57U8J9rmWB_rakvKQf3jlUgFj/view?usp=sharing) is a Prolog library for converting OntoBroker .obl files into Neo4j Cypher.

## Installation

Place the obl2cphyer.pl and obl_grammar.pl in the folder you wish to generate the Cypher output.

## Usage

```prolog
consult ('obl2cypher.pl').

% writes the Cypher code (OutputFile.txt) to the directory obl2cypher.pl is in.
write_matches_to_file('InputFile.obl', 'OutputFile.txt').
```

## License

Proprietary. Use other than to view requires a license from [Tolga Keskinoglu](mailto:viva.tolga@gmail.com).