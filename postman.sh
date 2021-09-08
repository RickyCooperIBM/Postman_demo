#!/bin/bash

newman run "Trello.postman_collection.json"


- name: commit-and-push
  plan:
  - get: newman-repo
  - task: commit
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: concourse/buildroot
          tag: git

      inputs:
      - name: newman-repo

      outputs:
      - name: newman-modified-repo

  - put: newman-repo  
    params: {repository: newman-modified-repo}
    run:
        path: /bin/bash
        args:
        - -c
        - |
          set -eux

          git clone newman-repo newman-modified-repo

          cd newman-modified-repo

          git add .

          git config --global user.name "YOUR NAME"
          git config --global user.email "YOUR EMAIL ADDRESS"

          git commit -m "Changed some-file.txt"

        - put: newman-repo   
          params: {repository: newman-modified-repo}