# CCHDO_I08S
Data files from I08S CCHDO 1994, 2007 and 2016 expeditions (https://cchdo.ucsd.edu/search?q=I08S)
merged into a long-format csv.
The data file is `ctd_data.csv`.
For more information on its content and an analysis,
check paper with DOI 10.1126/sciadv.1601426.

# On building `ctd_data.csv`

In scripts, it is supposed that the data were downloaded using the "exchange"
version in the "ctd" section of the CCHDO data repo and unzipped into folders
`~/goship/1994`, `~/goship/2007` and `~/goship/2016`.

The tables-only files for each year were obtained with commands like `~/goship/get_tables.sh 1994`.
The columns of interest are 1st (pressure), 3rd (temperature), 5th (salinity) and 7th (oxygen).
Such commands save the tables on files starting with `new_*` and ending with the name of the original file name.

Coordinates for each file were obtained with the scripts in the `coordinates`
folder and merged into `lat_lon.csv` with the `wide2long.R` R script.

Finally, `merge.R` builds the `ctd_data.csv` file.
