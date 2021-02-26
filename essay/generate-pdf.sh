pandoc index.md --toc --number-sections \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V geometry:margin=2cm \
    -o outfile.pdf
