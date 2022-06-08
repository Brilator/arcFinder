
rm final.md
touch final.md

cat project.md >> final.md

printf "\n## arcFinder.sh\n\n" >> final.md
printf '```bash\n' >> final.md
cat ../arcFinder.sh >> final.md
printf '```\n' >> final.md

printf "\n## scripts/01_install_dependencies.R\n\n" >> final.md
printf '```R\n' >> final.md
cat ../scripts/01_install_dependencies.R >> final.md
printf '```\n' >> final.md

printf "\n## scripts/01_restore_dependencies.R\n\n" >> final.md
printf '```R\n' >> final.md
cat ../scripts/01_restore_dependencies.R >> final.md
printf '```\n' >> final.md

printf "\n## scripts/02_read_from_gitlab.sh\n\n" >> final.md
printf '```bash\n' >> final.md
cat ../scripts/02_read_from_gitlab.sh >> final.md
printf '```\n' >> final.md

printf "\n## scripts/scripts/03_parse_isaInvxlsx.R\n\n" >> final.md
printf '```R\n' >> final.md
cat ../scripts/03_parse_isaInvxlsx.R >> final.md
printf '```\n' >> final.md

printf "\n## scripts/scripts/03_pull_together.R\n\n" >> final.md
printf '```R\n' >> final.md
cat ../scripts/03_pull_together.R >> final.md
printf '```\n' >> final.md

printf "\n## scripts/scripts/05_pull_together_sql.R\n\n" >> final.md
printf '```R\n' >> final.md
cat ../scripts/05_pull_together_sql.R >> final.md
printf '```\n' >> final.md

printf "\n## scripts/scripts/04_searchApp/app.R\n\n" >> final.md
printf '```R\n' >> final.md
cat ../scripts/04_searchApp/app.R >> final.md
printf '```\n' >> final.md

pandoc final.md -o 2022-06-10_arcFinder_project_brilhaus.pdf --from markdown --template eisvogel --listings 
