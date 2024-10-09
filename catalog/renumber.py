#!/usr/bin/env python
# This script renumbers the projects in the catalog.json file to ensure a continuous monotonic sequence of project numbers:
# * load the catalog.json file from the current directory
# * sort the catalog data by id
# * iterate over the sorted data while also counting the number of projects in the catalog
# * if the current project id is different than expected, the update the project number:
#   * calculate the expected path to the .catalog_metadata file in the project directory determined by the relative_path
#   * read the .catalog_metadata file
#   * update the project number in the .catalog_metadata file
#   * write the updated .catalog_metadata file

import json
import os

def load_catalog():
  with open('catalog.json', 'r') as file:
    return json.load(file)

def save_catalog(catalog):
  with open('catalog.json', 'w') as file:
    json.dump(catalog, file, indent=4)

def update_metadata_file(project, new_id):
  metadata_path = os.path.join('..', project['relative_path'], '.catalog_metadata')
  with open(metadata_path, 'r') as file:
    metadata = json.load(file)

  metadata['id'] = new_id

  with open(metadata_path, 'w') as file:
    json.dump(metadata, file, indent=4)

def renumber_projects():
  catalog = load_catalog()
  catalog.sort(key=lambda x: x['id'])

  for new_id, project in enumerate(catalog, start=1):
    new_id = f"#{new_id:03}"
    if project['id'] != new_id:
      update_metadata_file(project, new_id)
      project['id'] = new_id

  # save_catalog(catalog)

if __name__ == "__main__":
  renumber_projects()
