
# ARC Finder

## Preparation

### Make the **arcFinder** executable

```bash
chmod a+x arcFinder.sh
```

## Usage

### Public ARCs

```bash
./arcFinder.sh ## access to public ARCs only
```

### Public + privately shared ARCs

```bash
./arcFinder.sh -p <gitlab pat> ## access to shared, non-public ARCs. GitLab PAT supplied as file path or string
```