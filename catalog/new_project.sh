#!/bin/bash
#
# A simple script to initialise a new project
#


function usage() {
  cat <<EOF

Make a new project workspace..

Usage:
  $0 kr ProjectName  # new Kraft project

EOF
  exit
}

function make_project() {
  # full_project_name=Part1/Part2
  # full_path=Kinetics/Part1/Part2
  # parent_folder = Kinetics/Part1
  # project_name = Part2
  local full_project_name=$2
  local full_path="${1}/${full_project_name}"
  local parent_folder=$(dirname "$full_path")
  local project_name=$(basename "$full_path")

  mkdir -p ${full_path}
  mkdir ${full_path}/assets

  local readme_file="${full_path}/README.md"
  echo "making ${readme_file}"
  cat > "${readme_file}" <<EOS
# #xxx ${full_project_name}

__subtitle__

![Build](./assets/${project_name}_build.jpg?raw=true)

Here's a quick demo..

[![clip](https://img.youtube.com/vi/video_id/0.jpg)](https://www.youtube.com/watch?v=video_id)

## Notes

__notes__

### Research and References

### The Kit

### Paint Scheme

| Feature               | Color                | Recommended | Paint Used |
|-----------------------|----------------------|-------------|------------|
|                       |                      |             |            |

### Build Log

![build01a](./assets/build01a.jpg?raw=true)

## Credits and References

* [this project on scalemates](xxx)
* [name](url)
* [name](url)
* [name](url)
EOS

  local catalog_file="${full_path}/.catalog_metadata"
  echo "making ${catalog_file}"
  cat > "${catalog_file}" <<EOS
{
    "id": "#xxx",
    "name": "${project_name}",
    "description": "description",
    "categories": "",
    "relative_path": "${full_path}"
}
EOS

  cp catalog/templates/cover1440x400.jpg ${full_path}/assets

  local backup_root=${LITTLEMODELART_ASSET_BACKUP}
  if [ "${backup_root}" != "" ]; then
    local backup_path="${backup_root}/${full_path}"
    echo "Making asset backup path: ${backup_path}"
    mkdir -p ${backup_path}
    mkdir ${backup_path}/demo
    mkdir ${backup_path}/hires
    mkdir ${backup_path}/trash
    cp catalog/templates/1080p_bg.* ${backup_path}/demo
  fi

  echo "project initialised: ${full_path}"
}


op=${1:-help}

case ${op} in

kr)
  make_project "projects" "${2}"
  ;;

*)
  usage
  ;;

esac
