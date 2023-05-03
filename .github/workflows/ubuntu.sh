name: Ubuntu

on:
  push:
    branches:
      - main

jobs:
  ubuntu:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Lint shell files
        run: ./lint_shell.sh
