
# ARC-Finder &ndash; A simple, locally-deployed tool to find your peer's research data

This is a tool to help you find metadata about ARCs stored in the DataPLANT [DataHUB](https://git.nfdi4plants.org/).
Visit the [DataPLANT website](<https://nfdi4plants.de>) for more information about ARCs (annotated research contexts).

## Usage

- Git clone or download this repository.
- Open a command line or terminal and navigate to the `arcFinder` directory.
- Run one of the following two options:

### Option 1: Search public ARCs only

```bash
./arcFinder.sh
```

### Option 2: Search Public + privately shared ARCs

> Note: Replace `<gitlab pat>` with the path pointing to a file which stores a GitLab personal access token (PAT).

```bash
./arcFinder.sh -p <gitlab pat>
```

### Registration with DataPLANT

In order to use the `<gitlab pat>` option, please follow these steps:

1. [Sign up](<https://register.nfdi4plants.org/>) with DataPLANT.
2. Generate a personal access token in the [DataHUB PAT settings](https://git.nfdi4plants.org/-/profile/personal_access_tokens)
   - Provide a "Token name", e.g. `arcFinder`
   - Select either option "api" or "read_api" and click "Create personal access token"
   - Copy the generated token on top of the page.
3. Paste the bare token into a text file and save it (e.g. `gitlab_token` stored in the root of this directory)
4. Supply the file path to `arcFinder`, e.g.:

```bash
./arcFinder.sh -p gitlab_token
```

## Documentation

- Read the [full project outline](docs/2022-06-10_arcFinder_project_brilhaus.pdf) for more details.
- Check out the [gif](https://github.com/Brilator/arcFinder/blob/main/docs/arcFinder_gif.md) to see the ARC-Finder in action

## License

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][https://i.creativecommons.org/l/by/4.0/88x31.png]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
