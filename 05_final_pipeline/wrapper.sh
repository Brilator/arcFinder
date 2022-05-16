


# 1. PAT input

# 2. run gitlab reader

# 3. run xlsx parser

## store paths into variable 
find .tmp_investigations/ -name '*.xlsx'

## while loop
extract project id from first path


invs=$(find .tmp_investigations/ -name '*.xlsx')
echo "$invs" | while IFS= read -r current_inv;
do 
  echo $current_inv | cut -d/ -f3 | cut -d"_" -f1
  echo $current_inv

done


